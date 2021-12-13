---
title: "Problem set 9"
linktitle: "Problem set 9"
date: "2021-11-15"
due_date: "2021-11-26"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 9
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

## Task 1 - Repeated measure one-way ANOVA

Complete this assignment in teams of 2 to 4 students. Submit a single PDF report per group and indicate the name of your other teammates.

We consider Study 2 of Bobak et al. (2019); see [paper](https://doi.org/10.1186/s41235-019-0174-3) and [helper code](/content/10-repeated-measures.R). Perform a repeated measure ANOVA with `color` as within-factor.

1.  Model diagnostics
    -   Produce normal quantile-quantile plots of the random effects and of the residuals. Comment on the assumption in light of the graphical diagnostics.
    -   Produce a Tukey-Anscombe plot (residuals versus fitted values). Is there evidence of departure from the linearity assumption?
    -   Check for group heterogeneity using Levene’s test. Report the conclusion of that test.
    -   Is there evidence against the hypothesis of sphericity? Report Mauchly’s test and the conclusion of the latter.
    -   If there is no evidence (large `\(p\)`-value), proceed as usual
    -   Otherwise, use Greenhouse-Geisser adjustment for the degrees of freedom of the tests below
2.  Testing
    -   Are there differences overall between color match (monochrome, mixed or colored)? Report the `\(F\)`-statistic, the degrees of freedom and the `\(p\)`-value and an effect size ($R^2_p$).
    -   If there is a significant difference at the 5% level, perform pairwise tests with Tukey’s pairwise multiplicity correction. Report the values and `\(t\)`-test statistics.
3.  Graphical representation:
    -   Create a plot of the average proportion of correct matches as a function of the color match.
    -   Add one standard error bars around the mean.

Note: the standard error should be that of the response variable, so based on the total variance. You can use the `VarCorr` method to extract the estimated variance from an object fitted with `lmer`: if you saved the fitted object under `model`, then `print(VarCorr(model), comp = "Variance")` will print the variances.

The following code produces the plot:

``` r
# Suppose you have fitted a lmer model
# Get the fitted means
fmean <- predict(model,
        newdata = tibble(color = unique(bobak$color),
                         pnum = 999), 
        # dummy id not found
        allow.new.levels = TRUE)
# Variance of random effect and residuals
fvar <- as.data.frame(VarCorr(model, comp = "Variance"))$vcov
# Use this data frame for the plot
data_plot <- tibble::tibble(mean = fmean,
               color = unique(bobak$color),
               se = sqrt(sum(fvar)),
               lower = fmean - se,
               upper = fmean + se)
library(ggplot2)               
ggplot(data = data_plot, 
       mapping = aes(x = color, 
                     y = fmean)) + 
  geom_point() + 
  geom_errorbar(aes(ymin = lower, 
                    ymax = upper)) +
  theme_classic() +
  labs(x = "color match", y = "percentage of correct match")
```

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Bobak:2019" class="csl-entry">

Bobak, A. K., Mileva, V. R., & Hancock, P. J. B. (2019). A grey area: How does image hue affect unfamiliar face matching? *Cognitive Research: Principles and Implications*, *4*(1), 27. <https://doi.org/10.1186/s41235-019-0174-3>

</div>

</div>
