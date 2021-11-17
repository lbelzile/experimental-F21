---
title: "Problem set 8"
linktitle: "Problem set 8"
date: "2021-11-09"
due_date: "2021-11-19"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 8
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

## Task 1 - Analysis of covariance

Complete this assignment in teams of 2 to 4 students. Submit a single PDF report per group and indicate the name of your other teammates.

We consider Experiment 3 of Stekelenburg et al. (2021); ([download paper](https://doi.org/10.1177/09567976211007788) and [download script](https://osf.io/4yatk/download)); the code starts line 491+ after some initial manipulations and you could adapt the latter (warning: it’s messy). The [helper code](/evaluations/08-problem-set.R) provides the database after these have been made.

1.  What is the purpose of collecting demographic information if it’s not used for the testing procedure?
2.  Have a quick look at the exclusion guidelines in the [preregistration](https://osf.io/4w9tq). Do they make sense? think about other potential criteria that could have been listed.
3.  The author proceed with splitting the data set in three group for each pairwise comparisons in turn, corresponding to the different hypotheses (circa lines 499-533 of the [script](https://osf.io/4yatk/download)). Why might this approach be suboptimal relative to the one that consists in fitting a model to the three categories and proceeding later with computing simple effects and contrasts?
4.  Test the assumptions of (1) equal variance per experimental condition and (2) proper randomization based on `Prior` scores.
5.  Compute the difference in posterior belief between Boost+ and consensus only conditions. Report the sample average and standard deviation estimates of each group, the test statistic `\(F\)` (or `\(t\)`), the proportion of variance `\(\eta^2_p\)` with a 90% confidence interval and Cohen’s `\(d\)`. Do these measures agree with those of the paper?

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-vanStekelenburg:2021" class="csl-entry">

Stekelenburg, A. van, Schaap, G., Veling, H., & Buijzen, M. (2021). Boosting understanding and identification of scientific consensus can help to correct false beliefs. *Psychological Science*, *32*(10), 1549–1565. <https://doi.org/10.1177/09567976211007788>

</div>

</div>
