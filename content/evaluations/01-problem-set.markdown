---
title: "Problem set 1"
linktitle: "Problem set 1"
date: "2021-09-01"
due_date: "2021-09-10"
due_time: "11:55 PM"
menu:
  assignment:
    parent: Problem sets
    weight: 1
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---

## Task 1: 

1. Identify a scientific paper in your research field in which an experimental study is conducted. 
	- Provide a citation for the latter, briefly describe the experiment (you can simply quote the description of the database). 
 	- Based on the information provided, identify the experimental units and the treatments.

## Task 2: Introduce yourself to **R**, RStudio, and the tidyverse

1. Go the the example page for this week, ["Welcome to **R**, RStudio, and the tidyverse"](/example/rstudio-tidyverse/) by Andrew Heiss, and work through the different primers and videos in the four parts of the page.
2. Alternatively, complete the [Intro to **R** tutorial](http://openintrostat.github.io/oilabs-tidy/01_intro_to_r/intro_to_r.html) from OpenIntro Statistics. 
3. Complete the `learnr` tutorial: [Introduction to data: 1 - Language of data](https://openintro.shinyapps.io/ims-01-data-01/)
4. Complete the `learnr` tutorial: [Getting Started with Data: 3 - Sampling strategies and Experimental design](https://openintro.shinyapps.io/ims-01-getting-started-with-data-03/#section-principles-of-experimental-design)

## Task 3: Make an RStudio Project

1. Use RStudio on your computer[Follow these instructions to get started!](/resource/install/)) to create a new RStudio Project. Refer to the [example page you read in Task 1 for instructions](/example/rstudio-tidyverse/#part-3-rstudio-projects)

2. Create a folder named "data" in the project folder you just made.

3. Download this CSV file and place it in that folder:

    - [<i class="fas fa-file-csv"></i> `cars.csv`](/data/cars.csv)

4. In RStudio, go to "File" > "New File…" > "R Markdown…" and click "OK" in the dialog without changing anything.

5. Delete all the placeholder text in that new file and replace it with this:

    ````text
    ---
    title: "Problem set 1"
    author: "Put your name here"
    output: html_document
    ---
    
    ```{r load-libraries-data, warning=FALSE, message=FALSE}
    library(tidyverse)
    
    cars <- read_csv("data/cars.csv")
    ```
    
    # Learning R
    
    Tell me that you worked through the primers and videos and examples at the example page for this week:
    
    WRITE SOMETHING HERE LIKE "I did all the primers and had the time of my life!" or whatever.
    
    
    # My first plots
    
    Insert a chunk below and use it to create a scatterplot (hint: `geom_point()`) with displacement (`displ`) on the x-axis, city MPG (`cty`) on the y-axis, and with the points colored by drive (`drv`).
    
    PUT CHUNK HERE
    
    Insert a chunk below and use it to create a histogram (hint: `geom_histogram()`) with highway MPG (`hwy`) on the x-axis. Do not include anything on the y-axis (`geom_histogram()` will do that automatically for you). Choose an appropriate bin width. If you're brave, facet by drive (`drv`).
    
    PUT CHUNK HERE
    
    
    # My first data manipulation
    
    Insert a chunk below and use it to calculate the average city MPG (`cty`) by class of car (`class`). This won't be a plot---it'll be a table. Hint: use a combination of `group_by()` and `summarize()`.
    
    PUT CHUNK HERE
    ````

6. Save the R Markdown file with some sort of name (**without any spaces!**)

7. Your project folder should look something like this:

    <img src="/img/assignments/project-structure.png" width="30%" />


## Task 3: Work with R

1. Remove the text that says "PUT CHUNK HERE" and insert a new R code chunk. Either type <kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>i</kbd> on Windows, or <kbd>⌘</kbd> + <kbd>⌥</kbd> + <kbd>i</kbd> on macOS, or use the "Insert Chunk" menu:

    <img src="/img/assignments/insert-chunk-button.png" width="19%" />

2. Follow the instructions for the three chunks of code.

3. Knit your document as a Word file (or PDF if you're brave and [installed LaTeX](/resource/install/#install-tinytex)). Use the "Knit" menu:

    <img src="/img/assignments/knit-button.png" width="30%" />

4. Upload the knitted document to ZoneCours.

5. 🎉 Party! 🎉


{{% div fyi %}}

You'll be doing this same process for all your future problem sets. Each problem set will involve an R Markdown file. You can either create a new RStudio Project directory for all your work:

<img src="/img/reference/rproj-one-folder.png" width="30%" />

Or you can create individual projects for each assignment and project:

<img src="/img/reference/rproj-multiple-folders.png" width="30%" />

{{% /div %}}
