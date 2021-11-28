---
title: "Within-subjects and mixed designs"
linktitle: "11: Within-subjects and mixed designs"
date: "2021-11-14"
start_date: "2021-11-15"
end_date: "2021-11-19"
menu:
  content:
    parent: Course content
    weight: 11
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
slides: "11-slides"
---

## Learning objectives

At the end of the session, students should be capable of

-   Drawing a Hasse diagram to obtain the degrees of freedom and correctly set up the model in a mixed design
-   Choosing the correct source of error in a design with random factors.

## Slides

The slides for today’s lesson are available online as an HTML file. Use the buttons below to open the slides either as an interactive website or as a static PDF (for printing or storing for later). You can also click in the slides below and navigate through them with your left and right arrow keys.

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="introduction-tab" data-toggle="tab" href="#introduction" role="tab" aria-controls="introduction" aria-selected="true">Introduction</a>
</li>
<li class="nav-item">
<a class="nav-link" id="hasse-diagrams-tab" data-toggle="tab" href="#hasse-diagrams" role="tab" aria-controls="hasse-diagrams" aria-selected="false">Hasse diagrams</a>
</li>
<li class="nav-item">
<a class="nav-link" id="withinsubjects-and-mixed-designs-tab" data-toggle="tab" href="#withinsubjects-and-mixed-designs" role="tab" aria-controls="withinsubjects-and-mixed-designs" aria-selected="false">Within-subjects and mixed designs</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="introduction" class="tab-pane fade show active" role="tabpanel" aria-labelledby="introduction-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/11-slides.html#1">
</iframe>

</div>

</div>

<div id="hasse-diagrams" class="tab-pane fade" role="tabpanel" aria-labelledby="hasse-diagrams-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/11-slides.html#hasse-diagrams">
</iframe>

</div>

</div>

<div id="withinsubjects-and-mixed-designs" class="tab-pane fade" role="tabpanel" aria-labelledby="withinsubjects-and-mixed-designs-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/11-slides.html#within-design-mixed">
</iframe>

</div>

</div>

</div>

<!--
## Videos

Videos for each section of the lecture are [available at this YouTube playlist](https://www.youtube.com/playlist?list=).

- [Introduction](https://www.youtube.com/watch?v=&list=)
- [Hasse diagrams](https://www.youtube.com/watch?v=&list=)
- [Within-subjects and mixed designs](https://www.youtube.com/watch?v=&list=)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
-->

## Readings

-   [Chapter 12 (12.1 to 12.6) of Oehlert (2000)](http://users.stat.umn.edu/~gary/book/fcdae.pdf)

## Complementary readings

-   <i class="fas fa-book"></i> Chapter 15 of Abdi et al. (2009)
-   <i class="fas fa-book"></i> Chapters 18 and 19 of Keppel & Wickens (2004)
    <!--
    - <i class="fas fa-book"></i> Chapters 17 and 18 of @Dean:2017 
    -->

## In-class

-   Hasse diagrams (board)
-   Examples of within and mixed designs, including
    -   [Example of chocolat raters from Meier’s *ANOVA and Mixed Models: A Short Intro Using R*, Section 6.6.2](https://stat.ethz.ch/~meier/teaching/anova/random-and-mixed-effects-models.html#example-chocolate-data)
    -   Lages et al. (2017) ([download code](/content/11-mixed_b.R), [PDF of drawing](/content/Lages_Boyle_Jenkins-2017-Hasse_diagram.pdf))
    -   Curley et al. (2021+) ([download code](/content/11-mixed_c.R)) - note that this is an incomplete design.
-   Additional examples not discussed in class
    -   Singmann & Klauer (2011) ([download paper](http://singmann.org/download/publications/Singmann%20&%20Klauer%20(2011).pdf), [vignette](https://mran.microsoft.com/web/packages/afex/vignettes/afex_anova_example.html), [PDF of drawing](/content/Singmann_Klauer2011_E2-Hasse_diagram.pdf), [code](/content/11-mixed_a.R))
    -   Analysis of data from Table 18.3 of Keppel & Wickens (2004) ([download code](content/11-two-factor_within-subject.R))

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Abdi:2009" class="csl-entry">

Abdi, H., Edelman, B., Valentin, D., & Dowling, W. J. (2009). *Experimental design and analysis for psychology*. Oxford University Press. <https://global.oup.com/academic/product/experimental-design-and-analysis-for-psychology-9780199299881?cc=ca&lang=en&#>

</div>

<div id="ref-Curley:2021" class="csl-entry">

Curley, L. J., Murray, J., MacLean, R., Munro, J., Lages, M., Frumkin, L. A., Laybourn, P., & Brown, D. (2021+). Verdict spotting: Investigating the effects of juror bias, evidence anchors and verdict system in jurors. *Psychiatry, Psychology and Law*, 1–22. <https://doi.org/10.1080/13218719.2021.1904450>

</div>

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

<div id="ref-Lages:2017" class="csl-entry">

Lages, M., Boyle, S. C., & Jenkins, R. (2017). Illusory increases in font size improve letter recognition. *Psychological Science*, *28*(8), 1180–1188. <https://doi.org/10.1177/0956797617705391>

</div>

<div id="ref-Oehlert:2010" class="csl-entry">

Oehlert, G. (2000). *A first course in design and analysis of experiments*. W. H. Freeman. <http://users.stat.umn.edu/~gary/Book.html>

</div>

<div id="ref-Singmann/Klauer:2011" class="csl-entry">

Singmann, H., & Klauer, K. C. (2011). Deductive and inductive conditional inferences: Two modes of reasoning. *Thinking & Reasoning*, *17*(3), 247–281.

</div>

</div>
