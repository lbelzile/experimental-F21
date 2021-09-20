---
title: "Multiple testing and assumptions"
linktitle: "4: Multiple testing and assumptions"
date: "2021-09-21"
start_date: "2021-09-20"
end_date: "2021-09-24"
menu:
  content:
    parent: Course content
    weight: 4
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "04-slides"
---

## Content

-   Multiple testing
    -   Family-wise error rate and false discovery rate
    -   Bonferroni and Šidák corrections
    -   Benjamini–Hochberg procedure
-   Assumptions of the analysis of variance model
    -   ANOVA as a special case of a linear regression model
    -   Homogeneity of variance and Levene’s test
    -   Independence

## Learning objectives

At the end of the session, students should be capable of

-   understand how to correct *p*-values to account for multiple testing
-   grasp the tradeoff between multiple testing and
-   produce graphical diagnostics and compute tests to check the assumptions
-   think critically about the model assumptions as part of the model formulation

## Readings

-   <i class="fas fa-book"></i> Chapter 3 of the [Course notes](https://lbelzile.github.io/math80667a/hypothesis-testing.html)
-   <i class="fas fa-book"></i> Andrew Gelman’s blog on [Ethical responsibility of research assistants](https://statmodeling.stat.columbia.edu/2021/09/18/for-a-research-assistant-do-you-think-there-is-an-ethical-responsibility-to-inform-your-supervisor-principal-investigator-if-they-change-their-analysis-plan-multiple-times-during-the-research-proje/)

## Complementary readings

-   <i class="fas fa-book"></i> Section 4.4 and Chapter 5 of Dean et al. (2017).

<!--

## Slides

The slides for today's lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

`{{% slide-buttons %}}`{=html}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="multiple-testing-tab" data-toggle="tab" href="#multiple-testing" role="tab" aria-controls="multiple-testing" aria-selected="false">Multiple testing</a>
</li>
<li class="nav-item">
<a class="nav-link" id="assumptions-tab" data-toggle="tab" href="#assumptions" role="tab" aria-controls="assumptions" aria-selected="false">Assumptions</a>
</li>
<li class="nav-item">
<a class="nav-link" id="statistical-fallacies-tab" data-toggle="tab" href="#statistical-fallacies" role="tab" aria-controls="statistical-fallacies" aria-selected="false">Statistical fallacies</a>
</li>
</ul>
<div class="tab-content" id="slide-tabs">
<div class="tab-pane fade show active" id="introduction" role="tabpanel" aria-labelledby="introduction-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/04-slides.html#1"></iframe>
</div>
</div>
<div class="tab-pane fade" id="multiple-testing" role="tabpanel" aria-labelledby="multiple-testing-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/04-slides.html#multtest"></iframe>
</div>
</div>
<div class="tab-pane fade" id="assumptions" role="tabpanel" aria-labelledby="assumptions-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/04-slides.html#graphdiag"></iframe>
</div>
</div>
<div class="tab-pane fade" id="statistical-fallacies" role="tabpanel" aria-labelledby="statistical-fallacies-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/04-slides.html#fallacies1"></iframe>
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
