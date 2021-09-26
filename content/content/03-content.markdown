---
title: "One way analysis of variance"
linktitle: "3: One way analysis of variance"
date: "2021-09-16"
start_date: "2021-09-13"
end_date: "2021-09-17"
menu:
  content:
    parent: Course content
    weight: 3
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "03-slides"
---

## Content

-   Confidence intervals
-   *F*-statistic and sum of square decomposition
-   Parametrization and contrasts
-   Planned and post-hoc comparisons

## Learning objectives

At the end of the session, students should be capable of

-   understand the trade-off between power and level
-   interpret parameter estimates for a one-way analysis of variance with different parametrizations (average, constrasts, sum-to-zero)
-   set up specific contrasts for custom tests

## Readings

-   <i class="fas fa-book"></i> Sections 3.1 to 3.3 of the [Course notes](https://lbelzile.github.io/math80667a/onewayanova.html)
-   <i class="fas fa-book"></i> Chapter 1 (*Introduction to Data Science*) of [Timbers, Campbell and Lee (2021) Data Sciences: A First Introduction](https://ubc-dsci.github.io/introduction-to-datascience/intro.html)
    <!--- <i class="fas fa-book"></i> Chapter _Reproducibility Crisis_ of the [Course notes](https://lbelzile.github.io/math80667a/reproducibility-crisis.html)
    -->

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 3 and Sections 4.1-4.3 of Dean et al. (2017).

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="recap-tab" data-toggle="tab" href="#recap" role="tab" aria-controls="recap" aria-selected="false">Recap</a>
</li>
<li class="nav-item">
<a class="nav-link" id="one-way-anova-tab" data-toggle="tab" href="#one-way-anova" role="tab" aria-controls="one-way-anova" aria-selected="false">One way ANOVA</a>
</li>
<li class="nav-item">
<a class="nav-link" id="parametrizations-and-interpretation-tab" data-toggle="tab" href="#parametrizations-and-interpretation" role="tab" aria-controls="parametrizations-and-interpretation" aria-selected="false">Parametrizations and interpretation</a>
</li>
<li class="nav-item">
<a class="nav-link" id="planned-comparisons-and-posthoc-tests-tab" data-toggle="tab" href="#planned-comparisons-and-posthoc-tests" role="tab" aria-controls="planned-comparisons-and-posthoc-tests" aria-selected="false">Planned comparisons and post-hoc tests</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/03-slides.html#1">
</iframe>

</div>

</div>

<div id="recap" class="tab-pane fade" role="tabpanel" aria-labelledby="recap-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/03-slides.html#recap">
</iframe>

</div>

</div>

<div id="one-way-anova" class="tab-pane fade" role="tabpanel" aria-labelledby="one-way-anova-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/03-slides.html#f-test">
</iframe>

</div>

</div>

<div id="parametrizations-and-interpretation" class="tab-pane fade" role="tabpanel" aria-labelledby="parametrizations-and-interpretation-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/03-slides.html#parametrization">
</iframe>

</div>

</div>

<div id="planned-comparisons-and-posthoc-tests" class="tab-pane fade" role="tabpanel" aria-labelledby="planned-comparisons-and-posthoc-tests-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/03-slides.html#planned-comparisons">
</iframe>

</div>

</div>

</div>

## In-class

We conducted a Monte Carlo study in class to check the distribution of *p*-values. The code can be found in [Example 2. Hypothesis testing](/example/02-hypothesis_testing/)

<!-- 
{{% div fyi %}}
**Fun fact**: If you type <kbd>?</kbd> (or <kbd>shift</kbd> + <kbd>/</kbd>) while going through the slides, you can see a list of special slide-specific commands.
{{% /div %}}





-->

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Dean:2017" class="csl-entry">

Dean, A., Voss, D., & Draguljić, D. (2017). *Design and analysis of experiments*. Springer. <https://www.springer.com/gp/book/9783319522487>

</div>

</div>
