---
title: "Linear model"
linktitle: "8: Linear model"
date: "2021-10-23"
start_date: "2021-10-25"
end_date: "2021-10-29"
menu:
  content:
    parent: Course content
    weight: 8
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "08-slides"
---

## Content

-   Formulation
-   Sum of square decomposition for unbalanced designs
-   Diagnostic plots
-   Analysis of trend

## Learning objectives

At the end of the session, students should be capable of

-   fit general
-   correctly specify a factorial design with unbalanced samples (sum-to-zero parametrization, sum of squares)
-   fit a polynomial model for a single continuous factor and test for degree

## Readings

-   

## Complementary readings

-   <i class="fas fa-book"></i> [*The ANOVA controversy* by Falk Scholer](http://wight.seg.rmit.edu.au/fscholer/anova.php)
-   <i class="fas fa-book"></i> Chapters 8 of (**Fox:2015?**)

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

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

</div>
