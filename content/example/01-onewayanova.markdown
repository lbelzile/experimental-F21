---
title: "One-way analysis of variance"
linktitle: "1. One way ANOVA"
date: "2021-09-11"
menu:
  example:
    parent: Examples
    weight: 1
type: docs
toc: true
editor_options: 
  chunk_output_type: console
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>

<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />

# Videos

There’s a set of videos that walks through each section below. To make it easier for you to jump around the video examples, I cut the long video into smaller pieces and included them all in [one YouTube playlist](https://www.youtube.com/playlist?list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H).

-   [RStudio interface](https://www.youtube.com/watch?v=utGd_kt0pdw&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Loading data](https://www.youtube.com/watch?v=mMcSFqGal0w&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Cleaning and transforming data](https://www.youtube.com/watch?v=1YYlLZ90Vas&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Summary statistics](https://www.youtube.com/watch?v=PvHFsiuase0&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [Creating graphics](https://www.youtube.com/watch?v=lNUC5_Tws9M&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)
-   [F-statistic table](https://www.youtube.com/watch?v=7ysgXYx6Rwg&list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H)

You can also watch the playlist (and skip around to different sections) here:

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/playlist?list=PLUB8VZzxA8It9TOT1em71xjGZM-Fcvm4H" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
</iframe>

</div>

# Notebook

This notebook shows the various manipulation that an experimenter may undertake to test whether the population averages are the same based on some experimental data.

## Working directory and packages

If you start your analysis in a new project, the default directory is where the project lies: `getwd()` will indicate where **R** expects to see files. You can load packages using `library`, provided they have been installed beforehand using `install.packages()`. A package is a collection of function and datasets that you can access for various tasks: you need only buy a reference textbook once (installing packages), whereas you can read of anything if you take the book off your bookshelf from there onwards (loading the package). For the most part, we will work with the `tidyverse` package, a simple wrapper that loads multiple libraries that adhere to common principles (tidy data analysis) and whose code more closely ressemble logical workflow and proper English instructions than base **R**. However, the function syntax is not set in stone and evolves over time.

You will sometimes encounter the double colon syntax `package::function`: normally, you can only access functions and objects from packages that are loaded, but to avoid disambiguation and clarity it is sometimes helpful to specify directly which package the function is from (especially if many packages have functions that go by the same name). When you load a package, it will hide existing functions in already loaded packages: thus, but if you only need to access/use a single function from a package, it may be simpler to refer to it directly.

## Importing data

The first task you need to undertake is to download and manipulate the data in a format that is amenable to conducing statistical analysis. This can take many forms: data sets can be found directly in **R** packages, downloaded directly given a web address (URL) or else downloaded into a data folder and loaded into the environment.

It is good practice **not** to manipulate the raw data using a spreadsheet software like Microsoft Excel, which is infamous for it’s awkward manipulation (the French version Office doesn’t recognize or save `.csv` files as being comma-separated values, [strings are converted to dates and numerical values](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-1044-7), [oftentimes inconsistantly](https://rohanalexander.com/posts/2020-04-14-tidying-the-2019-kenyan-census/), [the number of columns is limited](https://theconversation.com/why-you-should-never-use-microsoft-excel-to-count-coronavirus-cases-147681), etc. Rather, keep a copy of the raw data, a script in which you manipulate it and, if necessary, a clean and tidy version in another database. This ensures that you do not mistakenly change records and can easily modify your data analysis if you realize that the data were incorrect at some stage due to manipulation or incorrect interpretation.

Depending on the format (particularly if you have SAS, SPSS or Stata formatted datasets, there may be hidden labels that contain information about the variables. The `haven` package, part of the tidyverse, imports the metadata alongside with the observations.

## Study

We consider data from Baumann et al. (1992). The abstract of the paper provides a brief description of the study

> This study investigated the effectiveness of explicit instruction in think aloud as a means to promote elementary students’ comprehension monitoring abilities. Sixty-six fourth-grade students were randomly assigned to one of three experimental groups: (a) a Think-Aloud (TA) group, in which students were taught various comprehension monitoring strategies for reading stories (e.g., self-questioning, prediction, retelling, rereading) through the medium of thinking aloud; (b) a Directed Reading-Thinking Activity (DRTA) group, in which students were taught a predict-verify strategy for reading and responding to stories; or (c) a Directed Reading Activity (DRA) group, an instructed control, in which students engaged in a noninteractive, guided reading of stories. The primary quantitative analyses involved two planned orthogonal contrasts—effect of instruction (TA + DRTA vs. 2 x DRA) and intensity of instruction (TA vs. DRTA)—for three whole-sample dependent measures: (a) an error detection test, (b) a comprehension monitoring questionnaire, and (c) a modified cloze test.

We have multiple columns for each of the tests (pre-intervention and post-intervention) from Baumann et al. (1992). For the time being, we focus on the first, `pretest`, which was used to act as control and to ensure that the random allocation of students to the three treatment groups resulted in similar average performances. This allows allows us to perform paired comparisons at a later stage by subtracting post- and pre-intervention scores to check their progress.

The reader is invited at this stage to look at the description of the first task (*Pretest 1*) and the findings presented on p.148 of Baumann et al. (1992). We aim to reproduce their results here.

``` r
# Load packages
library(tidyverse)
# Load data
# We directly fetch the data from the URL
url <- "https://edsm.rbind.io/data/reading.csv"
reading <- readr::read_csv(url, show_col_types = FALSE)
```

The first column, `group`, is stored as a string (of type `character` or `<chr>`, indicating that the values are text). In **R**, [categorical variables](https://lbelzile.github.io/math80667a/introduction.html#review-of-basic-concepts) are stored as objects of type `factor`, so we need first to tell the software that the labels `"DR"`, `"DRTA"`, `"TA"`, stored as strings, corresponds to different categories labels. We use mutate to transform `group` into a `factor` and leave the other variables unchanged (`<dbl>`, which stands for double, indicates numerical values).

``` r
reading <- reading %>%
  mutate(group = as_factor(group))
# Look at data to check variable type
glimpse(reading)
```

    ## Rows: 66
    ## Columns: 6
    ## $ group     <fct> DR, DR, DR, DR, DR, DR, DR, DR, DR, DR, DR, DR, DR, DR, DR, …
    ## $ pretest1  <dbl> 4, 6, 9, 12, 16, 15, 14, 12, 12, 8, 13, 9, 12, 12, 12, 10, 8…
    ## $ pretest2  <dbl> 3, 5, 4, 6, 5, 13, 8, 7, 3, 8, 7, 2, 5, 2, 2, 10, 5, 5, 3, 4…
    ## $ posttest1 <dbl> 5, 9, 5, 8, 10, 9, 12, 5, 8, 7, 12, 4, 4, 8, 6, 9, 3, 5, 4, …
    ## $ posttest2 <dbl> 4, 5, 3, 5, 9, 8, 5, 5, 7, 7, 4, 4, 6, 8, 4, 10, 3, 5, 5, 3,…
    ## $ posttest3 <dbl> 41, 41, 43, 46, 46, 45, 45, 32, 33, 39, 42, 45, 39, 44, 36, …

We are now ready to proceed with the data analysis.

## Summary statistics

We have seen that although they may come from the same population, the sample estimates will never coincide with the population values exactly because of sampling variability. We compute summary statistics by treatment group: for this, we use the pipe, `%>%`, which takes the object on the left and passes it on the right (this is the logical workflow), then `group_by` to split into separate groups and `summarize` to create a new `tibble` containing the descriptive statistics. The result is stored in `summary_stats` (note the assignment using the `<-` operator) on the first line.

``` r
summary_stats <- reading %>%
  group_by(group) %>%
  summarize(mean = mean(pretest1),
            sd = sd(pretest1), # "sd = standard deviation, i.e., sqrt(variance)"
            n = n()) 
```

We can print the table in Rmarkdown.

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 1: Summary statistics of pretest 1.
</caption>
<thead>
<tr>
<th style="text-align:left;">
group
</th>
<th style="text-align:right;">
mean
</th>
<th style="text-align:right;">
sd
</th>
<th style="text-align:right;">
n
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
DR
</td>
<td style="text-align:right;">
10.5
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
22
</td>
</tr>
<tr>
<td style="text-align:left;">
DRTA
</td>
<td style="text-align:right;">
9.7
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
22
</td>
</tr>
<tr>
<td style="text-align:left;">
TA
</td>
<td style="text-align:right;">
9.1
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
22
</td>
</tr>
</tbody>
</table>

Check that the summary statistics match the ones reported in the paper.

If you pay closer attention to the data and their description, you will note that the response variable, which represents the number of correctly identified text insertions (out of 16) is discrete and bounded above by 16 and below by zero. The averages (and maximum) are high. The article mentions that the second task `posttest1` was made more difficult due to fear that student improvement would lead them to successfully detect most statements (with more people getting the maximum possible score, thus making comparisons of capabilities more difficult). One would need to rescale the scores if we wished to make meaningful comparisons between the two because the denominator differ.

## Graphics

Summary statistics are useful indicators, but they potentially hide aspects of the data. It is useful to plot the data (and sometimes include graphics in articles) to show the reader features or artefacts of the latter.

Our data here consists of a categorical variable, `group`, and a numerical variable, `pretest1`. There are multiple choices of graphics, including dot plots, box-and-whisker plots, or simply scatterplots, jittered to avoid overplotting. These can be combined using raincloud plots. Below, I show a boxplot, the data points and finally the sample average.

We explore below some potential choices and present a final product that is camery-ready for publication. I strongly advice that you produce graphics that are standalone: they should be interpretable once extracted from the paper with their caption.

``` r
set.seed(2021)
# because of jittering below, the position changes
# every time you generate the figure
# the above ensures that the pseudo-random numbers
# are the same (useful for papers!)
ggplot(data = reading,
       #aesthetics: which variables to map where
       aes(x = group, 
           y = pretest1,
           col = group)) +
  geom_boxplot(
    width = 0.2, # change width
    position = position_nudge(x = -0.2, y = 0)) + 
  # offset to the left
  # add rugs for observations
  # move to right of boxplot
  geom_point(shape = 95, # a horizontal bar
             size = 4, # size of bar
             alpha = 0.5, # transparency 1=opaque, 0=transparent
             position = position_nudge(x = 0.2, y = 0)) +
  # add averages
  geom_point(data = summary_stats,
             aes(y = mean),
             shape = 4, # 4 is cross (x)
             size = 2,# double size of point
             position = position_nudge(x = -0.2, y = 0)) + 
  # add meaningful labels
  labs(x = "learning strategy",
       y = "", # put in subtitle (no head tilting)
       title = "Pre-test scores",
       subtitle = "Number of sentences that don't belong to the story found (out of 16).",
       caption = "Group averages are indicated with 'x'.") + 
  theme_minimal() + # change theme (color of background, etc.)
  theme(legend.position = "none") #remove legend
```

<div class="figure">

<img src="/example/01-onewayanova_files/figure-html/graphics-1.png" alt="Results of pretest 1 based on treatment allocation." width="672" />
<p class="caption">
Figure 1: Results of pretest 1 based on treatment allocation.
</p>

</div>

## Hypothesis testing

We are now ready to compute the one-way analysis of variance table, which includes quantities that enter the *F*-statistic (named after its large-sample null distribution, which is an *F*-distribution). The *F* stands for Fisher, who pioneered much of the work on experimental design.

We use the `lm` function function to fit the model: an analysis of variance is a special case of linear model, in which the explanatory variables are categorical variables.
The first argument of the function is a formula `response ~ treatment`, where `treatment` is the factor or categorical variable indicating the treatment.

The function `anova` is a method: when applied to the result of a call to `lm`, it produces an analysis of variance table including amount other things the following relevant information:

1.  the value of the test statistic (`F value`)
2.  the between and within sum of square (these are quantities that enter in the formula of the statistic)
3.  the degrees of freedom of the *F* null distribution (column `Df`): these specify the parameters of the large-sample approximation for the null distribution, which is our default benchmark.
4.  The *p*-value (`Pr(>F)`), which gives the probability of observing an outcome as extreme if there was no difference.

We need to decide beforehand the level of the test (typically 5% or lower): this is the percentage of times we will reject the null hypothesis when its true based on observing an extreme outcome. We are asked to perform a binary decision (reject or fail to reject): if the *p*-value is less than the level, we ‘reject’ the null hypothesis of equal (population) means.

``` r
pretest1_anova <- lm(formula = pretest1 ~ group,
                     data = reading)
anova_table <- anova(pretest1_anova)
# Save the output in a tibble with more meaningful column names
anova_tab <- broom::tidy(anova_table)
# Elements include `statistic`, `df`, `p.value`
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>
Table 2: Analysis of variance table
</caption>
<thead>
<tr>
<th style="text-align:left;">
Terms
</th>
<th style="text-align:right;">
Degrees of freedom
</th>
<th style="text-align:right;">
Sum of squares
</th>
<th style="text-align:right;">
Mean square
</th>
<th style="text-align:right;">
Statistic
</th>
<th style="text-align:right;">
p-value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
group
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
20.58
</td>
<td style="text-align:right;">
10.288
</td>
<td style="text-align:right;">
1.13
</td>
<td style="text-align:right;">
0.33
</td>
</tr>
<tr>
<td style="text-align:left;">
Residuals
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
572.45
</td>
<td style="text-align:right;">
9.087
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
</tr>
</tbody>
</table>

There isn’t strong evidence of difference in strength between groups prior to intervention. We can report the findings as follows:

We carried a one-way analysis for the pre-test results to ensure that the group abilities are the same in each treatment group; results show no significant differences at the 5% level ($F$ (2, 63) = 1.13, `\(p\)` = 0.329).

<div id="refs" class="references csl-bib-body hanging-indent" line-spacing="2">

<div id="ref-Baumann:1992" class="csl-entry">

Baumann, J. F., Seifert-Kessell, N., & Jones, L. A. (1992). Effect of think-aloud instruction on elementary students’ comprehension monitoring abilities. *Journal of Reading Behavior*, *24*(2), 143–172. <https://doi.org/10.1080/10862969209547770>

</div>

</div>
