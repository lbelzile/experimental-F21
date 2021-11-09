---
title: "Three-way analysis of variance"
linktitle: "5. Three-way ANOVA"
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

# Videos

The code created in the video [can be downloaded here](/example/05-threewayanova-video.R).

There’s a set of videos that walks through each section below. To make it easier for you to jump around the video examples, I cut the long video into smaller pieces and included them all in [one YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY).

-   [Introduction](https://www.youtube.com/watch?v=SHhP_TfZGVM&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
-   [Interaction plots](https://www.youtube.com/watch?v=I63CNxonlow&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
-   [Marginal contrast and simple effects](https://www.youtube.com/watch?v=KLLBNQhD0rE&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
-   [More contrasts and interactions](https://www.youtube.com/watch?v=WIoxZZ4pvlE&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)
-   [Effect size and power](https://www.youtube.com/watch?v=zBVX2RDjKUw&list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8IvjcV7Yl-OW_9KI6f_2K5HY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

# Notebook

We consider fictional data from Keppel & Wickens (2004) for a study on
\> the effects of verbal feedback given during the acquisition of different types of learning material on memory tested one week later.

There are three factors: the first is `feedback`, which indicates the type of verbal feedback received by the participant: either `none` ($a_1$) to serve as control group, `positive` ($a_2$) or `negative` ($a_3$) feedback. The second factor is related to the type of learning material, one of low-frequency words with low emotional content ($b_1$), high-frequency words with low emotional content ($b_2$) and finally high-frequency words with high emotional content ($b_3$). The third factor is the target population: either fifth graders ($c_1$) or high school seniors ($c_2$). While most of the interest is in the first two factors, the three-way ANOVA is a more efficient design if we want to study both age groups.

The response variable is the number of words remembered (`words`) after one week. The design is balanced: there are `\(r=5\)` replications for each scenario, so `\(n=3 \times 3 \times 2 \times 5\)` observations. If we fit the three-way model with all two ways and three way interactions, we need to estimate 19 parameters (18 means and one variance). We model each participant response assuming the measurements are independent and `\(Y_{ijkr} \sim \mathsf{No}(\mu_{ijk}, \sigma^2)\)`: this indicates that each subgroup ($a_i, b_j, c_k$) has a different (theoretical) average `\(\mu_{ijk}\)` and a common variance `\(\sigma^2\)`. The estimates `\(\widehat{\mu}_{ijk}\)` are simply the sample averages of each group, whereas the pooled variance estimator, `$$\widehat{\sigma}^2 = \frac{1}{72}\sum_{i=1}^3 \sum_{j=1}^3 \sum_{k=1}^2 \sum_{r=1}^5 (y_{ijkr} - \widehat{\mu}_{ijk})^2,$$`
is the sum of squared difference between replicate observations and their group average, divided by the residual degrees of freedom (total number of observations minus number of mean parameters).

The model can be reparametrized in terms of main effects and interaction: overall average for each factor, average of residual affect after accounting for effects of row, columns and depth and finally residual affect for the three-way. This parametrization is
`$$\begin{align*}\underset{\text{theoretical average}}{\mathsf{E}(Y_{ijkr})} &= \quad \underset{\text{global mean}}{\mu} \\ &\quad +\underset{\text{main effects}}{\alpha_i + \beta_j + \gamma_k}  \\ & \quad + \underset{\text{two-way interactions}}{(\alpha\beta)_{ij} + (\alpha\gamma)_{ik} + (\beta\gamma)_{jk}} \\ & \quad + \underset{\text{three-way interaction}}{(\alpha\beta\gamma)_{ijk}}\end{align*}$$`

## Interaction plot

We can try to infer whether there is an interaction by looking at averages for each pair of variable at a time, and then at all three factors concurrently. These plots theoretically are used to demonstrate the impact of interactions, but in practice the sample estimates are noisy proxies of the true subgroup averages.

What are comparisons of interest? We may be interested in the effect of feedback, for example comparing whether any form of feedback increases word retention. Thus, we could look at the marginal contrast `\(\mu_{1..} = \frac{1}{2}(\mu_{2..} + \mu_{3..})\)`, in essence treating the whole model as a one-way ANOVA but using all the data to estimate the standard deviation `\(\sigma\)`. For a balanced sample, the estimated average for example of the control group `none`, `\(\widehat{\mu}_{1..}\)`, would be the sample average of the 30 participants assigned to this experimental condition.

We can proceed similarly for the other factors. One could be interested in whether the type of learning material impacts retention (overall effect), or if there are difference between high and low emotional content for high-frequency occurrences ($b_2$ and `\(b_3\)`); amounting to ignoring all observations for the low emotion low-frequency group.

## References

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Keppel/Wickens:2004" class="csl-entry">

Keppel, G., & Wickens, T. D. (2004). *Design and analysis: A researcher’s handbook*. Pearson Prentice Hall.

</div>

</div>
