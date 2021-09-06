---
title: "Problem set 2"
linktitle: "Problem set 2"
date: "2021-09-05"
due_date: "2021-09-17"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 2
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

## Task 1: Make an RStudio Project and work with **R**

We will analyze data from Clayton (2018a), obtained from Clayton (2018b). The data contains measures of implicit bias for multiple participants from “in-field implicit association tests”. The database includes the following variables:

-   `age`: of the respondant
-   `village`: village of the respondant
-   `female`: a binary indicator for gender equal to unity for female and zero otherwise
-   `d.score`: the participant [Implicit Association Test (IAT) result](https://implicit.harvard.edu/implicit/iatdetails.html)
-   `quota`: binary indicator of treatment, unity if there is a quota and zero otherwise
-   `under25`: binary indicator, equal to unity if the respondant age is less than or equal to 25 years.

1.  Use RStudio on your computer to create a new RStudio Project.

2.  Create a folder named “data” in the project folder you just made.

3.  Download this CSV file and place it in that folder:

    -   [<i class="fas fa-file-csv"></i> `ImplicitBias2014.csv`](/data/ImplicitBias2014.csv)

4.  In RStudio, go to “File” > “New File…” > “R Markdown…” and click “OK” in the dialog without changing anything.

5.  Delete all the placeholder text in that new file and replace it with this:

    ```` text
    ---
    title: "Problem set 2"
    author: "Put your name here"
    output: html_document
    ---

    ```{r load-libraries-data, warning=FALSE, message=FALSE}
    library(tidyverse)

    implicit <- read_csv("data/ImplicitBias2014.csv")
    glimpse(implicit)
    ```

    # My first plots

    Insert a chunk below and use it to create a scatterplot (hint: `geom_point()`) with age (`age`) on the x-axis, IAT score (`d.score`) on the y-axis, and with the points colored by gender (`female`).

    PUT CHUNK HERE

    Insert a chunk below and use it to create a box-and-whiskers plots (hint: `geom_boxplot()`) with IAT score (`d.score`) on the y-axis and `quota` (map to `factor`) on the x-axis observations with `geom_jitter` (adjust the width accordingly to avoid overlap). Try facetting by gender (`female`).

    PUT CHUNK HERE


    # My first data manipulation

    Insert a chunk below and use it to calculate the average IAT score (`d.score`) by gender (`female`) and assignment to treatment variable (`quota`). This will return a table. Hint: use a combination of `group_by()` and `summarize()`.

    PUT CHUNK HERE
    ````

6.  Save the R Markdown file with some sort of name (**without any spaces!**)

7.  Your project folder should look something like this:

    <img src="/img/assignments/project-structure.png" width="30%" />

8.  Remove the text that says “PUT CHUNK HERE” and insert a new R code chunk. Either type <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>i</kbd> on Windows, or <kbd>⌘</kbd> + <kbd>⌥</kbd> + <kbd>i</kbd> on macOS, or use the “Insert Chunk” menu:

    <img src="/img/assignments/insert-chunk-button.png" width="19%" />

9.  Follow the instructions for the three chunks of code.

10. Knit your document as a Word file (or PDF if you’re brave and [installed LaTeX](/resource/install/#install-tinytex)). Use the “Knit” menu:

    <img src="/img/assignments/knit-button.png" width="30%" />

11. Upload the knitted document to ZoneCours 🎉

## Task 2: One-way analysis of variance

Please use the same workflow as in Task 1.

1.  Download the data file `Study_1_Data.sav` for Experiment 1 from Bastian et al. (2014), [from OSF](https://osf.io/9k3sw/) and put it in the `data` folder. Load it in your Rmarkdown script using

    ``` text
    library(tidyverse)
    dat_raw_pain <- haven::read_sav(file = "Study_1_Data.sav")
    dat_pain <- dat_raw_pain %>%  
       rowwise() %>% 
       transmute(bonding = mean(c_across(group101:group107)),
                 condition = as_factor(condition))
    ```

2.  Create a table of summary statistics with, for each group:

    1.  the sample mean, `mean`
    2.  the standard deviation, `sd`
    3.  the sample size per group, `n()`
    4.  the standard error of the mean, `se = sd/sqrt(n())`
    5.  the lower bound of the 95% confidence interval,
        -   `lower = mean - qt(0.975, df = n() - 1)*se`, with `mean` and `se` from above
    6.  the upper bound of the 95% confidence interval

The commands `group_by` and `summarize` from the `dplyr` library will prove useful.

3.  Figure 1 of Bastian:2014 shows a dynamite plot, i.e., bar plot with 95% confidence intervals for each condition. Note that this is standard display, but overall it is poor graphical choice[(why?)](https://simplystatistics.org/2019/02/21/dynamite-plots-must-die/)

**Create a graphic to summarize the information in the sample**: try to strike a balance between the quantity of information and the clarity of the display.

Standard graphical displays include box-and-whisker plots (`geom_boxplot`), violin plots (`geom_violin`), dotplot (`geom_dotplot`) with potentially jittered observations added to the display. Multiple displays can be combined using a raincloud plot [(click for examples).](https://z3tt.github.io/Rainclouds/) [This page](https://www.cedricscherer.com/2021/06/06/visualizing-distributions-with-raincloud-plots-and-how-to-create-them-with-ggplot2/#back2) describes different visualizations and how they can be misleading. There is a [`raincloudplots`](https://github.com/jorvlan/raincloudplots) package, and the `ggdist` package includes many interesting geoms for univariate distributions.

<!--
If you wanted to reproduce Figure 1 nevertheless, here are some instructions:

- Create a bar plot using `geom_col` with your tibble of summary statistics as input data, with `condition` on the x-axis and `bonding` on the y-axis;
- Use `geom_errorbar` to overlay the confidence intervals (you will need to specify the aesthetics `ymin` and `ymax` for the respective limits of the intervals);
- The range of the y-axis can be restricted to the range (2,5) via `coord_cartesian(ylim = c(2,5))` to match that of the paper.
-->

Make sure you provide a title, clearly label your axes (with units) so that the graph is standalone.
Be creative and explore, but don’t waste too much time!

4.  Perform the one-way ANOVA and print the output. Extract the degrees of freedom, the value of the `\(F\)`-statistic and the *p*-value, suitably rounded and report these.

The paper can be downloaded via [OpenStats Lab](http://www.google.com/url?q=http%3A%2F%2Fjournals.sagepub.com%2Fstoken%2Fdefault%2Bdomain%2FyFi5kZDGWMGBNQY62zIE%2Ffull&sa=D&sntz=1&usg=AFQjCNEgRSiQLzbjFcLTBNEsoPdzjV1-ng).

<!--

TO BE COMPLETED

Using **R**, answer the following questions:

## Task 1: 

The standard error of the average difference between treatments `\(A\)` and `\(B\)` with equal variability is
$$
\text{std. dev} \times \sqrt{ \frac{1}{\text{nb of cases in }A} + \frac{1}{\text{nb of cases in }B}}
$$

- What is the best way to allocate a sample of 100 observations between the two groups? Create a plot illustrating the relationship between the number of observations assigned to treatment `\(A\)` versus `\(B\)` (the plot should give the variability on the `\(y\)`-axis and the sample size in say treatment group `\(A\)` on the `\(x\)`-axis. 
- What is the optimum share of cases for `\(A\)` versus `\(B\)`? Explain why this result is logical.
- Using the optimal fraction you identified, by how much does the standard error decreases if we increase the sample size hundred-fold, i.e., we go from 100 to 10,000 observations?
- Do you think we can act on the standard deviation `\(\text{std. dev}\)` term as experimenter? Why or why not, and what could it represent in your context.

-->

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Bastian:2014" class="csl-entry">

Bastian, B., Jetten, J., & Ferris, L. J. (2014). Pain as social glue: Shared pain increases cooperation. *Psychological Science*, *25*(11), 2079–2085. <https://doi.org/10.1177/0956797614545886>

</div>

<div id="ref-Clayton:2018" class="csl-entry">

Clayton, A. (2018a). Do gender quotas really reduce bias? Evidence from a policy experiment in Southern Africa. *Journal of Experimental Political Science*, *5*(3), 182--194. <https://doi.org/10.1017/XPS.2018.8>

</div>

<div id="ref-Clayton:2018data" class="csl-entry">

Clayton, A. (2018b). *<span class="nocase">Replication Data for: “Do Gender Quotas Really Reduce Bias? Evidence from a Policy Experiment in Southern Africa.”</span>* (Version V1) \[Data set\]. Harvard Dataverse. <https://doi.org/10.7910/DVN/0DE35E>

</div>

</div>
