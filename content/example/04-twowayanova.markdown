---
title: "Two-way analysis of variance"
linktitle: "4. Two-way ANOVA"
date: "2021-10-20"
menu:
  example:
    parent: Examples
    weight: 4
type: docs
toc: true
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

# Videos

The code created in the video [can be downloaded here](/example/04-twowayanova-video.R).

There’s a set of videos that walks through each section below. To make it easier for you to jump around the video examples, I cut the long video into smaller pieces and included them all in [one YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb).

-   [Analysis of variance](https://www.youtube.com/watch?v=pxQgRTWwITI&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)
-   [Interaction plots](https://www.youtube.com/watch?v=rYudu_vns6I&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)
-   [Contrast and marginal means](https://www.youtube.com/watch?v=0ifni3rNOss&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)
-   [Effect size and power](https://www.youtube.com/watch?v=jcqpe3Z-YNs&list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8ItJKq70HCdYrRcsDUsJYKhb" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

# Notebook

We reproduce the results of Study 1 of Maglio & Polman (2014). Data were obtained from

> We carried out a 2 (orientation: toward, away from) × 4 (station: Spadina, St. George, Bloor-Yonge, Sherbourne) analysis of variance (ANOVA) on closeness ratings

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Maglio/Polman:2014" class="csl-entry">

Maglio, S. J., & Polman, E. (2014). Spatial orientation shrinks and expands psychological distance. *Psychological Science*, *25*(7), 1345–1352. <https://doi.org/10.1177/0956797614530571>

</div>

</div>
