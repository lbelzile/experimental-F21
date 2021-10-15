---
title: "Factorial designs"
linktitle: "7: Factorial designs"
date: "2021-10-12"
start_date: "2021-10-11"
end_date: "2021-10-15"
menu:
  content:
    parent: Course content
    weight: 7
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "07-slides"
---

## Content

-   Randomized block designs
-   Three-way analysis of variance
-   Marginal means and custom contrasts for multifactorial designs

## Learning objectives

At the end of the session, students should be capable of

-   use randomized block designs to reduce the error
-   list under which circumstances blocking is adequate
-   interpret a factorial design
-   correctly parametrize and interpret a three-way analysis of variance model
-   correctly specify hypothesis of interest and tests for interactions

## Readings

-   <i class="fas fa-book"></i> Chapters 7 and 10 of Dean et al. (2017)

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 8 of Fox (2015)
-   <i class="fas fa-book"></i> Chapters 21 and 22 of Keppel & Wickens (2004)

## In class

As a refresher, we consider a small example of two-way analysis of variance using data from Example 6.4 (First United Federal Bank of Boston) of Berger et al. (2018) on bank tellers: 100 tellers these were offered one-on-one training with an experienced clerk for a certain number of weeks on the job, possibly in addition to formal training period. The goal of the study is to determine which combination is most efficient at reducing the monthly error in balance (in dollars).

Download [the starter code](/example/07-twowayanova.R) and answer the following questions:

1.  Produce a plot of the monthly error per teller as a function of the number of weeks of one-on-one training.
2.  Is there an interaction between number of weeks of one-on-one training and the formal training?
3.  Compute pairwise contrasts between weeks of one-on-one supervision for the case of people with formal training.
4.  Compare the difference in errors between 8 and 4 weeks of one-to-one supervision, for people with and without formal training.

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="blocking-tab" data-toggle="tab" href="#blocking" role="tab" aria-controls="blocking" aria-selected="false">Blocking</a>
</li>
<li class="nav-item">
<a class="nav-link" id="multifactorial-designs-tab" data-toggle="tab" href="#multifactorial-designs" role="tab" aria-controls="multifactorial-designs" aria-selected="false">Multifactorial designs</a>
</li>
<li class="nav-item">
<a class="nav-link" id="custom-contrasts-and-marginal-means-tab" data-toggle="tab" href="#custom-contrasts-and-marginal-means" role="tab" aria-controls="custom-contrasts-and-marginal-means" aria-selected="false">Custom contrasts and marginal means</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/07-slides.html#1">
</iframe>

</div>

</div>

<div id="blocking" class="tab-pane fade" role="tabpanel" aria-labelledby="blocking-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/07-slides.html#blocking">
</iframe>

</div>

</div>

<div id="multifactorial-designs" class="tab-pane fade" role="tabpanel" aria-labelledby="multifactorial-designs-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/07-slides.html#factorial-designs">
</iframe>

</div>

</div>

<div id="custom-contrasts-and-marginal-means" class="tab-pane fade" role="tabpanel" aria-labelledby="custom-contrasts-and-marginal-means-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/07-slides.html#contrasts">
</iframe>

</div>

</div>

</div>

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Berger:2018" class="csl-entry">

Berger, P. D., Maurer, R. E., & Celli, G. B. (2018). *Experimental design with applications in management, engineering, and the sciences* (2nd ed.). Springer. <https://doi.org/10.1007/978-3-319-64583-4>

</div>

<div id="ref-Dean:2017" class="csl-entry">

Dean, A., Voss, D., & Draguljić, D. (2017). *Design and analysis of experiments*. Springer. <https://www.springer.com/gp/book/9783319522487>

</div>

<div id="ref-Fox:2015" class="csl-entry">

Fox, J. (2015). *Applied regression analysis and generalized linear models*. SAGE Publications. <https://us.sagepub.com/en-us/nam/applied-regression-analysis-and-generalized-linear-models/book237254>

</div>

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

</div>
