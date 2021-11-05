---
title: "Problem set 7"
linktitle: "Problem set 7"
date: "2021-11-05"
due_date: "2021-11-12"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 7
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

## Task 1 - Optimal sample allocation with unequal variance

**Updated instructions**
We consider for simplicity one experimental factor with two levels, `\(A\)` for treatment and `\(B\)` for control.
The variability of the mean difference between average of treatments `\(A\)` and `\(B\)` for `\(Y_{iA} \sim \mathsf{No}(\mu_A, \sigma_A^2)\)` `\((i=1, \ldots, n_A)\)` and `\(Y_{iB} \sim \mathsf{No}(\mu_B, \sigma_B^2)\)` is
`$$\begin{align*}\mathsf{Va}(\widehat{\mu}_A - \widehat{\mu}_B) &= \frac{\sigma^2_A}{n_A} + \frac{\sigma^2_B}{n_B}\\ &= \frac{\text{var of group }A}{\text{number of obs. in group }A} \\&\quad + \frac{\text{var of group }B}{\text{number of obs. in group }B}\end{align*}$$`
where `\(\mu_j\)` is the population mean, `\(\widehat{\mu}_j\)` the sample mean, `\(n_j\)` the sample size and `\(\sigma^2_j\)` the population variance in group `\(j\)`.

The following code calculates the standard error (as a function of the number of observations assigned to group `\(A\)`). If the variance is the same in each group, the optimal allocation consists in balancing the sample between the two groups.

``` r
stderror_pairwisediff <- function(nobs, sigmasqA, sigmasqB){
  nobs <- as.integer(nobs)
  stopifnot(nobs > 2, sigmasqA > 0, sigmasqB > 0)
  data.frame(
    nA = 1:(nobs-1),
    stderror = sqrt(sigmasqA/(1:(nobs-1)) + sigmasqB/((nobs-1):1))
  )
}
# Call function with placeholder arguments 
# TODO replace values sigmasqA and sigmasqB for Q2
data <- stderror_pairwisediff(nobs = 100, 
                              sigmasqA = 1, 
                              sigmasqB = 1) 
library(ggplot2) # load package
ggplot(data = data,
       mapping = aes(x = nA, y = stderror)) + 
  geom_line() +
  theme_classic() +
  labs(y = "std. error",
       x = paste("sample size for group A | n = ", 
                 max(data$nA) + 1L))
```

<div class="figure">

<img src="/evaluations/07-problem-set_files/figure-html/unnamed-chunk-1-1.png" alt="Standard error as a function of share of observations allocated to group A." width="672" />
<p class="caption">
Figure 1: Standard error as a function of share of observations allocated to group A.
</p>

</div>

``` r
# Optimal fraction of observations as a function of ratio of variance
optfrac <- function(var_ratio){
  #var_ratio <- sigmasqA / sigmasqB
  ifelse(var_ratio == 1, 
         0.5, # balanced
         (-var_ratio + sqrt(var_ratio))/(1 - var_ratio)) #unbalanced
 # (solution of a quadratic equation if sigmasqA != sigmasqB)
}
# Check calculation
# Empirical value - which value of nA coincides
#  with the smallest estimated std. error?
with(data, nA[which.min(stderror)]) / (nrow(data) + 1)
```

    ## [1] 0.5

``` r
# Optimal fraction 
# TODO enter ratio sigmasqA/sigmasqB below for Q2
optfrac(1)
```

    ## [1] 0.5

``` r
# plot of the optimal sample allocation (percentage) for the 
# groups as a function of the ratio of the variance (where A)
# has smaller variance
ggplot() + 
  stat_function(fun = optfrac, xlim = c(0.01,1)) +
  labs(y = "optimal fraction for allocation",
       x = expression(sigma[A]^2/sigma[B]^2)) +
  theme_classic()
```

<div class="figure">

<img src="/evaluations/07-problem-set_files/figure-html/unnamed-chunk-1-2.png" alt="Standard error as a function of share of observations allocated to group A." width="672" />
<p class="caption">
Figure 2: Standard error as a function of share of observations allocated to group A.
</p>

</div>

The purpose of the exercise is to investigate what happens if the variance are unequal.

1.  What is the best way to allocate a sample of 100 observations between the two groups if `\(\sigma^2_A = 1\)` and `\(\sigma^2_B = 4\)`? Replace the value of `sigmasqB` in the call to the function `stderror_pairwisediff` and in `optfrac`. Run the rest of the code to create a plot illustrating the standard error of the difference as a function of the number of observations assigned to treatment `\(A\)`.
2.  Look at the curve showing the optimum allocation as a function of the ratio of the variance `\(\sigma^2_A/\sigma^2_B\)` (we assume that the variability in group `\(A\)` is smaller than that of group `\(B\)`, meaning `\(0 <\sigma^2_A/\sigma^2_B \leq 1\)`, but we could interchange the labels of groups otherwise). Does the result shown in the graph surprise you?
3.  By how much does the standard error decreases if we increase the sample size hundred-fold, i.e., we go from 10 to 1 000 observations?
4.  Do you think we can act on the standard deviation terms (i.e., `\(\sigma_A\)` and `\(\sigma_B\)`) as experimenters? Why or why not?

## Task 2 - Critical review

Send in your paper for the [Critical review](evaluations/critical-review/) for approval; submit the PDF of the paper as attachment on ZoneCours.
