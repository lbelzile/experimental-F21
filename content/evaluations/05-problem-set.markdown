---
title: "Problem set 5"
linktitle: "Problem set 5"
date: "2021-10-12"
due_date: "2021-10-21"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 5
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

## Task 1 - Reporting guidelines and effect sizes

1.  Read Wilkinson (1999) guidelines for reporting statistical studies.
2.  Have a look at Kelley & Preacher (2012) and Lakens (2013) on definitions and reporting of effect size.

You do not need to hand in anything for this part of the assignment.

## Task 2 - Scientific writing

Your job is to put these suggestions into application for Study 2 of Risen & Gilovich (2008). [full text here](https://psycnet-apa-org.proxy2.hec.ca/fulltext/2008-09787-004.pdf) The data is taken from one of multiple replication studies and has been modified to make it balanced.[^1]
Since there were concerns from the original authors, the reanalysis focused on the undergraduate subsample and consists of a 2x2 analysis of variance with condition and gender as factors.

The statistics of interest, beyond the global null test of no effect for sex or gender, is the comparison between condition (prepared vs unprepared) either marginally (if there is no interaction) or within each gender group (if there is an interaction).

1.  Report on the two-way analysis performed in [this code](/evaluations/05-problem-set.R). Pick the [replication dataset associated to your student ID](/evaluations/05-problem-set-id2021.txt)
    -   Justify and describe the results of your analyses as if you had to write them in an article.
    -   Check the assumptions of the test you are using.
    -   Insert only relevant output (statistics, tables, graphs) in your written report.
2.  If you had to repeat this experiment, what sample size would you use? Justify your answer.

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Kelley/Preacher:2012" class="csl-entry">

Kelley, K., & Preacher, K. (2012). On effect size. *Psychological Methods*, *17*(2), 137–152. <https://doi.org/10.1037/a0028086>

</div>

<div id="ref-Lakens:2013" class="csl-entry">

Lakens, D. (2013). Calculating and reporting effect sizes to facilitate cumulative science: A practical primer for $t$-tests and ANOVAs. *Frontiers in Psychology*, *4*, 863. <https://doi.org/10.3389/fpsyg.2013.00863>

</div>

<div id="ref-Risen/Gilovich:2008" class="csl-entry">

Risen, J. L., & Gilovich, T. (2008). Why people are reluctant to tempt fate. *Journal of Personality and Social Psychology*, *95*(2), 293–307. <https://doi.org/10.1037/0022-3514.95.2.293>

</div>

<div id="ref-Wilkinson:1999" class="csl-entry">

Wilkinson, L. (1999). Statistical methods in psychology journals: Guidelines and explanations. *American Psychologist*, *54*, 594–604.

</div>

</div>

[^1]: For the sake of the exercise, never do this at home unless you want to throw information away! We will see how to properly analyze unbalanced designs latter.
