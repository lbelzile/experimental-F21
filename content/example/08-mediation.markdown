---
title: "Causal mediation"
linktitle: "8. Causal mediation"
date: "2021-11-25"
menu:
  example:
    parent: Examples
    weight: 8
type: docs
toc: true
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

<!--



# Videos

The code created in the video [can be downloaded here](/example/08-mediation-video.R).

There's a set of videos that walks through each section below. To make it easier for you to jump around the video examples, I cut the long video into smaller pieces and included them all in [one YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY).

- [Introduction](https://www.youtube.com/watch?v=SHhP_TfZGVM&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [Interaction plots](https://www.youtube.com/watch?v=I63CNxonlow&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [Marginal contrast and simple effects](https://www.youtube.com/watch?v=KLLBNQhD0rE&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [More contrasts and interactions](https://www.youtube.com/watch?v=WIoxZZ4pvlE&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [Effect size and power](https://www.youtube.com/watch?v=zBVX2RDjKUw&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

-->

# Notebook

The purpose of this example is twofold: first, we illustrate the Baron-Kenny approach (and generally the structural equation model approach to mediation under assumptions of no confounder or unmeasured variables with linear effects. The data are simulated from the postulated model, but serve to illustrate the skewness of the null distribution of Sobel’s statistic and to illustrate the nonparametric bootstrap scheme used in place of the normal approximation.

## Conceptual model

<div class="figure">

<img src="/example/08-mediation_files/figure-html/dagmodel-1.png" alt="Directed acyclic graph of the linear mediation analysis assuming no confounders with treatment `\(X\)` (e.g., an experimental factor), mediator `\(M\)` and response `\(Y\)`." width="100%" />
<p class="caption">
Figure 1: Directed acyclic graph of the linear mediation analysis assuming no confounders with treatment `\(X\)` (e.g., an experimental factor), mediator `\(M\)` and response `\(Y\)`.
</p>

</div>

The linear causal model assumed in, e.g., Baron & Kenny (1986), conditional on `\(X\)` is of the form

`\begin{align} (M \mid X) &= \mu_M + \alpha x + \varepsilon_M \tag{1}\\ (Y \mid X, M) &=  \mu_Y + \beta x + \gamma m + \varepsilon_Y \tag{2} \end{align}`
from which it follows that
`\begin{align} Y\mid X &= (\mu_Y + \gamma\mu_M) + (\beta + \alpha\gamma)\cdot X + (\gamma \varepsilon_M + \varepsilon_Y)\\ &= \mu_Y' + \pi X + \varepsilon_Y' \tag{3} \end{align}`

Pearl (2014) gives the example of encouragement design whereby the binary treatment `\(X\)` stands for a new educational program, the mediator `\(M\)` is the amount of homework and the response `\(Y\)` is the student score.

This simplistic causal model suggest that we can estimate the total causal effect of `\(X\)`, labelled `\(\tau\)`, by running the linear regression (3). In a completely randomized experimental design, there is no confounding affecting treatment `\(X\)` so this strategy is valid.

Baron and Kenny suggested for `\(X\)` and `\(M\)` continuous breaking down the task in three separate steps:

1.  fit a linear regression (1) of `\(M\)` on `\(X\)` to estimate `\(\alpha\)`
2.  fit a linear regression (3) of `\(Y\)` on `\(X\)` to estimate `\(\tau\)`
3.  fit a linear regression (2) of `\(Y\)` on `\(X\)` and `\(M\)` to estimate `\(\beta\)` and `\(\gamma\)`.

They then go to check that `\(\alpha, \delta, \gamma\)` are non-zero by testing the null hypotheses `\(\mathscr{H}_0: \alpha=0\)`, `\(\mathscr{H}_0: \delta=0\)` and `\(\mathscr{H}_0: \gamma=0\)` against the two-sided alternatives.

If `\(\alpha \gamma\)` is non-zero (because the terms in the product aren’t), then they consider building Sobel’s statistic with the product of estimators `\(\alpha \beta\)`, which is equivalent under no unmeasured confounders to the difference between the total effect `\(\tau\)` and the **natural direct effect** `\(\beta\)`.

Sobel’s statistic is
`\begin{align} S &= \frac{\widehat{\alpha}\cdot\widehat{\gamma}}{\sqrt{\widehat{\gamma}^2\mathsf{Va}(\widehat{\alpha}) + \widehat{\alpha}^2\mathsf{Va}(\widehat{\gamma}) + \mathsf{Va}(\widehat{\gamma})\mathsf{Va}(\widehat{\alpha})}}  \end{align}`

where `\(\widehat{\alpha}\)` and `\(\widehat{\gamma}\)` are ordinary least squares estimators with the corresponding variance estimators appearing in the denominator.[^1] The Sobel’s statistic `\(S\)` is approximately standard normal in large samples, but the approximation is sometimes crude.

To see this, let’s generate data

``` r
alpha <- 2
beta <- 0.5
gamma <- 0
n <- 100 # sample size
X <- rbinom(n = n, size = 1, prob = c(0.5, 0.5))
M <- alpha*X + rnorm(n)
Y <- beta*X + gamma*M + rnorm(n)
# Function that takes response, 
# treatment and mediator as inputs
# and return Sobel's stat
sobel <- function(data){
  stopifnot(is.data.frame(data),
            isTRUE(all(c("M","Y","X") %in% colnames(data))))
  # Regress M on X
  ols1 <- lm(M ~ X, data = data)
  ols2 <- lm(Y ~ X + M, data = data)
  ols3 <- lm(Y ~ X, data = data)
  # Extract estimates and their variances
  alpha_est <- coef(ols1)[2] # intercept, alpha
  alpha_var <- diag(vcov(ols1))[2]
  gamma_est <- coef(ols2)[3] # intercept, alpha
  gamma_var <- diag(vcov(ols2))[3]
  # Compute Sobel's stat
  sobel_val <- alpha_est * gamma_est / sqrt(alpha_est^2 * gamma_var + gamma_est^2 * alpha_var + alpha_var * gamma_var)
  c(estimate = alpha_est * gamma_est, 
    stat = sobel_val)
}
```

<div class="figure">

<img src="/example/08-mediation_files/figure-html/sobelsimu-1.png" alt="Null distribution of Sobel's statistic against approximate asymptotic normal distribution with `\(\alpha=0\)`, `\(\gamma=0.1\)` and Student(3) random errors." width="672" />
<p class="caption">
Figure 2: Null distribution of Sobel’s statistic against approximate asymptotic normal distribution with `\(\alpha=0\)`, `\(\gamma=0.1\)` and Student(3) random errors.
</p>

</div>

If we knew exactly the model that generated `\(X\)`, `\(M\)`, `\(Y\)` and the relations between them, we could simulate multiple datasets like in <a href="#fig:sobelsimu">2</a> and compared the test statistic we obtained with the simulation-based null distribution with `\(\alpha\gamma=0\)`. In practice we do not know the model that generated the data and furthermore we have a single dataset at hand.

Nowadays, the asymptotic approximation (sometimes misnamed delta method[^2]) has fallen out of fashion among practitioners, who prefer the nonparametric bootstrap coupled with the percentile method. The latter is conceptually easy to understand:

Repeat the following `\(B\)` times:
1) sample `\(n\)` observations, i.e., a tuple ($X_i, M_i, Y_i$, from the original data **with replacement**.
2) compute the natural indirect effect `\(\widehat{\alpha}\widehat{\gamma}\)` on each simulated sample

For a two-sided test at level `\(\alpha\)`, compute the `\(\alpha/2\)` and `\(1-\alpha/2\)` quantiles of the bootstrap statistics `\(\{\widehat{\alpha}_b\widehat{\gamma}_b\}_{b=1}^B\)`. If you have `\(\alpha=5\)`% and `\(B=1000\)` bootstrap samples, the interval bounds are the 25th and 975th ordered observations.

``` r
data <- data.frame(Y, X, M)
n <- nrow(data)
# Create a matrix to save statistics
boot_stats <- matrix(0, nrow = 1e4, ncol = 2)
# repeat B times
for(b in seq_len(nrow(boot_stats))){
  boot_samp <- data[sample.int(n = n, size = n, replace = TRUE),]
  boot_stats[b,] <- sobel(boot_samp)
}
# Statistic on original data
stat_ori <- sobel(data.frame(X = X, Y = Y, M = M))

# Compute 95% confidence intervals for alpha*gamma
# via percentile method
#  (Efron & Tibshirani, 1994 S13.3)
conf_interv <- quantile(boot_stats[,1], 
                       probs = c(0.025, 0.975))
# Plot distribution against data
ggplot(data = data.frame(stat = boot_stats[,1]),
       aes(x = stat)) +
  geom_histogram(aes(y = ..density..),
                 bins = 30) + 
  geom_vline(
    xintercept = c(conf_interv, stat_ori[1]),
    color = "red") +
  labs(x = "bootstrap statistic") +
  theme_classic()
```

<div class="figure">

<img src="/example/08-mediation_files/figure-html/bootstrap-1.png" alt="Bootstrap distribution of indirect effect with estimate and percentile 95% confidence intervals." width="672" />
<p class="caption">
Figure 3: Bootstrap distribution of indirect effect with estimate and percentile 95% confidence intervals.
</p>

</div>

The nonparametric percentile bootstrap confidence interval for `\(\alpha\gamma\)` is \[-0.12, 0.14\] and thus we fail to reject the null hypothesis of mediation `\(\mathscr{H}_0: \alpha \gamma=0\)` due to lack of power.

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Baron/Kenny:1986" class="csl-entry">

Baron, R., & Kenny, D. (1986). The moderator-mediator variable distinction in social psychological research: Conceptual, strategic, and statistical considerations. *Journal of Personality and Social Psychology*, *51*(6), 1173–1182. <https://doi.org/10.1037/0022-3514.51.6.1173>

</div>

<div id="ref-Pearl:2014" class="csl-entry">

Pearl, J. (2014). Interpretation and identification of causal mediation. *Psychological Methods*, *19*(4), 459–481. <https://doi.org/10.1037/a0036434>

</div>

</div>

[^1]: Sobel derived the asymptotic variance using a first-order Taylor series expansion assuming both `\(\alpha\)` and `\(\gamma\)` are non-zero (hence the tests!)

[^2]: The latter is the name of the method used to derive the denominator of Sobel’s statistic.
