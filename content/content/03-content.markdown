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

-   Programming premises
-   Sampling variability
-   Hypothesis testing
-   One-way analysis of variance
-   **R** demo

## Learning objectives

At the end of the session, students should be capable of

-   interpret parameter estimates for a one-way analysis of variance with different parametrizations (average, constrasts, sum-to-zero)
-   understand the logic behind estimability
-   
-   reporting summary statistics and output of an *F*-test

## Readings

-   <i class="fas fa-book"></i> Chapter 3 of the [Course notes](https://lbelzile.github.io/math80667a/hypothesis-testing.html)
-   <i class="fas fa-book"></i> Chapter *Reproducibility Crisis* of the [Course notes](https://lbelzile.github.io/math80667a/reproducibility-crisis.html)
-   <i class="fas fa-book"></i> Chapter 1 (*Introduction to Data Science*) of [Timbers, Campbell and Lee (2021) Data Sciences: A First Introduction](https://ubc-dsci.github.io/introduction-to-datascience/intro.html)

## Complementary readings

-   <i class="fas fa-book"></i> Chapters 3 and 4 of Dean et al. (2017); the exposition is more mathematical and formulaic than what we cover in the notes.

<!--
## Slides

The slides for today's lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

`{{% slide-buttons %}}`{=html}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="anova-tab" data-toggle="tab" href="#anova" role="tab" aria-controls="anova" aria-selected="true">ANOVA</a>
</li>
<li class="nav-item">
<a class="nav-link" id="parametrizations-tab" data-toggle="tab" href="#parametrizations" role="tab" aria-controls="parametrizations" aria-selected="false">Parametrizations</a>
</li>
<li class="nav-item">
<a class="nav-link" id="estimability-and-contrasts-tab" data-toggle="tab" href="#estimability-and-contrasts" role="tab" aria-controls="estimability-and-contrasts" aria-selected="false">Estimability and contrasts</a>
</li>
<li class="nav-item">
<a class="nav-link" id="ttests-tab" data-toggle="tab" href="#ttests" role="tab" aria-controls="ttests" aria-selected="false">t-tests</a>
</li>
<li class="nav-item">
<a class="nav-link" id="multiple-testing-tab" data-toggle="tab" href="#multiple-testing" role="tab" aria-controls="multiple-testing" aria-selected="false">Multiple testing</a>
</li>
</ul>
<div class="tab-content" id="slide-tabs">
<div class="tab-pane fade show active" id="anova" role="tabpanel" aria-labelledby="anova-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/03-slides.html#1"></iframe>
</div>
</div>
<div class="tab-pane fade" id="parametrizations" role="tabpanel" aria-labelledby="parametrizations-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/03-slides.html#parametrization-interpret"></iframe>
</div>
</div>
<div class="tab-pane fade" id="estimability-and-contrasts" role="tabpanel" aria-labelledby="estimability-and-contrasts-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/03-slides.html#estim-and-contrasts"></iframe>
</div>
</div>
<div class="tab-pane fade" id="ttests" role="tabpanel" aria-labelledby="ttests-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/03-slides.html#link-to-ttest"></iframe>
</div>
</div>
<div class="tab-pane fade" id="multiple-testing" role="tabpanel" aria-labelledby="multiple-testing-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/03-slides.html#multiple-testing"></iframe>
</div>
</div>
</div>
-->

## In-class

<!-- 
{{% div fyi %}}
**Fun fact**: If you type <kbd>?</kbd> (or <kbd>shift</kbd> + <kbd>/</kbd>) while going through the slides, you can see a list of special slide-specific commands.
{{% /div %}}





-->

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Dean:2017" class="csl-entry">

Dean, A., Voss, D., & Draguljić, D. (2017). *Design and analysis of experiments*. Springer. <https://www.springer.com/gp/book/9783319522487>

</div>

</div>
