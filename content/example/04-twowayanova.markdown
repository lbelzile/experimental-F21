---
title: "Two-way analysis of variance"
linktitle: "4. Two-way ANOVA"
date: "2021-10-20"
menu:
  example:
    parent: Examples
    weight: 4
type: docs
toc: true
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

# Videos

The code created in the video [can be downloaded here](/example/04-twowayanova-video.R).

There’s a set of videos that walks through each section below. To make it easier for you to jump around the video examples, I cut the long video into smaller pieces and included them all in [one YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb).

-   [Analysis of variance](https://www.youtube.com/watch?v=pxQgRTWwITI&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)
-   [Interaction plots](https://www.youtube.com/watch?v=rYudu_vns6I&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)
-   [Contrast and marginal means](https://www.youtube.com/watch?v=0ifni3rNOss&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)
-   [Effect size and power](https://www.youtube.com/watch?v=jcqpe3Z-YNs&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

# Notebook

We reproduce the results of Study 1 of Maglio & Polman (2014). Data were obtained from

> We carried out a 2 (orientation: toward, away from) × 4 (station: Spadina, St. George, Bloor-Yonge, Sherbourne) analysis of variance (ANOVA) on closeness ratings

``` r
# Reproduction of Spatial Orientation Shrinks and Expands Psychological Distance
# by Maglio and Polman (2014), Psychological Science
# Data from "https://osf.io/846cb/download"
library(tidyverse)
# Name of subway stations
labs <- c("Bloor-Yonge", "Sherbourne", "Spadina", "St. George")
# Order of stations from West to East is 
# Spadina > St. George > Bay > Bloor-Yonge > Sherbourne
olabs <- c("Spadina", "St. George", "Bloor-Yonge", "Sherbourne")
data <- read_csv("https://edsm.rbind.io/data/MaglioPolman2014S1.csv",
                 col_types = "fiff") %>%
  # STN_NUMBER redundant with STN_NAME
  transmute(station = fct_relevel(factor(STN_NAME, labels = labs), olabs),
            direction = factor(DIRECTION, labels = tolower(levels(DIRECTION))),
            distance = DISTANCE)

# A 5x2 factorial design (two-way ANOVA)
options(contrasts = c("contr.sum", "contr.poly"))
model <- lm(distance ~ station*direction, data = data)
summary(model)
```

    ## 
    ## Call:
    ## lm(formula = distance ~ station * direction, data = data)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -2.6538 -0.6400  0.1154  0.3913  2.8077 
    ## 
    ## Coefficients:
    ##                     Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)          2.65916    0.07294  36.458  < 2e-16 ***
    ## station1             0.48776    0.12587   3.875 0.000146 ***
    ## station2            -0.45455    0.12587  -3.611 0.000388 ***
    ## station3            -0.75866    0.12771  -5.941 1.29e-08 ***
    ## direction1           0.04109    0.07294   0.563 0.573870    
    ## station1:direction1  0.46584    0.12587   3.701 0.000280 ***
    ## station2:direction1  0.52353    0.12587   4.159 4.79e-05 ***
    ## station3:direction1 -0.33289    0.12771  -2.607 0.009853 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.036 on 194 degrees of freedom
    ## Multiple R-squared:  0.3813, Adjusted R-squared:  0.359 
    ## F-statistic: 17.08 on 7 and 194 DF,  p-value: < 2.2e-16

``` r
car::Anova(model, type = "3")
```

    ## Anova Table (Type III tests)
    ## 
    ## Response: distance
    ##                    Sum Sq  Df   F value    Pr(>F)    
    ## (Intercept)       1426.15   1 1329.1917 < 2.2e-16 ***
    ## station             77.58   3   24.1005 2.665e-13 ***
    ## direction            0.34   1    0.3173    0.5739    
    ## station:direction   52.41   3   16.2832 1.765e-09 ***
    ## Residuals          208.15 194                        
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
# Interaction plot 
# average of each subgroup, with +/- 1 std. error

data %>%
  group_by(direction, station) %>%
  summarize(mean = mean(distance),
            se = sigma(model) / sqrt(n()),
            lower = mean - se,
            upper = mean + se) %>%
  ggplot(mapping = aes(x = station,
                       y = mean, 
                       group = direction,
                       col = direction)) + 
  geom_line() +
  geom_errorbar(aes(ymin = lower, 
                    ymax = upper),
                width = 0.2) +
  geom_point() +
  theme_classic() +
  theme(legend.position = "top") + 
  scale_colour_grey() +
  labs(y = "subjective distance",
       x = "subway station",
       col = "direction of travel")
```

    ## `summarise()` has grouped output by 'direction'. You can override using the `.groups` argument.

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png)

``` r
library(emmeans)
emm <- emmeans(model, specs = c('direction', 'station'))
emmeans(model, specs = "direction", by = "station")
```

    ## station = Spadina:
    ##  direction emmean    SE  df lower.CL upper.CL
    ##  east        3.65 0.203 194     3.25     4.05
    ##  west        2.64 0.207 194     2.23     3.05
    ## 
    ## station = St. George:
    ##  direction emmean    SE  df lower.CL upper.CL
    ##  east        2.77 0.203 194     2.37     3.17
    ##  west        1.64 0.207 194     1.23     2.05
    ## 
    ## station = Bloor-Yonge:
    ##  direction emmean    SE  df lower.CL upper.CL
    ##  east        1.61 0.216 194     1.18     2.03
    ##  west        2.19 0.203 194     1.79     2.59
    ## 
    ## station = Sherbourne:
    ##  direction emmean    SE  df lower.CL upper.CL
    ##  east        2.77 0.203 194     2.37     3.17
    ##  west        4.00 0.207 194     3.59     4.41
    ## 
    ## Confidence level used: 0.95

``` r
pairw <- contrast(emm, by = "station", method = "pairwise")
p.adjust(summary(pairw)$p.value, method = "holm")
```

    ## [1] 0.0011778638 0.0004099985 0.0504602138 0.0001371920

``` r
# custom contrasts
custom_contrast <- list(SpadinaEvsW = c(1, -1, rep(0, 6)),
                        symmetry = c(1, -1, 1, -1, 1, -1, 1, -1))
confint(contrast(emm, 
         method = custom_contrast,
         adjust = "scheffe",
         infer = TRUE), scheffe.rank = 7)
```

    ##  contrast    estimate    SE  df lower.CL upper.CL
    ##  SpadinaEvsW    1.014 0.290 194  -0.0872     2.11
    ##  symmetry       0.329 0.584 194  -1.8855     2.54
    ## 
    ## Confidence level used: 0.95 
    ## Conf-level adjustment: scheffe method with rank 7

``` r
# Scheffe's method has an argument scheffe.rank ng-1

# Effect size and power
library(effectsize)
# sigmasq_{AB} / (sigmasq_{AB} + sigmasq_{res})
omsq <- omega_squared(model)$Omega2_partial
cohensf <- sqrt(omsq / (1 - omsq))
```

    ## Warning in sqrt(omsq/(1 - omsq)): Production de NaN

``` r
# Power calculations
library(WebPower)
wp.kanova(ndf = 3, f = cohensf[3], ng = 8, power = 0.8)
```

    ## Multiple way ANOVA analysis
    ## 
    ##            n ndf      ddf         f ng alpha power
    ##     52.46239   3 44.46239 0.4764222  8  0.05   0.8
    ## 
    ## NOTE: Sample size is the total sample size
    ## URL: http://psychstat.org/kanova

``` r
wp.kanova(ndf = 3, f = 0.3381892, ng = 8, alpha = 0.01, power = 0.99)
```

    ## Multiple way ANOVA analysis
    ## 
    ##            n ndf      ddf         f ng alpha power
    ##     266.5917   3 258.5917 0.3381892  8  0.01  0.99
    ## 
    ## NOTE: Sample size is the total sample size
    ## URL: http://psychstat.org/kanova

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Maglio/Polman:2014" class="csl-entry">

Maglio, S. J., & Polman, E. (2014). Spatial orientation shrinks and expands psychological distance. *Psychological Science*, *25*(7), 1345–1352. <https://doi.org/10.1177/0956797614530571>

</div>

</div>
