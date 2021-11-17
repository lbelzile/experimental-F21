---
title: "Repeated measures and mixed models"
linktitle: "10: Repeated measures and mixed models"
date: "2021-11-12"
start_date: "2021-11-08"
end_date: "2021-11-12"
menu:
  content:
    parent: Course content
    weight: 10
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "10-slides"
---

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="why-repeated-measures-tab" data-toggle="tab" href="#why-repeated-measures" role="tab" aria-controls="why-repeated-measures" aria-selected="false">Why repeated measures?</a>
</li>
<li class="nav-item">
<a class="nav-link" id="repeated-measures-tab" data-toggle="tab" href="#repeated-measures" role="tab" aria-controls="repeated-measures" aria-selected="false">Repeated measures</a>
</li>
<li class="nav-item">
<a class="nav-link" id="mixed-models-tab" data-toggle="tab" href="#mixed-models" role="tab" aria-controls="mixed-models" aria-selected="false">Mixed models</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/10-slides.html#1">
</iframe>

</div>

</div>

<div id="why-repeated-measures" class="tab-pane fade" role="tabpanel" aria-labelledby="why-repeated-measures-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/10-slides.html#why-repeated-measures">
</iframe>

</div>

</div>

<div id="repeated-measures" class="tab-pane fade" role="tabpanel" aria-labelledby="repeated-measures-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/10-slides.html#repeated-measures">
</iframe>

</div>

</div>

<div id="mixed-models" class="tab-pane fade" role="tabpanel" aria-labelledby="mixed-models-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/10-slides.html#mixed-models">
</iframe>

</div>

</div>

</div>

A script containing the **R** code generated in the slides can be [downloaded here](/content/10-slides.R)

<!--
## Videos

Videos for each section of the lecture are [available at this YouTube playlist](https://www.youtube.com/playlist?list=).

- [Introduction](https://www.youtube.com/watch?v=&list=)
- [Why repeated measures?](https://www.youtube.com/watch?v=&list=)
- [Repeated measures](https://www.youtube.com/watch?v=&list=)
- [Mixed models](https://www.youtube.com/watch?v=&list=)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
-->

## Readings

-   <i class="fas fa-book"></i>[Chapter 6 Random and Mixed-Effects Models](https://stat.ethz.ch/~meier/teaching/anova/random-and-mixed-effects-models.html) of Lukas Meier’s ANOVA and Mixed Models: A Short Intro Using R\]

## Complementary readings

-   [Chapter 11 of Oehlert (2000)](http://users.stat.umn.edu/~gary/book/fcdae.pdf)
-   <i class="fas fa-book"></i> Sections 17.1 and 17.3 of Keppel & Wickens (2004)

## In class

-   Repeated measure example for Study 2 of Bobak et al. (2019); see [paper](https://doi.org/10.1186/s41235-019-0174-3) and [helper code](/content/10-repeated-measures.R)
-   **R** demo of the `lme4` package

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Bobak:2019" class="csl-entry">

Bobak, A. K., Mileva, V. R., & Hancock, P. J. B. (2019). A grey area: How does image hue affect unfamiliar face matching? *Cognitive Research: Principles and Implications*, *4*(1), 27. <https://doi.org/10.1186/s41235-019-0174-3>

</div>

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

<div id="ref-Oehlert:2010" class="csl-entry">

Oehlert, G. (2000). *A first course in design and analysis of experiments*. W. H. Freeman. <http://users.stat.umn.edu/~gary/Book.html>

</div>

</div>
