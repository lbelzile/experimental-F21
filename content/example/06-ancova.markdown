---
title: "Analysis of covariance"
linktitle: "6. Analysis of covariance"
date: "2021-10-19"
menu:
  example:
    parent: Examples
    weight: 5
type: docs
toc: true
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

<!--
# Videos



There's a set of videos that walks through each section below. To make it easier for you to jump around the video examples, I cut the long video into smaller pieces and included them all in [one YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY).

- [Introduction](https://www.youtube.com/watch?v=SHhP_TfZGVM&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [Interaction plots](https://www.youtube.com/watch?v=I63CNxonlow&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [Marginal contrast and simple effects](https://www.youtube.com/watch?v=KLLBNQhD0rE&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [More contrasts and interactions](https://www.youtube.com/watch?v=WIoxZZ4pvlE&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
- [Effect size and power](https://www.youtube.com/watch?v=zBVX2RDjKUw&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">
<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
-->

The code created in the video [can be downloaded here](/example/06-ancova-video.R).

# Notebook

We consider data from Baumann et al. (1992), who conducted experiments on different teaching methods for reading. The authors randomized assignment to each of the three groups, but to account for potential differences in reading abilities, also administered tests before the experiment took place. Quoting Baumann et al. (1992)

> To statistically account for students’ pre-experimental differences in comprehension monitoring abilities, two pretests were constructed, administered, and used as covariates in data analyses for Post-tests 1-3.

We consider post-test 2, consisting of comprehension monitoring questionnaire. A similar test was assigned prior to the experiment, with minor modifications

> Three additional items were added to Pretest 2 and several others were revised so that there was better coverage and balance…

In this demonstration, we simply focus on `posttest2` as a function of `pretest2` and the `group` indicator.

# References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Baumann:1992" class="csl-entry">

Baumann, J. F., Seifert-Kessell, N., & Jones, L. A. (1992). Effect of think-aloud instruction on elementary students’ comprehension monitoring abilities. *Journal of Reading Behavior*, *24*(2), 143–172. <https://doi.org/10.1080/10862969209547770>

</div>

</div>
