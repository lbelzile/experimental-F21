---
title: "Reproducibility crisis and multiple testing"
linktitle: "4: Reproducibility crisis and multiple testing"
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

-   Reproducibility crisis
-   Multiple testing
    -   Family-wise error rate and false discovery rate
    -   Procedures
    -   Practice with **R**

## Learning objectives

At the end of the session, students should be capable of

-   listing strategies to enhance reproducibility
-   determining the number of tests in a family that need to be corrected for
-   understanding how to correct *p*-values to account for multiple testing
-   listing multiplicity testing methods suitable depending on context
-   grasping the tradeoff between multiple testing and power

## Readings

-   <i class="fas fa-book"></i> Chapter on the *Reproducibility crisis* of the [Course notes](https://lbelzile.github.io/math80667a/reproducibility-crisis.html)
-   <i class="fas fa-book"></i> Section on *Multiple testing* of the [Course notes](https://lbelzile.github.io/math80667a/onewayanova.html#multiple-testing)

## Complementary readings

-   <i class="fas fa-book"></i> Section 4.4 of Dean et al. (2017).
-   <i class="fas fa-book"></i> Chapter 6 of Keppel & Wickens (2004).
-   <i class="fas fa-book"></i> [H. Abdi (2010) Holm’s Sequential Bonferroni Procedure](https://personal.utdallas.edu/~herve/abdi-Holm2010-pretty.pdf)
-   <i class="fas fa-video-camera"></i> [*P*-Hacking: Crash Course Statistics](https://www.youtube.com/watch?v=Gx0fAjNHb1M)
-   The British Ecological Society (BES) publishes Guides to Better Sciences, among which the excellent [Reproducible Code](https://www.britishecologicalsociety.org/wp-content/uploads/2019/06/BES-Guide-Reproducible-Code-2019.pdf?utm_source=web&utm_medium=web&utm_campaign=better_science).

<!--
- <i class="fas fa-book"></i> Andrew Gelman's blog on [Ethical responsibility of research assistants](https://statmodeling.stat.columbia.edu/2021/09/18/for-a-research-assistant-do-you-think-there-is-an-ethical-responsibility-to-inform-your-supervisor-principal-investigator-if-they-change-their-analysis-plan-multiple-times-during-the-research-proje/): a discussion of _p_-hacking, which consists in selectively reporting only tests that are significant, making it seem as they were planned comparisons. 

-->

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="multiple-testing-tab" data-toggle="tab" href="#multiple-testing" role="tab" aria-controls="multiple-testing" aria-selected="false">Multiple testing</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/04-slides.html#1">
</iframe>

</div>

</div>

<div id="multiple-testing" class="tab-pane fade" role="tabpanel" aria-labelledby="multiple-testing-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/04-slides.html#multiple-testing">
</iframe>

</div>

</div>

</div>

## In-class

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

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

</div>
