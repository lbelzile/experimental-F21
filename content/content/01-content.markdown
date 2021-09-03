---
title: "Introduction"
linktitle: "1: Introduction"
date: "2021-09-02"
start_date: "2021-08-30"
end_date: "2021-09-03"
menu:
  content:
    parent: Course content
    weight: 1
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "01-slides"
---

## Content

-   Syllabus and learning objectives
-   Programming premises
-   Motivation
    -   Examples of experimental designs
    -   Evidence-based policy
-   Review
    -   Population and samples
    -   Basic sampling mechanisms
    -   Study types: observational versus experimental
-   Introduction to experimental designs
    -   Terminology
    -   Key concepts: control, randomization, replication, blocking
    -   Requirements for a good experiment

## Learning objectives

At the end of the session, students should be capable of

-   knowing the basic vocabulary attached to experiments.
-   assessing the generalizability of a study based on the description.
-   distinguishing between observational and experimental studies.
-   identifying experimental and observational units, treatments and blocking variables in an experimental study
-   using **R** for basic data manipulations and graphics

## Preliminaries

-   Familiarize yourself with the [syllabus](/syllabus/), [content](/content/), [examples](/example/), and [evaluations](/evaluations/) pages for this class.
-   <i class="fas fa-book"></i> Read Chapter 1 (Intro to Data) of [OpenIntro Statistics](https://www.openintro.org/book/os/) and the accompanying <i class="fab fa-youtube"></i>[videos](https://www.youtube.com/playlist?list=PLkIselvEzpM6pZ76FD3NoCvvgkj_p-dE8)

## Readings

-   <i class="fas fa-book"></i> Chapter 1 of the [Course notes](https://lbelzile.github.io/math80667a/introduction.html)
-   <i class="fas fa-book"></i> Chapter 1 and Sections 2.1-2.2 in *Design and Analysis of Experiments* (Dean et al., 2017)
-   <i class="fas fa-newspaper-o"></i> Abstract of Hariton, E and J.J. Locascio (2018), [*Randomised controlled trials – the gold standard for effectiveness research*](https://doi.org/10.1111/1471-0528.15199)

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 2 (*Study design*) in [*Introduction to Modern Statistics*](https://openintro-ims.netlify.app/data-design.html)
-   <i class="fas fa-book"></i> Chapter 1 (*Preliminaries*) in *Planning of experiments* (Cox, 1958)
-   <i class="fas fa-book"></i> Examples from Section 1.4 of *Experimental Design* (Berger et al., 2018)

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="class-details-tab" data-toggle="tab" href="#class-details" role="tab" aria-controls="class-details" aria-selected="false">Class details</a>
</li>
<li class="nav-item">
<a class="nav-link" id="motivation-tab" data-toggle="tab" href="#motivation" role="tab" aria-controls="motivation" aria-selected="false">Motivation</a>
</li>
<li class="nav-item">
<a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review" aria-selected="false">Review</a>
</li>
<li class="nav-item">
<a class="nav-link" id="key-concepts-in-experimental-design-tab" data-toggle="tab" href="#key-concepts-in-experimental-design" role="tab" aria-controls="key-concepts-in-experimental-design" aria-selected="false">Key concepts in experimental design</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://edsm.rbind.io/slides/01-slides.html#1">
</iframe>

</div>

</div>

<div id="class-details" class="tab-pane fade" role="tabpanel" aria-labelledby="class-details-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://edsm.rbind.io/slides/01-slides.html#class-details">
</iframe>

</div>

</div>

<div id="motivation" class="tab-pane fade" role="tabpanel" aria-labelledby="motivation-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://edsm.rbind.io/slides/01-slides.html#motivation">
</iframe>

</div>

</div>

<div id="review" class="tab-pane fade" role="tabpanel" aria-labelledby="review-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://edsm.rbind.io/slides/01-slides.html#review">
</iframe>

</div>

</div>

<div id="key-concepts-in-experimental-design" class="tab-pane fade" role="tabpanel" aria-labelledby="key-concepts-in-experimental-design-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://edsm.rbind.io/slides/01-slides.html#key-concepts-experimental">
</iframe>

</div>

</div>

</div>

## Case study

We will discuss the summary of [“The Impact of Mask Distribution and Promotion on Mask Uptake and COVID-19 in Bangladesh”](https://www.poverty-action.org/printpdf/47486) in class during the workshop. The [preprint of the paper](https://www.poverty-action.org/sites/default/files/publications/Mask_RCT____Symptomatic_Seropositivity_083121.pdf) contains additional information.

During the activity, you will be asked to identify in teams the following:

-   the objective of the study
-   the target population (which findings generalize?)
-   the sampling scheme
-   the observational and experimental units
-   the treatments
-   the outcome variable(s)

## **R** and Rmarkdown introduction

This material by [Dr. Andrew Heiss](https://www.andrewheiss.com/) nicely goes over the presentation of the various basics of programming in **R** (including a presentation of the integrated development environment, the programming language syntax, and basics of data manipulation and graphics using the tidyverse).

-   [Project .zip file](https://evalf21.classes.andrewheiss.com/projects/01-class.zip)
-   [Lab slides 1: Markdown](https://evalf21.classes.andrewheiss.com/slides/01-class_01_markdown-writing.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_01_markdown-writing.pdf)
-   [Lab slides 2: Getting started with **R** and RStudio](https://evalf21.classes.andrewheiss.com/slides/01-class_02-getting-started.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_02-getting-started.pdf)
-   [Lab slides 3: Data basics](https://evalf21.classes.andrewheiss.com/slides/01-class_03_data-basics.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_03_data-basics.pdf)
-   [Lab slides 4: Visualize data with `ggplot2`](https://evalf21.classes.andrewheiss.com/slides/01-class_04_visualize-data.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_04_visualize-data.pdf)
-   [Lab slides 5: Transform data with `dplyr`](https://evalf21.classes.andrewheiss.com/slides/01-class_05_transform-data.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_05_transform-data.pdf)

{{% div fyi %}}
**Fun fact**: If you type <kbd>?</kbd> (or <kbd>shift</kbd> + <kbd>/</kbd>) while going through the slides, you can see a list of special slide-specific commands.
{{% /div %}}

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Berger:2018" class="csl-entry">

Berger, P. D., Maurer, R. E., & Celli, G. B. (2018). *Experimental design with applications in management, engineering, and the sciences* (2nd ed.). Springer. <https://doi.org/10.1007/978-3-319-64583-4>

</div>

<div id="ref-Cox:1958" class="csl-entry">

Cox, D. R. (1958). *Planning of experiments*. Wiley.

</div>

<div id="ref-Dean:2017" class="csl-entry">

Dean, A., Voss, D., & Draguljić, D. (2017). *Design and analysis of experiments*. Springer. <https://www.springer.com/gp/book/9783319522487>

</div>

</div>
