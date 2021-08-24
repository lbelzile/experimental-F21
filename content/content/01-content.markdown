---
title: "Introduction"
linktitle: "1: Introduction"
date: "2021-01-11"
start_date: "2021-01-11"
end_date: "2021-01-15"
menu:
  content:
    parent: Course content
    weight: 1
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/chicago-fullnote-bibliography-no-bib.csl"
slides: "01-slides"
---

## Content

-   Syllabus and learning objectives
    -   Programming premises
-   Motivation
    -   Why are experiments useful?
    -   Examples
-   Differences between observational and experimental studies
-   Key concepts in experimental designs
    -   Randomization
    -   Blocking

## Learning objectives

At the end of the session, students should be capable of

-   distinguishing between observational and experimental studies, and the merits of both.
-   identifying experimental units, observations and treatments in an experimental study
-   assessing the generalizability of a study
-   using **R** for basic data manipulations and graphics

## Preliminaries

-   Familiarize yourself with the [syllabus](/syllabus/), [content](/content/), [examples](/example/), and [assignments](/assigment/) pages for this class.
-   <i class="fas fa-book"></i> Read Chapter 1 (Intro to Data) of [OpenIntro Statistics](https://www.openintro.org/book/os/) and the accompanying <i class="fab fa-youtube"></i>[videos](https://www.youtube.com/playlist?list=PLkIselvEzpM6pZ76FD3NoCvvgkj_p-dE8)

## Readings

-   <i class="fas fa-book"></i> Chapter 1 of the [Course notes](https://lbelzile.github.io/math80667a/introduction.html)
-   <i class="fas fa-newspaper-o"></i> Abstract of Hariton, E and J.J. Locascio (2018), [*Randomised controlled trials – the gold standard for effectiveness research*](https://doi.org/10.1111/1471-0528.15199)
-   <i class="fas fa-book"></i> Chapter 1 (*Preliminaries*) in *Planning of experiments*[^1]

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 1 and Sections 2.1-2.2 in *Design and Analysis of Experiments*[^2]
-   <i class="fas fa-book"></i> Examples from Section 1.4 of *Experimental Design*[^3]

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
<a class="nav-link" id="experimental-vs-observational-tab" data-toggle="tab" href="#experimental-vs-observational" role="tab" aria-controls="experimental-vs-observational" aria-selected="false">Experimental vs observational</a>
</li>
<li class="nav-item">
<a class="nav-link" id="key-notions-tab" data-toggle="tab" href="#key-notions" role="tab" aria-controls="key-notions" aria-selected="false">Key notions</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/01-slides.html#1">
</iframe>

</div>

</div>

<div id="class-details" class="tab-pane fade" role="tabpanel" aria-labelledby="class-details-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/01-slides.html#class-details">
</iframe>

</div>

</div>

<div id="motivation" class="tab-pane fade" role="tabpanel" aria-labelledby="motivation-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/01-slides.html#motivation">
</iframe>

</div>

</div>

<div id="experimental-vs-observational" class="tab-pane fade" role="tabpanel" aria-labelledby="experimental-vs-observational-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/01-slides.html#experimental-vs-observational">
</iframe>

</div>

</div>

<div id="key-notions" class="tab-pane fade" role="tabpanel" aria-labelledby="key-notions-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/01-slides.html#key-notions">
</iframe>

</div>

</div>

</div>

## In-class presentation

This material by [Dr. Andrew Heiss](https://www.andrewheiss.com/) nicely goes over the presentation of the various basics (the integrated development environment, the programming language, basics of data manipulation, graphics).

-   [Project .zip file](https://evalf21.classes.andrewheiss.com/projects/01-class.zip)
-   [Lab slides 1: Markdown](https://evalf21.classes.andrewheiss.com/slides/01-class_01_markdown-writing.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_01_markdown-writing.pdf)
-   [Lab slides 2: Getting started with **R** and RStudio](https://evalf21.classes.andrewheiss.com/slides/01-class_02-getting-started.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_02-getting-started.pdf)
    [Lab slides 3: Data basics](https://evalf21.classes.andrewheiss.com/slides/01-class_03_data-basics.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_03_data-basics.pdf)
-   [Lab slides 4: Visualize data with ggplot2](https://evalf21.classes.andrewheiss.com/slides/01-class_04_visualize-data.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_04_visualize-data.pdf)
-   [Lab slides 5: Transform data with dplyr](https://evalf21.classes.andrewheiss.com/slides/01-class_05_transform-data.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_05_transform-data.pdf)

{{% div fyi %}}
**Fun fact**: If you type <kbd>?</kbd> (or <kbd>shift</kbd> + <kbd>/</kbd>) while going through the slides, you can see a list of special slide-specific commands.
{{% /div %}}

[^1]: David R. Cox, *Planning of Experiments* (New York, NY: Wiley, 1958).

[^2]: A. Dean, D. Voss, and D. Draguljić, *Design and Analysis of Experiments* (Springer, 2017), <https://www.springer.com/gp/book/9783319522487>.

[^3]: Paul D. Berger, Robert E. Maurer, and Giovana B. Celli, *Experimental Design with Applications in Management, Engineering, and the Sciences*, 2nd ed. (Springer, 2018), doi:[10.1007/978-3-319-64583-4](https://doi.org/10.1007/978-3-319-64583-4).
