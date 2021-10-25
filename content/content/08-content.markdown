---
title: "Unbalanced designs, polynomial regression"
linktitle: "8: Unbalanced designs, polynomial regression"
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

## Learning objectives

At the end of the session, students should be capable of

-   Explain why balanced designs are prefered
-   Understand impacts of unbalanced designs on estimation and testing
-   fit a polynomial model for a single continuous factor and test for simpler alternatives

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="unbalanced-designs-tab" data-toggle="tab" href="#unbalanced-designs" role="tab" aria-controls="unbalanced-designs" aria-selected="false">Unbalanced designs</a>
</li>
<li class="nav-item">
<a class="nav-link" id="polynomial-regression-tab" data-toggle="tab" href="#polynomial-regression" role="tab" aria-controls="polynomial-regression" aria-selected="false">Polynomial regression</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#1">
</iframe>

</div>

</div>

<div id="unbalanced-designs" class="tab-pane fade" role="tabpanel" aria-labelledby="unbalanced-designs-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#unbalanced-designs">
</iframe>

</div>

</div>

<div id="polynomial-regression" class="tab-pane fade" role="tabpanel" aria-labelledby="polynomial-regression-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#polynomial">
</iframe>

</div>

</div>

</div>

A script containing the **R** code generated in the slides can be [downloaded here](/content/08-slides.R)

## Videos

Videos for each section of the lecture are [available at this YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8IvW4nMt4LWk8JmAejj5wJdH).

-   [Introduction](https://www.youtube.com/watch?v=&list=PLUB8VZzxA8IvW4nMt4LWk8JmAejj5wJdH)
-   [Unbalanced designs](https://www.youtube.com/watch?v=Rss0bSmONz0&list=PLUB8VZzxA8IvW4nMt4LWk8JmAejj5wJdH)
-   [Polynomial regression](https://www.youtube.com/watch?v=HTXUHpa6Eio&list=PLUB8VZzxA8IvW4nMt4LWk8JmAejj5wJdH)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8IvW4nMt4LWk8JmAejj5wJdH" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

## Readings

-   Section 8.8.1 of Dean et al. (2017)

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 8 of Dean et al. (2017)
-   <i class="fas fa-book"></i> Chapters 5 and 14 of Keppel & Wickens (2004)
-   <i class="fas fa-book"></i> [*The ANOVA controversy* by Falk Scholer](http://wight.seg.rmit.edu.au/fscholer/anova.php)
    <!--
    - <i class="fas fa-book"></i> Chapters 8 of @Fox:2015
    -->

## In class

We will do an overview of the topics covered so far in the course, followed by a Q&A period.
We will play with unbalanced data using the Replication of Study 4a of Janiszewski & Uy (2008, Psychological Science) by J. Chandler
[(download data)](/data/Janizewski.csv)

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Dean:2017" class="csl-entry">

Dean, A., Voss, D., & Draguljić, D. (2017). *Design and analysis of experiments*. Springer. <https://www.springer.com/gp/book/9783319522487>

</div>

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

</div>
