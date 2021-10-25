---
title: "Problem set 6"
linktitle: "Problem set 6"
date: "2021-10-17"
due_date: "2021-11-02"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 6
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

## Task 1 - Two-way ANOVA

Complete this task in teams of two or three students.

As a refresher, we consider a small example of two-way analysis of variance using data from Example 6.4 (First United Federal Bank of Boston) of Berger et al. (2018) on bank tellers: 100 tellers these were offered one-on-one training with an experienced clerk for a certain number of weeks on the job, possibly in addition to formal training period. The goal of the study is to determine which combination is most efficient at reducing the monthly error in balance (in dollars).

Download [the starter code](/evaluations/06-problem-set.R) and answer the following questions. Write a report as if you were doing an analysis for a scientific publication.

1.  Produce a plot of the monthly error per teller as a function of the number of weeks of one-on-one training.
2.  Produce a quantile-quantile plot of the residuals and use Levene’s test to check whether the variance in each subgroup is the same. Report on these preliminary checks.
3.  Assess whether there an interaction between number of weeks of one-on-one training and the formal training.
4.  Compute pairwise contrasts between weeks of one-on-one supervision for the case of people with formal training.
5.  Compare the difference in errors between 8 and 4 weeks of one-to-one supervision, for people with and without formal training.

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Berger:2018" class="csl-entry">

Berger, P. D., Maurer, R. E., & Celli, G. B. (2018). *Experimental design with applications in management, engineering, and the sciences* (2nd ed.). Springer. <https://doi.org/10.1007/978-3-319-64583-4>

</div>

</div>
