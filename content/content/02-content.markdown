---
title: "Hypothesis testing"
linktitle: "2: Hypothesis testing"
date: "2021-09-04"
start_date: "2021-09-06"
end_date: "2021-09-10"
menu:
  content:
    parent: Course content
    weight: 2
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "02-slides"
---

## Content

-   Programming premises
-   Sampling variability
-   Hypothesis testing
-   Introduction to one-way analysis of variance
-   **R** demo

## Learning objectives

At the end of the session, students should be capable of

-   understanding the mechanics behind generic hypothesis tests
-   calculating summary statistics in **R**
-   producing basic plots in **R**
-   reporting summary statistics and output of an *F*-test

## Readings

-   <i class="fas fa-book"></i> Chapter 2 of the [Course notes](https://lbelzile.github.io/math80667a/hypothesis-testing.html)
-   <i class="fas fa-book"></i> Chapter 5 (*Foundations for inference*) of [Matthew Crump’s course notes](https://www.crumplab.com/statistics/foundations-for-inference.html)
-   <i class="fas fa-file-o"></i> [The permutation test by Jared Wilson](https://www.jwilber.me/permutationtest/)

## Complementary readings

-   <i class="fas fa-file-o"></i> [Laboratory 4: ANOVA by Matthew Crump (illustrations)](https://www.crumplab.com/rstatsmethods/articles/Stats2/Lab4_ANOVA.html)

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="variability-tab" data-toggle="tab" href="#variability" role="tab" aria-controls="variability" aria-selected="false">Variability</a>
</li>
<li class="nav-item">
<a class="nav-link" id="hypothesis-testing-tab" data-toggle="tab" href="#hypothesis-testing" role="tab" aria-controls="hypothesis-testing" aria-selected="false">Hypothesis testing</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/02-slides.html#1">
</iframe>

</div>

</div>

<div id="variability" class="tab-pane fade" role="tabpanel" aria-labelledby="variability-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/02-slides.html#signal-vs-noise">
</iframe>

</div>

</div>

<div id="hypothesis-testing" class="tab-pane fade" role="tabpanel" aria-labelledby="hypothesis-testing-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/02-slides.html#hypothesis-tests">
</iframe>

</div>

</div>

</div>

## In-class

We will go over some of the basics of programming in **R** and go over a code demo for a one-way analysis of variance. The lesson will focus on

-   Importing and preprocessing data
-   Computing summary statistics
-   Basic graphics
-   Using the `aov` or `lm` functions to compute an ANOVA table.

## **R** and Rmarkdown introduction

This material by [Dr. Andrew Heiss](https://www.andrewheiss.com/) nicely goes over the presentation of the various basics of programming in **R** (including a presentation of the integrated development environment, the programming language syntax, and basics of data manipulation and graphics using the tidyverse).

-   [Project .zip file](https://evalf21.classes.andrewheiss.com/projects/01-class.zip)
-   [Lab slides 1: Markdown](https://evalf21.classes.andrewheiss.com/slides/01-class_01_markdown-writing.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_01_markdown-writing.pdf)
-   [Lab slides 2: Getting started with **R** and RStudio](https://evalf21.classes.andrewheiss.com/slides/01-class_02-getting-started.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_02-getting-started.pdf)
-   [Lab slides 3: Data basics](https://evalf21.classes.andrewheiss.com/slides/01-class_03_data-basics.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_03_data-basics.pdf)
-   [Lab slides 4: Visualize data with `ggplot2`](https://evalf21.classes.andrewheiss.com/slides/01-class_04_visualize-data.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_04_visualize-data.pdf)
-   [Lab slides 5: Transform data with `dplyr`](https://evalf21.classes.andrewheiss.com/slides/01-class_05_transform-data.html) [(PDF)](https://evalf21.classes.andrewheiss.com/slides/01-class_05_transform-data.pdf)

<!-- 
{{% div fyi %}}
**Fun fact**: If you type <kbd>?</kbd> (or <kbd>shift</kbd> + <kbd>/</kbd>) while going through the slides, you can see a list of special slide-specific commands.
{{% /div %}}





-->

## References
