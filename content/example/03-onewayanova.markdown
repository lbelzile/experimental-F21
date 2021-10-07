---
title: "One-way analysis of variance"
linktitle: "3. One way ANOVA"
date: "2021-09-29"
menu:
  example:
    parent: Examples
    weight: 3
type: docs
toc: true
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>

<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />

# Videos

The code created in the video [can be downloaded here](/example/01-onewayanova-video.R).

There’s a set of videos that walks through each section below. To make it easier for you to jump around the video examples, I cut the long video into smaller pieces and included them all in [one YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H).

-   [F-statistic table](https://www.youtube.com/watch?v=7ysgXYx6Rwg&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Contrasts and estimated marginal means](https://www.youtube.com/watch?v=KJ99KgeApNs&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Multiple testing](https://www.youtube.com/watch?v=dM1IkaVFy6w&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Effect size](https://www.youtube.com/watch?v=hD7HBU1EyDk&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Power](https://www.youtube.com/watch?v=W7mUTKruk_s&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

# Notebook

This notebook shows the various manipulation that an experimenter may undertake to test whether the population averages are the same based on some experimental data.

Recall the setup of [Example 1](/example/01-introduction).

## Hypothesis testing

We can begin by testing whether the group average for the initial measurements at the beginning of the study, prior to any treatment) have the same mean. Strong indication against this null hypothesis would be evidence of a potential problem with the randomization. We compute the one-way analysis of variance table, which includes quantities that enter the *F*-statistic (named after its large-sample null distribution, which is an *F*-distribution).[^1]

We use the `lm` function function to fit the model: an analysis of variance is a special case of linear model, in which the explanatory variables are categorical variables. The first argument of the function is a formula `response ~ treatment`, where `treatment` is the factor or categorical variable indicating the treatment.

The function `anova` is a method: when applied to the result of a call to `lm`, it produces an analysis of variance table including among other things the following information:

1.  the value of the test statistic (`F value`)
2.  the between and within sum of square (these are quantities that enter in the formula of the statistic)
3.  the degrees of freedom of the *F* null distribution (column `Df`): these specify the parameters of the large-sample approximation for the null distribution, which is our default benchmark.
4.  the mean square, which are sum of squares divided by the degrees of freedom.
5.  The *p*-value (`Pr(>F)`), which gives the probability of observing an outcome as extreme if there was no difference.

We need to decide beforehand the level of the test (typically 5% or lower): this is the percentage of times we will reject the null hypothesis when its true based on observing an extreme outcome. We are asked to perform a binary decision (reject or fail to reject): if the *p*-value is less than the level, we ‘reject’ the null hypothesis of equal (population) means.

``` r
mod_pre <- lm(formula = pretest1 ~ group,
                     data = reading)
anova_tab <- broom::tidy(anova(mod_pre))
# Save the output in a tibble to get more meaningful column names
# Elements include `statistic`, `df`, `p.value`
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 1: Analysis of variance table for pre-test 1
</caption>
<thead>
<tr>
<th style="text-align:left;">
Terms
</th>
<th style="text-align:right;">
Degrees of freedom
</th>
<th style="text-align:right;">
Sum of squares
</th>
<th style="text-align:right;">
Mean square
</th>
<th style="text-align:right;">
Statistic
</th>
<th style="text-align:right;">
p-value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
group
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
20.58
</td>
<td style="text-align:right;">
10.288
</td>
<td style="text-align:right;">
1.13
</td>
<td style="text-align:right;">
0.33
</td>
</tr>
<tr>
<td style="text-align:left;">
Residuals
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
572.45
</td>
<td style="text-align:right;">
9.087
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
</tr>
</tbody>
</table>

There isn’t strong evidence of difference in strength between groups prior to intervention. We can report the findings as follows:

We carried a one-way analysis for the pre-test results to ensure that the group abilities are the same in each treatment group; results show no significant differences at the 5% level ($F$ (2, 63) = 1.13, `\(p\)` = 0.329).

A similar result for the scores of the first post-test as response variable lead to strong evidence of difference between teaching methods.

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 2: Analysis of variance table for post-test 1
</caption>
<thead>
<tr>
<th style="text-align:left;">
Terms
</th>
<th style="text-align:right;">
Degrees of freedom
</th>
<th style="text-align:right;">
Sum of squares
</th>
<th style="text-align:right;">
Mean square
</th>
<th style="text-align:right;">
Statistic
</th>
<th style="text-align:right;">
p-value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
group
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
108.12
</td>
<td style="text-align:right;">
54.061
</td>
<td style="text-align:right;">
5.32
</td>
<td style="text-align:right;">
0.01
</td>
</tr>
<tr>
<td style="text-align:left;">
Residuals
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
640.50
</td>
<td style="text-align:right;">
10.167
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
</tr>
</tbody>
</table>

## Contrasts and estimated marginal means

While the `\(F\)` test may strongly indicate that the means ofeach group are different,
it doesn’t indicate which group is different from the rest.
Because we can compare different groups doesn’t mean these comparisons are of any
scientific interest and going fishing by looking at all pairwise differences is
not necessarily the best strategy.

``` r
library(emmeans) #load package
emmeans_post <- emmeans(object = mod_post, 
                        specs = "group")
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 3: Estimated group averages with standard errors and 95% confidence intervals for post-test 1.
</caption>
<thead>
<tr>
<th style="text-align:left;">
Terms
</th>
<th style="text-align:right;">
Marginal mean
</th>
<th style="text-align:right;">
Standard error
</th>
<th style="text-align:right;">
Degrees of freedom
</th>
<th style="text-align:right;">
Lower limit (CI)
</th>
<th style="text-align:right;">
Upper limit (CI)
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
DR
</td>
<td style="text-align:right;">
6.68
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
5.32
</td>
<td style="text-align:right;">
8.04
</td>
</tr>
<tr>
<td style="text-align:left;">
DRTA
</td>
<td style="text-align:right;">
9.77
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
8.41
</td>
<td style="text-align:right;">
11.13
</td>
</tr>
<tr>
<td style="text-align:left;">
TA
</td>
<td style="text-align:right;">
7.77
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
6.41
</td>
<td style="text-align:right;">
9.13
</td>
</tr>
</tbody>
</table>

Thus, we can see that `DRTA` has the highest average, followed by `TA` and directed reading (`DR`).
The purpose of Baumann et al. (1992) was to make a particular comparison between treatment groups.
From the abstract:

> The primary quantitative analyses involved two planned orthogonal contrasts—effect of instruction (TA + DRTA vs. 2 x DRA) and intensity of instruction (TA vs. DRTA)—for three whole-sample dependent measures: (a) an error detection test, (b) a comprehension monitoring questionnaire, and (c) a modified cloze test.

A **contrast** is a particular linear combination of the different groups,
i.e., a sum of weighted mean the coefficients of which sum to zero.
To test the hypothesis of Baumann et al. (1992) and writing `\(\mu\)` to denote the population average,
we have `\(\mathscr{H}_0: \mu_{\mathrm{TA}} + \mu_{\mathrm{DRTA}} = 2 \mu_{\mathrm{DRA}}\)`
or rewritten slightly
`$$\begin{align*} \mathscr{H}_0: - 2 \mu_{\mathrm{DR}} + \mu_{\mathrm{DRTA}} + \mu_{\mathrm{TA}} = 0. \end{align*}$$`
with weights `\((-2, 1, 1)\)`; the order of the levels for the treatment are
($\mathrm{DRA}$, `\(\mathrm{DRTA}\)`, `\(\mathrm{TA}\)`) and it must match that of the coefficients.
An equivalent formulation is `\((2, -1, -1)\)` or `\((1, -1/2, -1/2)\)`: in either case, the estimated differences will be different
(up to a constant multiple or a sign change).
The vector of weights for `\(\mathscr{H}_0:  \mu_{\mathrm{TA}} = \mu_{\mathrm{DRTA}}\)`
is, e.g.,($0$, `\(-1\)`, `\(1\)`): the zero appears because the first component, `\(\mathrm{DRA}\)` doesn’t appear.
The two contrasts are orthogonal: these contrasts are special because the tests use disjoint bits of information
about the sample.[^2]

``` r
# Identify the order of the level of the variables
with(reading, levels(group))
```

    ## [1] "DR"   "DRTA" "TA"

``` r
# DR, DRTA, TA (alphabetical)
contrasts_list <- list(
  "C1: DRTA+TA vs 2DR" = c(-2, 1, 1), 
  # Contrasts: linear combination of means, coefficients sum to zero
  # 2xDR = DRTA + TA => -2*DR + 1*DRTA + 1*TA = 0 and -2+1+1 = 0
  "C1b: average (DRTA+TA) vs DR" = c(-1, 0.5, 0.5), 
  #same thing, but halved so in terms of average
  "C2: DRTA vs TA" = c(0, 1, -1),
  "C2: TA vs DRTA" = c(0, -1, 1) 
  # same, but sign flipped
)
contrasts_post <- 
  contrast(object = emmeans_post,
           method = contrasts_list)
contrasts_summary_post <- 
  summary(contrasts_post)
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 4: Estimated contrasts for post-test 1.
</caption>
<thead>
<tr>
<th style="text-align:left;">
Contrast
</th>
<th style="text-align:right;">
Estimate
</th>
<th style="text-align:right;">
Standard error
</th>
<th style="text-align:right;">
Degrees of freedom
</th>
<th style="text-align:right;">
t statistic
</th>
<th style="text-align:right;">
p-value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
C1: DRTA+TA vs 2DR
</td>
<td style="text-align:right;">
4.18
</td>
<td style="text-align:right;">
1.67
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
2.51
</td>
<td style="text-align:right;">
0.01
</td>
</tr>
<tr>
<td style="text-align:left;">
C1b: average (DRTA+TA) vs DR
</td>
<td style="text-align:right;">
2.09
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
2.51
</td>
<td style="text-align:right;">
0.01
</td>
</tr>
<tr>
<td style="text-align:left;">
C2: DRTA vs TA
</td>
<td style="text-align:right;">
2.00
</td>
<td style="text-align:right;">
0.96
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
2.08
</td>
<td style="text-align:right;">
0.04
</td>
</tr>
<tr>
<td style="text-align:left;">
C2: TA vs DRTA
</td>
<td style="text-align:right;">
-2.00
</td>
<td style="text-align:right;">
0.96
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
-2.08
</td>
<td style="text-align:right;">
0.04
</td>
</tr>
</tbody>
</table>

We can look at these differences; since `DRTA` versus `TA` is a pairwise
difference, we could have obtained the `\(t\)`-statistic directly from the pairwise contrasts
using `pairs(emmeans_post)`. Note that the two different ways of writing the comparison between `DR` and the average of the other two methods yield different point estimates, but same inference (same `\(p\)`-values). For contrast `\(C_{1b}\)`, we get half the estimate (but the standard error is also halved) and likewise for the second contrasts we get an estimate of `\(\mu_{\mathrm{DRTA}} - \mu_{\mathrm{TA}}\)` in the first case ($C_2$) and `\(\mu_{\mathrm{TA}} - \mu_{\mathrm{DRTA}}\)`: the difference in group averages is the same up to sign.

What is the conclusion of our analysis of contrasts?
It looks like the methods involving teaching aloud have a strong impact on
reading comprehension relative to only directed reading. The evidence is not as strong
when we compare the method that combines directed reading-thinking activity and thinking aloud.

## Multiple testing

In this example, we computed two contrasts (excluding the equivalent formulations) so
since these comparisons are planned, we could provide the `\(p\)`-values as is. However, if
we had computed many more tests, it would make sense to account for these so as not to inflate type I error (judicial mistake consisting in sending an innocent to jail).

``` r
contrasts_list <- list(
  "C1: DRTA+TA vs 2DR" = c(-2, 1, 1), 
  "C2: DRTA vs TA" = c(0, 1, -1)
)
contrasts_post_scheffe <- 
  contrast(object = emmeans_post,
           method = contrasts_list,
           adjust = "scheffe") # for arbitrary contrasts
# extract p-values
pvals_scheffe <- summary(contrasts_post_scheffe)$p.value
pvals_scheffe
```

    ## [1] 0.04951625 0.12333575

``` r
# Compute Bonferroni and Holm-Bonferroni correction
contrasts_post <- 
  contrast(object = emmeans_post,
           method = contrasts_list,
           adjust = "none") #default for custom contrasts
raw_pval <- summary(contrasts_post)$p.value
p.adjust(p = raw_pval, method = "bonferroni")
```

    ## [1] 0.02920552 0.08313211

``` r
p.adjust(p = raw_pval, method = "holm")
```

    ## [1] 0.02920552 0.04156606

If we look at the *p*-values with the Scheffé’s method for custom contrasts, we get 0.015 for contrast 1 and 0.042 for contrast 2: since we are only making two tests here, these are much bigger than the `\(p\)`-values from Holm’s method which are 0.03 and 0.04. To try and avoid making type I error, we need to be more stringent to decide on rejection and this translates into bigger `\(p\)`-values, so lower power to detect. Try to use the less stringent method that still controls for the family wise error rate to preserve your power!

## Effect size

The `\(F\)`-statistic and the estimated contrasts are not on standardized scales: the score on post-test 1 depends on the number of inclusions and the estimated `\(t\)`-statistics would have been on average smaller if we had simply collected more information (because the more information, the more certain we are). These are not good measures of effect: for this, we want a standardized difference that is independent of the sample size. There are two class of standardized measures: percentage of variance explained ($\eta^2$, `\(\omega^2\)`) and measures of difference (Cohen’s `\(d\)` or `\(f\)`).

The **R** package `effectsize` allows for easy conversion between the different measures and provides estimates from the statistic along with confidence intervals, which is particularly useful. For example, if we wanted to compute Cohen’s `\(f\)` for the global test of equality of variance, we get

    ## Registered S3 methods overwritten by 'parameters':
    ##   method                           from      
    ##   as.double.parameters_kurtosis    datawizard
    ##   as.double.parameters_skewness    datawizard
    ##   as.double.parameters_smoothness  datawizard
    ##   as.numeric.parameters_kurtosis   datawizard
    ##   as.numeric.parameters_skewness   datawizard
    ##   as.numeric.parameters_smoothness datawizard
    ##   print.parameters_distribution    datawizard
    ##   print.parameters_kurtosis        datawizard
    ##   print.parameters_skewness        datawizard
    ##   summary.parameters_kurtosis      datawizard
    ##   summary.parameters_skewness      datawizard

    ## For one-way between subjects designs, partial eta squared is equivalent to eta squared.
    ## Returning eta squared.

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 5: Effect size for global test (post-test 1).
</caption>
<thead>
<tr>
<th style="text-align:left;">
Parameter
</th>
<th style="text-align:right;">
Cohen’s f
</th>
<th style="text-align:right;">
Confidence level
</th>
<th style="text-align:right;">
CI lower limit
</th>
<th style="text-align:right;">
CI upper limit
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
group
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
0.61
</td>
</tr>
</tbody>
</table>
<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 6: Effect size for contrasts (post-test 1).
</caption>
<thead>
<tr>
<th style="text-align:right;">
Omega-squared (partial)
</th>
<th style="text-align:right;">
Level of confidence interval
</th>
<th style="text-align:right;">
Lower limit
</th>
<th style="text-align:right;">
Upper limit
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.20
</td>
</tr>
<tr>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
0.9
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0.16
</td>
</tr>
</tbody>
</table>

This standardized quantity is hard to interpret (because it is unitless), but Cohen’s conventional effect size for such a test is 0.35 for large effects. Keep in mind that effect size are noisy (they are uncertain because they are based on a random sample, from which we try to extract a signal from some noise).

## Power

If we have an estimate of the power, we can try to see how many observations we would need to make sure that we detect a different 80%, 90% or 95% of the time. An alternative is to use the sample size and see what effect size we could detect for a given power. Generally, we can find one unknown if we specify any three of (1) the level `\(\alpha\)`, (2) the power, (3) the effect size and (4) the sample size. The calculation is made assuming balanced samples (the same number of individuals in each group), as this setup maximizes power if the variability of each group is the same.

If we consider Cohen’s `\(f\)` for the contrasts, obtainable via `effectsize::cohens_f(contrasts_parameters,)`, we can get a feeling for the potential size of the difference between the `DRTA` and `TA` methods. As a conservative estimate, plug-in the lower bound of Cohen’s `\(f\)` for the effect (0.04) and see how many observations are needed

``` r
# compute effect size with 22 observations
pwr::pwr.anova.test(k = 3,  # number of groups,
                    n = 22, # number of obs per group
                    power = 0.8) # power
```

    ## 
    ##      Balanced one-way analysis of variance power calculation 
    ## 
    ##               k = 3
    ##               n = 22
    ##               f = 0.3913463
    ##       sig.level = 0.05
    ##           power = 0.8
    ## 
    ## NOTE: n is number in each group

The effect size is difficult to measure and we often use conservative estimates (considering that effect sizes in the literature are inflated due to the publication bias). The following shows how one could proceed. Say we may be interesting in detecting average differences of two items correctly detected between DRTA and TA: if we divide by the estimated standard deviation ($\widehat{\sigma}=$ 3.19) of the post-test scores, we get a value of Cohen’s `\(d = (\mu_{\mathrm{DRTA}} - \mu_{\mathrm{TA}}) / \sigma\)`. If we replace the numerator by 2 items and plug-in \$ = 3.19, we get an effect size of \$=\$0.6269592. We can then plug-in this value and check how many more observations we need for a power of 90%.

``` r
power_contrasts <- 
  pwr::pwr.t.test(power = 0.9, # power
                  d = 0.627) # effect size 
plot(power_contrasts)
```

<img src="/example/03-onewayanova_files/figure-html/powercurve2-1.png" width="672" />

The answer is 55 observations per group, thus we need to more than triple the sample size to get this increase in power.
The nonlinear power curve clearly shows how power increases with the sample size: we don’t expect to catch small differences unless we had very large sample size.

## Model assumptions

Since we have no repeated measurements and there were no detectable difference apriori between students, we can postulate that the records are independent.

We could test whether the variance are equal: in this case, there is limited evidence of unequal variance.
The data are of course not normal (because they consist of the counts of the number of insertions detected by pupils, which are integer-valued). However, we can see if there are extreme values and whether the residuals are far from normal. The simulated quantile-quantile plot shows that all points more or less align with the straight line and all fall within the confidence intervals, so there is no problem with this normality assumption (which anyway matters little).

Are measurements additive? After assigning the pre-test 1, the experimenters adjusted the scale and made the post-test harder to avoid having maximum scores (considering that students also were more experienced).

> Because the students performed at a higher-than-expected level on Pretest 1 (61% of all intruded sentences were correctly identified), the experimenters were concerned about a potential post-intervention ceiling effect on this posttest, an occurrence which could mask group differences. To reduce the likelihood of a ceiling effect, the intruded sentences for Posttest 1 were written so their inconsistencies were more subtle than those included in Pretest 1, which explains the somewhat lower level of performance on Posttest 1 (51% of all intruded sentences correctly identified).

This seems to have been successful since the maximum score is 15 out of 16 intrusions, while there were two students who scored 16 on the pre-test.

``` r
# test for equality of variance
car::leveneTest(posttest1 ~ group, data = reading)
```

    ## Levene's Test for Homogeneity of Variance (center = median)
    ##       Df F value Pr(>F)
    ## group  2  2.1297 0.1273
    ##       63

``` r
# Quantile-quantile plot
car::qqPlot(mod_post, ylab = 'empirical quantiles')
```

<img src="/example/03-onewayanova_files/figure-html/testequalvariance-1.png" width="672" />

    ## [1] 57 63

``` r
# Residual plot (linearity, but useless for one way ANOVA)
car::residualPlot(mod_post)
```

<img src="/example/03-onewayanova_files/figure-html/testequalvariance-2.png" width="672" />

If we were worried about the possibility of unequal variances, we could fit the model by estimating the variance separately in each group. This does not materially change the conclusions about teaching methods relative to the directed reading benchmark.

``` r
oneway.test(posttest1 ~ group, data = reading)
```

    ## 
    ##  One-way analysis of means (not assuming equal variances)
    ## 
    ## data:  posttest1 and group
    ## F = 6.9878, num df = 2.00, denom df = 41.13, p-value = 0.00244

## Auxiliary and concomitant observation

The purpose of a good experimental design is to reduce the variability to better detect
treatment effects. In the above example, we could have added a concomitant variable (the pre-test score)
that captures the individual variability. This amounts to doing a paired comparison between post- and pre-test results.
It helps with the analysis because it absorbs the baseline strength of individual students: by subtracting their records, we get their individual average out of the equation and thus there is less variability.

``` r
anova_post_c <- lm(posttest1 ~ offset(pretest1) + group,
                   data = reading) 
anova_tab_c <- broom::tidy(anova(anova_post_c)) #anova table
```

Compare this ANOVA table with the preceding. We could repeat the same
procedure to compute the contrasts.

Using auxiliary information
allows one to reduce the intrinsic variability: the estimated variance `\(\widehat{\sigma}^2\)` is 6.66 with the auxiliary information and
9.09 without: since we reduce the level of background noise, we get a higher signal-to-noise ratio. As a result, the *p*-value for the global test is smaller than with only `posttest1` as response.

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 7: Analysis of variance table
</caption>
<thead>
<tr>
<th style="text-align:left;">
Terms
</th>
<th style="text-align:right;">
Degrees of freedom
</th>
<th style="text-align:right;">
Sum of squares
</th>
<th style="text-align:right;">
Mean square
</th>
<th style="text-align:right;">
Statistic
</th>
<th style="text-align:right;">
p-value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
group
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
168.21
</td>
<td style="text-align:right;">
84.106
</td>
<td style="text-align:right;">
12.64
</td>
<td style="text-align:right;">
0
</td>
</tr>
<tr>
<td style="text-align:left;">
Residuals
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
419.32
</td>
<td style="text-align:right;">
6.656
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
</tr>
</tbody>
</table>

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Baumann:1992" class="csl-entry">

Baumann, J. F., Seifert-Kessell, N., & Jones, L. A. (1992). Effect of think-aloud instruction on elementary students’ comprehension monitoring abilities. *Journal of Reading Behavior*, *24*(2), 143–172. <https://doi.org/10.1080/10862969209547770>

</div>

</div>

[^1]: The *F* stands for Fisher, who pioneered much of the work on experimental design.

[^2]: This technical term means that the two vectors defining the contrasts are orthogonal: their inner product is thus zero:
    `\((-2 \times 0) + (1 \times -1) + (1 \times 1) = 0\)`. In practice, we specify contrasts because they answer
    questions of scientific interest, not because of their fancy mathematical properties.
