---
title: "Analysis of covariance and model assumptions"
linktitle: "9: Analysis of covariance and model assumptions"
date: "2021-11-02"
start_date: "2021-11-01"
end_date: "2021-11-05"
menu:
  content:
    parent: Course content
    weight: 9
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "09-slides"
---

## Learning objectives

At the end of the session, students should be capable of

-   Explaining the benefits of including concomitant variables to reduce error
-   Listing the four basic assumptions (linearity/correct mean model, equal variance, normality, independence of measurements)
-   Interpreting graphical tests to detect departures from the linear model assumptions

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="analysis-of-covariance-tab" data-toggle="tab" href="#analysis-of-covariance" role="tab" aria-controls="analysis-of-covariance" aria-selected="false">Analysis of covariance</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/09-slides.html#1">
</iframe>

</div>

</div>

<div id="analysis-of-covariance" class="tab-pane fade" role="tabpanel" aria-labelledby="analysis-of-covariance-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/09-slides.html#ancova">
</iframe>

</div>

</div>

</div>

A script containing the **R** code generated in the slides can be [downloaded here](/content/09-slides.R)

## Videos

Videos for each section of the lecture are [available at this YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8IsXym3S3kqgGIbJoka7tkGl).

-   [Introduction](https://www.youtube.com/watch?v=gTLp0pplRXk&list=PLUB8VZzxA8IsXym3S3kqgGIbJoka7tkGl)
-   [Analysis of covariance](https://www.youtube.com/watch?v=gTLp0pplRXk&list=PLUB8VZzxA8IsXym3S3kqgGIbJoka7tkGl)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8IsXym3S3kqgGIbJoka7tkGl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

## Readings

-   [Example 6](/example/06-ancova/)

## Complementary readings

-   <i class="fas fa-book"></i> Chapters 9 and 5 of Dean et al. (2017)
-   <i class="fas fa-book"></i> Chapters 15 and 7 of Keppel & Wickens (2004)

## In class

-   In-class discusssion about model assumptions: do they matter?  
-   Talk about peer-reviewing of journal articles

<!--
We consider Experiment 3 of @vanStekelenburg:2021; [[download paper]](https://doi.org/10.1177/09567976211007788) [[download script]](https://osf.io/4yatk/download); the code starts line 491+ after some initial manipulations. The [helper code](/content/09-ancova.R) provides the database after these have been made.

   1. What is the purpose of collecting demographic information not used?
   2. Have a quick look at the exclusion guidelines in the [preregistration](https://osf.io/4w9tq) Do they make sense? are there other criteria that could be listed.
   3. The author proceed with splitting the data set in three group for each pairwise comparisons in turn, corresponding to the different hypotheses (circa lines 499-533 of the script). Is this approach correct?
   3. Using a `\(\chi^2\)` test, compare the proportion of people who mention consensus for experimental condition Boost+  versus the control group `Control`. Comment on the results
   4. Test the assumptions of (1) equal variance per experimental condition and (2) proper randomization based on `Prior` scores.
   5. Compute the difference in posterior belief between Boost+ and consensus only conditions. Report the sample average and standard deviation estimates of each group, test statistic `\(\eta^2_p\)` with a 90% confidence interval and Cohen's `\(d\)`. How large is this effect?
   6. Before doing the analysis of variance, the authors removed outliers (which they defined as people who had absolute standardized residuals larger than 3). Does it impact the conclusions if these are kept?

-->

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Dean:2017" class="csl-entry">

Dean, A., Voss, D., & Draguljić, D. (2017). *Design and analysis of experiments*. Springer. <https://www.springer.com/gp/book/9783319522487>

</div>

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

</div>
