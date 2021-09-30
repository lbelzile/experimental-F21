---
title: "Power calculations and model assumptions"
linktitle: "5: Power calculations and model assumptions"
date: "2021-09-27"
start_date: "2021-09-27"
end_date: "2021-10-01"
menu:
  content:
    parent: Course content
    weight: 5
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "04-slides"
---

## Content

-   Assumptions of the analysis of variance model
    -   Additivity
    -   Homogeneity of variance and Levene’s test
    -   Independence
-   Power calculations: sample size, power and effect size, Cohen’s `\(d\)`

## Learning objectives

At the end of the session, students should be capable of

-   produce graphical diagnostics and perform hypothesis tests to check the model assumptions
-   think critically about the model assumptions as part of the model formulation
-   deduce the sample size necessary to replicate a study at a given power
-   understand the interplay between power and effect.

## Readings

-   <i class="fas fa-book"></i> Section *Model assumptions* of the [Course notes](https://lbelzile.github.io/math80667a/onewayanova.html#model-assumptions)
-   Kristoffer Magnusson’s [*Understanding Statistical Power and Significance Testing: an interactive visualization*](https://rpsychologist.com/d3/nhst/)
-   Kristoffer Magnusson’s [*Interpreting Cohen’s `\(d\)` Effect Size*](https://rpsychologist.com/cohend/) (Magnusson, 2021)

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 5 of Dean et al. (2017).

## R

-   [Computing Cohen’s `\(d\)` in **R**](https://www.datanovia.com/en/lessons/t-test-effect-size-using-cohens-d-measure/)

<!--
- <i class="fas fa-book"></i> Andrew Gelman's blog on [Ethical responsibility of research assistants](https://statmodeling.stat.columbia.edu/2021/09/18/for-a-research-assistant-do-you-think-there-is-an-ethical-responsibility-to-inform-your-supervisor-principal-investigator-if-they-change-their-analysis-plan-multiple-times-during-the-research-proje/): a discussion of _p_-hacking, which consists in selectively reporting only tests that are significant, making it seem as they were planned comparisons. 



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
</ul>
<div class="tab-content" id="slide-tabs">
<div class="tab-pane fade show active" id="introduction" role="tabpanel" aria-labelledby="introduction-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/04-slides.html#1"></iframe>
</div>
</div>
<div class="tab-pane fade" id="multiple-testing" role="tabpanel" aria-labelledby="multiple-testing-tab">
<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="/slides/04-slides.html#multiple-testing"></iframe>
</div>
</div>
</div>


## In-class

-->
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

<div id="ref-magnussonCohend" class="csl-entry">

Magnusson, K. (2021). *Interpreting cohen’s d effect size: An interactive visualization* (Version 2.5.1) \[Computer software\]. <https://rpsychologist.com/cohend/>

</div>

</div>
