---
title: "Problem set 3"
linktitle: "Problem set 3"
date: "2021-09-26"
due_date: "2021-10-04"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 3
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

In this problem set, we consider a multilab replication study (Elliott et al., 2021) on verbalization of children during a memorization task; this is an attempt to validate and extend Flavell et al. (1966). We also look at the Solomon’s paradox in Grossmann & Kross (2014). The data for both studies can be downloaded from the Open Science Foundation (OSF), but only the first is preregistered.

# Task 1 - Assessing reproducibility

1.  Have a look at Elliott et al. (2021) and visit the [Open Science Foundation webpage for the project](https://osf.io/pn4rk/) to check the hierarchy of their folders, the pre-registered study plan, the codebook and the data analysis folder.
2.  Compare this with Grossmann & Kross (2014): do you think you could reproduce the latter? e.g., try to identify the variables that are referenced in the paper using the codebook available from the [Open Science Foundation webpage for the project](http://osf.io/7xs93).
3.  Read the policy of the [Strategic Management Journal](https://onlinelibrary.wiley.com/page/journal/10970266/homepage/forauthors.html). In your words, discuss their editorial choices and identify how they can alleviate part of the problems of the reproducibility crisis.

# Task 2 - Accounting for multiple testing

We consider the preplanned comparisons in Study 3 in Grossmann & Kross (2014) [download paper](https://journals.sagepub.com/stoken/default+domain/vIg5KBmaiJHKTXfUpXZK/full). The purpose of the exercice is to reproduce Table S4 of the Supplementary material, adjusting for multiplicity.[^1]

Use the [helper code provided](/evaluations/03-problem-set.R).

1.  Fill the helper file code by replacing the `#TODO` statements to compute the contrasts in the preplanned comparisons reported in Table S4. Check whether these match the reported values.
2.  Determine the number of tests in the family (think about whether it makes sense to treat each response separately, or to consider tests from other comparisons in Study 3).
3.  A frequent argument is that planned comparisons shouldn’t be adjusted for, as it amounts to a decrease in power. In the present case, do you think this is a cogent argument? Justify you answer.
4.  Using the helper code, obtain adjusted *p*-values using Bonferroni’s method and compare them to (a) the raw *p*-values and (b) the Bonferroni-Holm adjusted *p*-values. How many of the planned comparisons are significant at level `\(\alpha=0.05\)` if you modify the *p*-values?
5.  Another way to present the results of the two-sided *t*-test for contrasts is to report confidence intervals rather than *p*-values. Which interval would be the largest between (a) an unadjusted confidence interval and (b) one derived using Bonferroni’s method? Justify your answer. *Hint: Bonferroni’s method amounts to making the tests at level `\(\alpha/m\)`. Try modifying the code to see which is largest.*

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Elliot:2021" class="csl-entry">

Elliott, E. M., Morey, C. C., AuBuchon, A. M., Cowan, N., Jarrold, C., Adams, E. J., Attwood, M., Bayram, B., Beeler-Duden, S., Blakstvedt, T. Y., Büttner, G., Castelain, T., Cave, S., Crepaldi, D., Fredriksen, E., Glass, B. A., Graves, A. J., Guitard, D., Hoehl, S., … Voracek, M. (2021). Multilab direct replication of flavell, beach, and chinsky (1966): Spontaneous verbal rehearsal in a memory task as a function of age. *Advances in Methods and Practices in Psychological Science*, *4*(2), 1–20. <https://doi.org/10.1177/25152459211018187>

</div>

<div id="ref-Flavell:1966" class="csl-entry">

Flavell, J. H., Beach, D. R., & Chinsky, J. M. (1966). Spontaneous verbal rehearsal in a memory task as a function of age. *Child Development*, *37*(2), 283–299. <http://proxy2.hec.ca/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=pbh&AN=10398223&lang=fr&site=ehost-live>

</div>

<div id="ref-Grossman:2014" class="csl-entry">

Grossmann, I., & Kross, E. (2014). Exploring solomon’s paradox: Self-distancing eliminates the self-other asymmetry in wise reasoning about close relationships in younger and older adults. *Psychological Science*, *25*(8), 1571–1580. <https://doi.org/10.1177/0956797614535400>

</div>

</div>

[^1]: 
    Technical aside: there are four outcome variables (`COMPR`,`LIMITS`,`PERSP` and `CHANGE`) that are correlated, so this is technically a multivariate problem. We will ignore this purposedly and fit repeatedly one-way ANOVA models for each of the four response separately, for each age group. Thus, we will have four contrasts for each of the eight models (one per outcome and age group).
