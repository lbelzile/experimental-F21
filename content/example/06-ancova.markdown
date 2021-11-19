---
title: "Analysis of covariance"
linktitle: "6. Analysis of covariance"
date: "2021-11-03"
menu:
  example:
    parent: Examples
    weight: 6
type: docs
toc: true
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

<!--
# Videos



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

The code [can be downloaded here](/example/06-ancova-video.R).

# Notebook

We consider data from Baumann et al. (1992), who conducted experiments on different teaching methods for reading. The authors randomized assignment to each of the three groups, but to account for potential differences in reading abilities, also administered tests before the experiment took place. Quoting Baumann et al. (1992)

> To statistically account for students’ pre-experimental differences in comprehension monitoring abilities, two pretests were constructed, administered, and used as covariates in data analyses for Post-tests 1-3.

We consider post-test 2, consisting of comprehension monitoring questionnaire. A similar test was assigned prior to the experiment, with minor modifications

> Three additional items were added to Pretest 2 and several others were revised so that there was better coverage and balance…

In this demonstration, we simply focus on `posttest2` as a function of `pretest2` and the `group` indicator.

``` r
## Load packages and set global options
suppressPackageStartupMessages(library(tidyverse))
library(emmeans)
options(contrasts = c("contr.sum", "contr.poly"))
theme_set(theme_classic()) # set theme globally for ggplot
## Load data
url <- "https://edsm.rbind.io/data/reading.csv"
reading <- read.csv(url, header = TRUE)
# Check the data
glimpse(reading)
```

    ## Rows: 66
    ## Columns: 6
    ## $ group     <chr> "DR", "DR", "DR", "DR", "DR", "DR", "DR", "DR", "DR", "DR", …
    ## $ pretest1  <int> 4, 6, 9, 12, 16, 15, 14, 12, 12, 8, 13, 9, 12, 12, 12, 10, 8…
    ## $ pretest2  <int> 3, 5, 4, 6, 5, 13, 8, 7, 3, 8, 7, 2, 5, 2, 2, 10, 5, 5, 3, 4…
    ## $ posttest1 <int> 5, 9, 5, 8, 10, 9, 12, 5, 8, 7, 12, 4, 4, 8, 6, 9, 3, 5, 4, …
    ## $ posttest2 <int> 4, 5, 3, 5, 9, 8, 5, 5, 7, 7, 4, 4, 6, 8, 4, 10, 3, 5, 5, 3,…
    ## $ posttest3 <int> 41, 41, 43, 46, 46, 45, 45, 32, 33, 39, 42, 45, 39, 44, 36, …

``` r
reading <- reading %>% mutate(group = factor(group))
# Check whether data are balanced
with(reading, table(group))
```

    ## group
    ##   DR DRTA   TA 
    ##   22   22   22

## Graphical representation

This section can be omitted upon first reading. We may want to compare the scores prior and post-intervention graphically to get a sense of the improvement for groups and check that the randomization was properly conducted. One way to look at the data is a longitudinal measurement (time ordered). Thus, we could draw line segments joining `pre` and `post` scores, with a different color for each group. To do this, we first combine the data in long format (one response per line) by making `prior` and `posts` into a single column labelled `score`. Then, we map the two categorical variables (`time` and `group`) to the `\(x\)`-axis and colour, respectively. Since the scores are discrete, points are jittered horizontally and vertically to avoid overlay.

``` r
reading_long <- reading %>%
  # keep only useful columns
  select(group, posttest2, pretest2) %>% 
  # add a new column with id for person
  rowid_to_column("id") %>% 
  # rename response
  rename(post = posttest2, 
         pre = pretest2) %>%
  # pivot data (response in score, columns to labels)
  pivot_longer(cols = c("pre","post"),
               values_to = "score",
               names_to = "time") %>%
  # Make new labels to factor
  mutate(time = relevel(factor(time), ref = "pre"))

# Spaghetti plot
ggplot(data = reading_long,
       mapping = aes(x = time,
                     color = group,
                     group = id,
                     y = score)) +
  # Add point for observation with small jittering
  geom_point(size = 0.5,
             position = position_jitter(width = 0.02, 
                                        height = 0.25, 
                                        seed = 123)) + 
  # The values were selected after trial and error
  # set seed so that ponts and segments are moved by same amount
  # Draw a line between pre and post scores
  geom_line(alpha = 0.2,
            position = position_jitter(width = 0.02, 
                                       height = 0.25, 
                                       seed = 123)) +
  # Add average per group (pre/post) and draw lines
  stat_summary(aes(group = group),
               fun = "mean",
               geom = "line",
               size = 1.2) +
  # Reduce space left-right of pre-post
  scale_x_discrete(expand = c(0, 0.1)) +
  theme(legend.position = "bottom")
```

<img src="/example/06-ancova_files/figure-html/scatterplot-1.png" width="672" />

The graphical display indicates a larger increase for the teaching aloud (`TA`) group, but the two other (directed reading and the hybrid method) seem on par. There is no discernible difference in strength between experimental condition prior to the experiment, but not the two strong grades in the DR group (who do worse).

## Analysis of variance vs analysis of covariance

In this simple setting, we begin by comparing the drop in variability (leading to an increase in power) for the analysis of covariance. We thus set up a linear model with

`$$\mathsf{E}(\texttt{post}_{ir}) = \mu + \alpha_i + \beta \texttt{pre}_{ir}$$`
with `\(\mathsf{Va}(\texttt{post}_{ir})=\sigma^2\)`. We can view this model as a one-way analysis of variance for `\(\texttt{post}_{ir} - \beta \texttt{pre}_{ir}\)`, with the difference that we estimate the coefficient `\(\beta\)` based on the data. Under our usual sum-to-zero, `\(\mu\)` is the global average of the residual scores and `\(\alpha_i\)` is the difference between group `\(i\)` and this average, with the constraint `\(\alpha_{\texttt{DR}} + \alpha_{\texttt{DRTA}} + \alpha_{\texttt{TA}}=0\)`.

``` r
# Model the scores on tests 2
model1 <- lm(posttest2 ~ group + pretest2, data = reading)
# Model assumes parallel slopes with equal differences
anova(model1)
# Only look for the difference between groups
model2 <- lm(posttest2 ~ group, data = reading)
anova(model2)
# Compare the mean squared residuals
# and the p-value for group
```

<table class="kable_wrapper">
<caption>
Table 1: Analysis of variance tables for Model 1 (ANCOVA, left) and Model 2 (ANOVA, right).
</caption>
<tbody>
<tr>
<td>

| term      |  df | sum of squares | F statistic | p-value |
|:----------|----:|---------------:|------------:|--------:|
| group     |   2 |          95.12 |        8.88 |  0.0004 |
| pretest2  |   1 |          24.22 |        4.52 |  0.0375 |
| Residuals |  62 |         332.19 |             |         |

</td>
<td>

| term      |  df | sum of squares | F statistic | p-value |
|:----------|----:|---------------:|------------:|--------:|
| group     |   2 |          95.12 |        8.41 |   6e-04 |
| Residuals |  63 |         356.41 |             |         |

</td>
</tr>
</tbody>
</table>

We can compare the one-way ANOVA model (Model 1) with the analysis of covariance (Model 2). In the present context, either are valid but one measures the average, the other some form of improvement between two time periods. About one fifth of the explained variability is due to pretest. Here, the impact of group is significant and so the inclusion of a covariate made no difference.

## Contrasts

The study focused on the comparison between the business-as-usual scenario (`DA`) and the average of the other two methods. They also compared the relative effectiveness of `DA` vs `DRTA`. We can compute marginal means and compute these contrasts as usual.

Because we assume the difference post-pre is the same on average (the slope between groups is the same), the difference between group is the same regardless of the score on the pre-test. The marginal means are computed at the average of `prettest2` score.

The two contrasts we have correspond to `\(\mathscr{H}_{01}: \mu_{\texttt{DR}} = (\mu_{\texttt{DRTA}} + \mu_{\texttt{TA}})/2\)` and `\(\mathscr{H}_{02}: \mu_{\texttt{DRTA}} = \mu_{\texttt{TA}}\)`, which can be rewritten with weights `\((2, -1, -1)\)` and `\((0, 1, -1)\)` assuming that the groups are ordered in alphabetical order. The two contrasts are orthogonal so use disjoint bits of information thanks to the conditioning. We proceed below with Holm–Bonferroni’s correction (for two tests), but we would normally need to filter out these `\(p\)`-values and perform the corrections with all other tests.
The effect size for the contrasts are obtained by dividing by the estimated variance for the residuals, `\(\widehat{\sigma}^2\)`, which is smaller for the ANCOVA model since part of the variability is explained by students strength, captured through `prettest2`.

``` r
# Marginal means and planned contrasts
# Groups are in alphabetical order, so (DR, DRTA, TA)
planned_contrasts <-
  list(c1 = c(2, -1, -1), #H0: DR = average(DRTA, TA)
       c2 = c(0, 1, -1))  #H0: DRTA = TA
contrasts1 <- 
  contrast(emmeans(model1, specs = "group"),
         method = planned_contrasts,
         p.adjust = "holm")
# Measure of effect size
cohens_d <- emmeans::eff_size(contrasts1,
                  method = "identity",
                  sigma = sigma(model1),
                  edf = df.residual(model1))
```

<table class="kable_wrapper">
<caption>
Table 2: Preplanned contrasts for Model 1 (ANCOVA, left) and Model 2 (ANOVA, right); `c1` denotes the comparison between control (`DR`) and average of other methods, while `c2` is the pairwise comparison between `DRTA` and `TA`.
</caption>
<tbody>
<tr>
<td>

| contrast | estimate |   se |  df | t statistic | p-value |
|:---------|---------:|-----:|----:|------------:|--------:|
| c1       |    -3.64 | 1.21 |  62 |       -3.01 |  0.0038 |
| c2       |    -2.17 | 0.70 |  62 |       -3.11 |  0.0028 |

</td>
<td>

| contrast | estimate |   se |  df | t statistic | p-value |
|:---------|---------:|-----:|----:|------------:|--------:|
| c1       |    -3.50 | 1.24 |  63 |       -2.82 |  0.0065 |
| c2       |    -2.14 | 0.72 |  63 |       -2.98 |  0.0041 |

</td>
</tr>
</tbody>
</table>

The values for the contrasts show that `\(p\)`-values have been reduced by 30% to 40%, so while there are clear differences in treatment, it could help increase the power in more borderline cases. The estimated Cohen’s `\(d\)` measure for contrast 1 is -1.57 (95% CI: -2.65, -0.49) for Model 1 (ANCOVA), versus -1.47 (95% CI: -2.55, -0.4) for Model 2 (ANOVA). These confidence interval are unadjusted, but are narrower with the added covariate. The estimated effect size is large, and the upper bounds for the effect imply a medium-sized effect at the very least.

## Testing model assumptions

By design, observations are independent and the randomization was well performed; our quick graphical depiction of the data showed that there were no difference in mean apriori.

### Linearity: effect of covariate is linear

The analysis of covariance is a linear model, so inherits a set of assumptions. The first assumption is linearity, which means here that the relationship between pre- and post-tests is well described by a straight line. We can produce a scatterplot of the data to check this, but usually one looks at the residuals from the model (the difference between the observation and its estimated average, or fitted value `\(e_i=\texttt{posttest2}_i - \widehat{\texttt{posttest2}}_i\)`. These are uncorrelated with `\(\texttt{pretest2}_i\)`, so the plot should show no pattern (trends, cycles, quadratic trend, etc.)

``` r
library(patchwork) # combine plots
g1 <- ggplot(data = reading, 
       mapping = aes(x = pretest2, y = posttest2)) + 
  geom_point(position = position_jitter(width = 0.1, 
                                        height = 0.1, 
                                        seed = 80667)) + 
  geom_smooth(method = "lm", se = FALSE)
reading_aug <- reading %>%
  mutate(.resid = resid(model1), # observation minus fitted
         .rstudent = rstudent(model1), 
         # studentized resid. (equal variance)
         .fitted = fitted(model1)) # fitted values yhat
g2 <- ggplot(data = reading_aug,
             aes(x = pretest2,
                 y = .resid)) + 
  geom_point() +
  geom_smooth() + # Fit local trend to detect patterns
  labs(x = 'ordinary residuals')
g1 + g2
```

<div class="figure">

<img src="/example/06-ancova_files/figure-html/anovamodelslin-1.png" alt="Scatterplot of pre and post intervention tests (left) and scatterplot of ordinary residuals against covariate pre-test2, with LOESS curve (right)." width="672" />
<p class="caption">
Figure 1: Scatterplot of pre and post intervention tests (left) and scatterplot of ordinary residuals against covariate pre-test2, with LOESS curve (right).
</p>

</div>

``` r
# To save for a publication
# ggsave("scatterplot.pdf", plot = g1, width = 5, height = 5)
```

Since the measurements are discrete and scarce, it is hard to see much but this assumption is reasonable. An added line (local fit, LOESS) is added to help detect departures from linearity but be careful not to over-interpret the graphs. Another way to see this is to create replicate data by permuting residuals (a form of graphical test); if we can easily detect the dataset from the list, then there may be residual structure (otherwise the patterns are due to sampling variability). For example, could you spot the true residuals from the 20 panels?

<div class="figure">

<img src="/example/06-ancova_files/figure-html/nullabor-1.png" alt="Panels with 20 replicate datasets obtained by permuting residuals. The true data is in position 16." width="672" />
<p class="caption">
Figure 2: Panels with 20 replicate datasets obtained by permuting residuals. The true data is in position 16.
</p>

</div>

### Linearity: are the slopes the same?

The second part of the linearity assumption lies in the assumption that the linear trend for pre-test and post-test is the same for each group. If they were different, we would have an interaction (between a categorical and a continuous variable). We can use the `\(F\)` test to compare the model with and without interaction

``` r
model3 <- lm(posttest2 ~ group*pretest2, data = reading)
anova(model1, model3)
```

The `\(p\)`-value is 0.9, so there is no evidence that the slopes are not parallel.

### Test for equality of variance

Another assumption of the linear model is that of constant variance. In analysis of variance models, we specify that each (sub)group has its own mean, but that the variance `\(\sigma^2\)` of the measurements is constant. This is useful because we can pool all observations to more reliably estimate it if the assumption holds true. If it isn’t true, what we obtain is some average of small and large variance, and this impacts our power (comparing groups with small variance).

If we move away from equal variance, what is the alternative? For one, we could simply estimate a different variance for each level of the experimental factors. For one-way designs, it’s pretty clear how this could be modelled, but there is more choice in complex factorial designs: should we have a different variance per row? or by column? or let each cell have its own variance? The more variance we estimate, the more we need to have observations per cell. Moving away from equal variance has also some consequences: when we talked about effect size, we looked at proportion of variance relative to the variance of the residual (which now depends on the group) or for Cohen’s `\(d\)` at standardized mean difference (which have no analog).

If we want to check that the variance are equal, we can use Levene’s test. There is a catch: normally, Levene’s test is just a one-way ANOVA where for (sub)group `\(i\)` and replication `\(r\)`, we use as response the absolute value of the centered observations, `\(|Y_{ir} - \widehat{\mu}_i|\)`, as input to the model. With continuous covariates included, an alternative is to instead perform a test but with the detrended values, or use the absolute value of the ordinary residuals `\(|Y_{ir} - \widehat{Y}_{ir}|\)`.

``` r
car::leveneTest(resid(model1) ~ group,
                data = reading,
                center = mean)
```

|       |  df | statistic | p-value |
|:------|----:|----------:|--------:|
| group |   2 |      1.48 |    0.23 |
|       |  63 |           |         |

Fitting a variance per group and doing a comparison between group mean is oftentimes referred to as Welch’s ANOVA. If we are only interested in the global null, the function `oneway.test()` does this assuming by default unequal variance. This only returns the `\(F\)` statistic for the global null hypothesis `\(\mu_{\texttt{DR}} = \mu_{\texttt{DRTA}} = \mu_{\texttt{TA}}\)`.

``` r
lm_detrend <- lm(posttest2 ~ pretest2, 
                       data = reading)
oneway.test(resid(lm_detrend)~ group, 
            data = reading)
```

## Models with different variance per group

If we wanted to do pairwise comparisons or look at custom contrasts, we need rather a more explicit model in which the mean and variance differ by group, using the `nlme` package. The argument `weights` is used to specify the variance.[^1]

``` r
model_samevar <- nlme::gls(posttest2 ~ group + pretest2,
                     data = reading)
model_diffvar <- nlme::gls(posttest2 ~ group + pretest2,
                    data = reading,
                    weights = nlme::varIdent(form =  ~ 1 | group))
```

The syntax `nlme::varIdent(form =  ~ 1 | group)` specifies that the variance is constant (`~ 1`) and differs per experimental `group`.
The first benefit of this approach is that we get another test of equality of variance; this is a likelihood ratio test, where we are using the normality assumption to fit the model and make comparisons. Comparison of two nested models (thing Russian dolls) that have the same specification for the mean can be done using our `anova` function

``` r
anova(model_diffvar, model_samevar)
# compute likelihood ratio test
```

In large samples and under normality, the likelihood ratio statistic follows a `\(\chi^2_{g-1}\)` distribution, where `\(g\)` is the number of groups.[^2] From the table, we can extract the value of the test statistic (`L.Ratio`), which is 4.65. We compare this to the null `\(\chi^2_2\)` distribution, giving a tail probability of 0.098; there is weak evidence of heterogeneity.

The benefit of using this framework is that `emmeans` will recognize the unequal variance and use them accordingly for computing The `\(t\)`-test values for the contrasts have non-integer degrees of freedom, since the null distribution is intractable; however, the Student-$t$ distribution provides a reasonable approximation if we evaluate it at a particular value for the degrees of freedom, a method know as Satterthwaite’s approximation. See this mention in the output of the method.

``` r
contrast(emmeans(model_diffvar, specs = "group"),
         method = planned_contrasts,
         p.adjust = "holm")
```

    ##  contrast estimate    SE   df t.ratio p.value
    ##  c1          -3.64 1.095 51.7  -3.329  0.0016
    ##  c2          -2.18 0.757 38.0  -2.875  0.0066
    ## 
    ## Degrees-of-freedom method: satterthwaite

## Robust and sandwich estimators

The drawback of the above approach is that one needs to specify a model for the variance, but sometimes the pattern of heteroscedasticity (from the Greek, meaning unequal variance) is complex: it could be that larger measurements have larger variability, or that the variance decreases over time as the experimenter gets better at making measurements. A popular approach in econometrics and social sciences is to use robust standard errors (sometime called White’s standard error, or sandwich error).

To be continued

## Robusts tests

If the distribution of the residuals is asymmetric, skewed, heavy-tailed and contaminated with outliers, etc., the usual methods for AN(C)OVA won’t necessarily deliver robust findings as a single observation can alter the conclusion. There are a plethora of alternatives to mitigate the impact of extremes of outliers, which are often found under the vocable ‘robust’ statistics.

A popular alternative is to replace observations by their rank; suppose we have measurements for the response of 2.1, 5.3 and 6.7 in group 1 and 10.1, 3.2 and 4.4 in group 2. The ranks of the pooled sample would be 1 (as 2.1 is the smallest observation), 4 and 5 for group 1, versus 6, 2 and 3 for group 2. The benefit of ranks is that the impact of extremes are strongly diminished (whether I replace the first observation of group 2, 10.1 by 1000, its rank is unchanged).
We could proceed with a robust ANOVA by replacing our response with the rank and computing the average ranking; this amounts if `\(n>20\)` or so to using Wilcoxon test for two samples, or to using

# References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Baumann:1992" class="csl-entry">

Baumann, J. F., Seifert-Kessell, N., & Jones, L. A. (1992). Effect of think-aloud instruction on elementary students’ comprehension monitoring abilities. *Journal of Reading Behavior*, *24*(2), 143–172. <https://doi.org/10.1080/10862969209547770>

</div>

</div>

[^1]: For the *connaisseur*, this model is fitted via restricted estimation maximum likelihood with a Gaussian likelihood; also termed generalized least squares hence the `gls` name for the function.

[^2]: This follows the general rule when comparing two nested models: the degrees of freedom are the difference between the number of parameters under the alternative (the more complicated model) and the null model (which we upon by setting restrictions on the alternative model).
