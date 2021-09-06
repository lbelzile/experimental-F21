---
title: "Problem set 1"
linktitle: "Problem set 1"
date: "2021-08-30"
due_date: "2021-09-10"
due_time: "11:55 PM"
menu:
  evaluations:
    parent: Problem sets
    weight: 1
editor_options: 
  chunk_output_type: console
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/apa.csl"
---

## Task 1: Find an experimental study

1.  Identify a scientific paper in your research field in which an experimental study is conducted.
    *If the paper contains multiple experiments, pick a single one.*
    -   Provide a citation for the paper
    -   Briefly describe the experiment (you can simply quote the description of the database).
    -   Based on the information provided, identify the experimental units and the treatments.

## Task 2: Introduce yourself to **R** and RStudio

1.  Install **R** and Rstudio using [this guide by Andrew Heiss](/example/installr/)
2.  Complete the [Intro to **R** tutorial](http://openintrostat.github.io/oilabs-tidy/01_intro_to_r/intro_to_r.html) from OpenIntro Statistics.
3.  Complete the `learnr` tutorial: [Getting Started with Data: 3 - Sampling strategies and Experimental design](https://openintro.shinyapps.io/ims-01-data-03/)
4.  Complete the `learnr` tutorial: [Introduction to data: 1 - Language of data](https://openintro.shinyapps.io/ims-01-data-01/)

If the tutorial pages don’t load, please try again later: this is sometimes due to high traffic (the servers have limited capacities).

## Task 3: Make an RStudio Project

1.  In RStudio, go to “File” > “New File…” > “R Markdown…” and click “OK” in the dialog without changing anything.

2.  Delete all the placeholder text in that new file and replace it with this:

    ```` text
    ---
    title: "Problem set 1"
    author: "Put your name here"
    output: word_document
    ---

    ```{r load-libraries-data, warning=FALSE, message=FALSE}
    library(tidyverse)
    ```

    # Learning R

    Tell me that you worked through the primers and videos and examples at the example page for this week:

    WRITE SOMETHING HERE LIKE "I did all the primers and had the time of my life!" or whatever.
    ````

3.  Save the R Markdown file with some sort of name (**without any spaces!**)

4.  Knit your document as a Word file (or PDF if you’re brave and [installed LaTeX](/resource/install/#install-tinytex)). Use the “Knit” menu:

    <img src="/img/assignments/knit-button.png" width="30%" />

5.  Upload the knitted document to ZoneCours 🎉.

{{% div fyi %}}

You’ll be doing this same process for all your future problem sets. Each problem set will involve an R Markdown file. You can either create a new RStudio Project directory for all your work:

<img src="/img/reference/rproj-one-folder.png" width="30%" />

Or you can create individual projects for each assignment and project:

<img src="/img/reference/rproj-multiple-folders.png" width="30%" />

{{% /div %}}
