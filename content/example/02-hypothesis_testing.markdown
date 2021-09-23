---
title: "Null distributions"
linktitle: "2. Null distributions"
date: "2021-09-20"
menu:
  example:
    parent: Examples
    weight: 2
type: docs
toc: false
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

The purpose of this demonstration is to show, by means of simulations, the concepts of null distribution and level we did with hypothesis testing.

We begin by generating a dataset of independent and identically distributed data from some population: each has the same theoretical mean `\(\mu\)` and the same standard deviation `\(\sigma\)`. For each replicate sample here with four groups and 20 observations per group, we compute the analysis of variance global test of equality of means with the `\(F\)`-statistic and store its value and the associated value. This gives us, much like the permutation approach, a simulated benchmark against which we can compare the `\(F\)` distribution, which is the large sample approximation to the null distribution.

``` r
suppressPackageStartupMessages(library(tidyverse)) #load packages
alpha <- 0.05 #level of the test
ng <- 4L #number of groups
nsamp <- 20L #number of observations per group
ntot <- ng*nsamp #number of observations (total)
nrep <- 10000L #number of replications
# Create container to store results
pval <- vector(mode = "numeric", length = nrep)
fstat <- vector(mode = "numeric", length = nrep)
# For-loop: repeat these instructions nrep times
for(i in 1:nrep){
  sample <-
    tibble(response = rnorm(n = ntot), # sample No(0,1) variables
           group = factor(rep(1:ng, each = nsamp)))
  # normal data (rnorm), by default with
  # mean zero, std. dev 1
  ## Compute the global null F-statistic
  ftest <- oneway.test(response ~ group, 
                       data = sample, 
                       var.equal = TRUE)
  # Store the F-statistic and the p-value in the container
  fstat[i] <- ftest$statistic[1]
  pval[i] <- ftest$p.value[1]
}
```

If the null distribution is well calibrated (model assumptions hold and data arise from the null model), then the distribution of the *p*-values is uniform: every number between zero and one is equally likely, so the probability that the result is less than the level `\(\alpha\)` is on average `\(\alpha\)`. We can create a histogram of the 10K *p*-values and compare them to the uniform distribution.

``` r
ggplot(data = tibble("pvalue" = pval),
       aes(x = pvalue)) +
  # bin into 20 compartments,
  # specifying boundaries to avoid artifacts
  geom_histogram(breaks = seq(0, 1, by = 0.05),
                 aes(y = ..density..),
                 alpha = 0.2) +
  stat_function(fun = dunif, #uniform distribution
                col = "blue") +
  labs(x = "p-value",
       y = "density",
       subtitle = "Distribution of p-values under the null hypothesis",
       caption = "based on 10 000 simulations.") +
   scale_x_continuous(expand = c(0, 0),
                      limits = c(0, 1),
                      breaks = c(0,0.5,1)) +
   geom_vline(xintercept = alpha, type = 2)
```

    ## Warning: Ignoring unknown parameters: type

<img src="/example/02-hypothesis_testing_files/figure-html/plotpval-1.png" width="672" />

``` r
cutoff <- qf(0.95, ng - 1, ntot - ng) 
#cutoff: reject if larger than this value
ggplot(data = tibble("stat" = fstat),
       aes(x = stat)) +
  geom_histogram(aes(y = ..density..), #simulated null distribution of F
                 bins = 100L) +
  stat_function(fun = df, #theoretical (large sample) approximation
                args = list(df1 = ng - 1,
                            df2 = ng*nsamp - ng),
                n = 1000) +
  labs(x = "F statistic")
```

<img src="/example/02-hypothesis_testing_files/figure-html/pvaluedist2-1.png" width="672" />
