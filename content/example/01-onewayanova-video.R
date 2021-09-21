
######################################################
# Script produced in the Introduction channel videos #
######################################################

## Part 1: create a new Project

## Part 2: load the data in R
## Load the packages of the tidyverse
# install.packages("tidyverse") # do this once
library(tidyverse)
## Loading data
## Option 1: load data from a package
# data(arithmetic, package = "SMPracticals")
## Option 2: load data directly from an URL
url <- "https://edsm.rbind.io/data/arithmetic.csv"
arithmetic <- readr::read_csv(url, show_col_types = FALSE)
## Option 3: load data from local folder
## you need to have a subfolder data (case-sensitive)
# arithmetic <- read_csv(file = "data/arithmetic.csv")
glimpse(arithmetic)


## Part 3: clean and modify the data
## We create a vector of meaningful labels
## See help for more details
# ?SMPracticals::arithmetic
unique(arithmetic$group)
labs <- c("control 1",
          "control 2",
          "praised",
          "reproved",
          "ignored")
# Transform database: map strings, binary variables
# to factor if they are categorical variables
arithmetic <-
  arithmetic %>%
  mutate(group = factor(x = group,
                        levels = c("A","B","C","D","E"),
                        labels = labs))
## Peak at data to make sure this is correct
glimpse(arithmetic)

## Part 4: Summary statistics
## Compute summary statistics and
## save them in a new tibble
summary_stats <-
  arithmetic %>%
  group_by(group) %>%
  summarize(mean = mean(score),
            sd = sd(score),
            nobs = n())
summary_stats

## Part 5: create graphics
## Use the grammar of graphics and ggplot
## to create a nice figure

set.seed(1234)
ggplot(data = arithmetic,
       mapping = aes(y = group,
                     x = score,
                     color = group)) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(position = position_jitter(width = 0.1)) +
  labs(y = "",
       x = "score on test",
       subtitle = "Experiment for learning arithmetic") +
  theme_bw() +
  theme(legend.position = "none")

## Part 6: compute the F-statistic for the global null of
## equality of variance

## Fit the linear model (equivalent to the one-way ANOVA)
mod <- lm(formula = score ~ group, data = arithmetic)
## Create the table with the test statistic and the p-value
(anova_tab <- broom::tidy(anova(mod)))

## Check by hand the calculation of the p-value
pf(q = anova_tab$statistic[1],
   df1 = 4,
   df2 = 40,
   lower.tail = FALSE)
