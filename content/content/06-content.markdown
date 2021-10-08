---
title: "Analysis of variance for two factors"
linktitle: "6: Analysis of variance for two factors"
date: "2021-10-04"
start_date: "2021-10-04"
end_date: "2021-10-08"
menu:
  content:
    parent: Course content
    weight: 6
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "06-slides"
---

## Content

-   Two way designs
-   Blocking factor
-   Interactions
-   Power, effect size and contrasts for two way designs

## Learning objectives

At the end of the session, students should be capable of

-   explain the benefits of factorial designs over one-way analysis of variance
-   explain the concept of interaction and produce plots of estimated marginal means
-   test whether an interaction term is significant
-   compute (partial) effect sizes in **R**
-   estimate the sample size needed for a two way study
-   explain the benefit of blocking factors and concomitant variables
-   correctly report findings for a two-way analysis of variance

## Readings

-   Chapters [26](https://dzchilds.github.io/stats-for-bio/two-way-anova-intro.html) and [27](https://dzchilds.github.io/stats-for-bio/two-way-anova-in-r.html) from APS 240: **Data Analysis and Statistics with R**

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 6 of Dean et al. (2017).
-   <i class="fas fa-book"></i> Chapters 10 to 12 of Keppel & Wickens (2004).

## In class

We covered three examples in class: one two-way design with a blocking factor (no interaction), a balanced design with fictious data from Keppel & Wickens (2004) (Table 11.8) and finally data from a replication study (unbalanced). The code for these examples can be found in the [**R** script](/example/06-twowayanova.R).

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="factorial-designs-and-interactions-tab" data-toggle="tab" href="#factorial-designs-and-interactions" role="tab" aria-controls="factorial-designs-and-interactions" aria-selected="false">Factorial designs and interactions</a>
</li>
<li class="nav-item">
<a class="nav-link" id="model-formulation-tab" data-toggle="tab" href="#model-formulation" role="tab" aria-controls="model-formulation" aria-selected="false">Model formulation</a>
</li>
<li class="nav-item">
<a class="nav-link" id="effect-size-contrasts-and-power-tab" data-toggle="tab" href="#effect-size-contrasts-and-power" role="tab" aria-controls="effect-size-contrasts-and-power" aria-selected="false">Effect size, contrasts and power</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/06-slides.html#1">
</iframe>

</div>

</div>

<div id="factorial-designs-and-interactions" class="tab-pane fade" role="tabpanel" aria-labelledby="factorial-designs-and-interactions-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/06-slides.html#factorial-interaction">
</iframe>

</div>

</div>

<div id="model-formulation" class="tab-pane fade" role="tabpanel" aria-labelledby="model-formulation-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/06-slides.html#formulation">
</iframe>

</div>

</div>

<div id="effect-size-contrasts-and-power" class="tab-pane fade" role="tabpanel" aria-labelledby="effect-size-contrasts-and-power-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/06-slides.html#effect-size-contrast-power">
</iframe>

</div>

</div>

</div>

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Dean:2017" class="csl-entry">

Dean, A., Voss, D., & Draguljić, D. (2017). *Design and analysis of experiments*. Springer. <https://www.springer.com/gp/book/9783319522487>

</div>

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

</div>
