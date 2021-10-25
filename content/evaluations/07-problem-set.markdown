---
title: "Problem set 6"
linktitle: "Problem set 6"
date: "2021-10-28"
due_date: "2021-11-09"
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

We consider for simplicity two treatments, `\(A\)` and `\(B\)`
The standard error of the average difference between treatment `\(A\)` and control `\(B\)` for `\(Y_{iA} \sim \mathsf{No}(\mu_A, \sigma_A^2)\)` `\((i=1, \ldots, n_A)\)` and `\(Y_{iB} \sim \mathsf{No}(\mu_B, \sigma_B^2)\)` is
`$$\mathsf{se}(\widehat{\mu}_A - \widehat{\mu}_B = \sqrt{ \frac{\widehat{\sigma}^2_A}{n_A} + \frac{\widehat{\sigma}^2_B}{n_B}}$$`
where `\(\sigma^2_A\)` and `\(\sigma^2_B\)` are the variance in each of the sub-populations.

``` r
# Function to estimate the standard error of a pairwise difference

stderror_pairwisediff <- function(nobs, sigmaA, sigmaB){
 nobs <- as.integer(nobs)
 stopifnot(nobs > 2, sigmaA > 0, sigmaB > 0)
 data.frame(
   nA = 1:(nobs-1),
   stderror = sqrt(sigmaA/(1:(nobs-1)) + sigmaB/((nobs-1):1))
   )
 }
# Call function with placeholder arguments 
data <- stderror_pairwisediff(nobs = 100, sigmaA = 1, sigmaB = 1) 
library(ggplot2) # load pcakage
ggplot(data = data,
       mapping = aes(x = nA, y = stderror)) + 
       geom_line() +
       theme_classic() +
       labs(y = "std. error",
            x = paste("sample size for group A | n = ", 
                      max(data$nA) + 1L))
```

<img src="/evaluations/07-problem-set_files/figure-html/unnamed-chunk-1-1.png" width="672" />

-   What is the best way to allocate a sample of 100 observations between the two groups if `\(\sigma^2_A = 1\)` and `\(\sigma^2_B = 4\)`? Create a plot illustrating the relationship between the number of observations assigned to treatment `\(A\)` versus `\(B\)`.
-   What is the optimum share of cases for `\(A\)` versus `\(B\)` more generally?[^1] Explain why this result is logical.
-   Using the optimal fraction you identified, by how much does the standard error decreases if we increase the sample size hundred-fold, i.e., we go from 10 to 1 000 observations?
-   Do you think we can act on the standard deviation `\(\text{std. dev}\)` term as experimenter? Why or why not?

## References

[^1]: Play with the parameters to figure out the optimal allocation, or use math.
