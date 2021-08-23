---
title: "Introduction to experimental designs"
linktitle: "1: Introduction to experimental designs"
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
-   Motivational
    -   Examples of experiments
    -   Notions of causal inference
-   Differences between observational and experimental studies
-   Key concepts in experimental designs
    -   Randomization
    -   Blocking

## Learning objectives

At the end of the session, students should be capable of

-   distinguishing between observational and experimental studies, and the merits of both.
-   identifying experimental units, observations and treatments in an experimental study
-   assessing the generalizability of a study
-   using **R** for basic manipulations

## Preliminaries

-   Familiarize yourself with the [syllabus](/syllabus/), [content](/content/), [examples](/example/), and [assignments](/assigment/) pages for this class.

-   <i class="fas fa-book"></i> Read Chapter 1 (Intro to Data) of [OpenIntro Statistics](https://www.openintro.org/book/os/) and the accompanying <i class="fab fa-youtube"></i>[videos](https://www.youtube.com/playlist?list=PLkIselvEzpM6pZ76FD3NoCvvgkj_p-dE8)

-   [Overview of **R** and the tidyverse](https://evalf20.classes.andrewheiss.com/projects/01_lab/slides/01_lab.html) slides by Andrew Heiss)

## Readings

-   <i class="fas fa-newspaper-o"></i> Abstract of Hariton, E and J.J. Locascio (2018), [*Randomised controlled trials – the gold standard for effectiveness research*](https://doi.org/10.1111/1471-0528.15199)
-   <i class="fas fa-book"></i> Chapter 1 (*Preliminaries) in *Planning of experiments\*[^1]
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

{{% div fyi %}}
**Fun fact**: If you type <kbd>?</kbd> (or <kbd>shift</kbd> + <kbd>/</kbd>) while going through the slides, you can see a list of special slide-specific commands.
{{% /div %}}

## Videos

Videos for each section of the lecture are [available at this YouTube playlist](https://www.youtube.com/playlist?list=).

-   [Introduction](https://www.youtube.com/watch?v=&list=)
-   [Class details](https://www.youtube.com/watch?v=&list=)
-   [Motivation](https://www.youtube.com/watch?v=&list=)
-   [Experimental vs observational](https://www.youtube.com/watch?v=&list=)
-   [Key notions](https://www.youtube.com/watch?v=&list=)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

[^1]: David R. Cox, *Planning of Experiments* (New York, NY: Wiley, 1958).

[^2]: A. Dean, D. Voss, and D. Draguljić, *Design and Analysis of Experiments* (Springer, 2017), <https://www.springer.com/gp/book/9783319522487>.

[^3]: Paul D. Berger, Robert E. Maurer, and Giovana B. Celli, *Experimental Design with Applications in Management, Engineering, and the Sciences*, 2nd ed. (Springer, 2018), doi:[10.1007/978-3-319-64583-4](https://doi.org/10.1007/978-3-319-64583-4).
