# Example of one-way analysis of variance in R

# Load tidyverse packages
library(tidyverse)

# STEP 1
# Load data
# Rather than put the data in a folder and access it
# We directly fetch from the URL
url <- "https://edsm.rbind.io/data/reading.csv"
# If you need to save/access data,
# CSV is a portable standard (unlike xlsx, etc.)
reading <- read_csv(url)
# Look at data to check variable type
glimpse(reading)
# <chr> indicates that 'group' is stored as character
# Use mutate to transform into a factor
# This is the correct type for categorical variables
reading <- reading %>%
  mutate(group = as_factor(group))
# Check that this did the job
head(reading)
# 'head' displays the first few rows

# STEP 1
# Compute summary statistics by treatment group
summary_stats <- reading %>%
  group_by(group) %>%
  summarize(mean = mean(pretest1),
            sd = sd(pretest1),
            n = n()) # "sd = standard deviation"
# Print the values
summary_stats
# Check that they match the ones reported in the paper


# STEP 2
# Plot the data
set.seed(2021)
# because of jittering below, the position changes
# every time you generate the figure
# the above ensures that the pseudo-random numbers
# are the same (useful for papers!)
ggplot(data = reading,
       #aesthetics: which variables to map where
       aes(x = group, 
           y = pretest1)) +
  geom_boxplot() +
  # superimpose points, jittered (only) horizontally
  geom_jitter(height = 0,
              width = 0.33) +
  # add averages
  geom_point(data = summary_stats,
             aes(y = mean),
             shape = 4, # 4 is x
             size = 2) + # double size of point
  # add meaningful labels
  labs(x = "learning strategy",
       y = "", # put in subtitle (no head tilting)
       title = "Pre-test scores",
       subtitle = "Number of sentences that don't belong to the story found (out of 16).",
       caption = "Group averages are indicated with 'x'.")

# STEP 3
# Compute the one-way analysis of variance table
# We use the "lm = linear model" function to fit this
# the first argument is a formula response ~ treatment
# where 'treatment' is the factor
pretest1_anova <- lm(formula = pretest1 ~ group,
                     data = reading)
# "anova" produces an analysis of variance table
# The relevant information includes
# 1) test statistic (`F value`)
# 2) between and within sum of square
# 3) degrees of freedom of the F null distribution (column `Df`)
# 4) p-value (`Pr(>F)`)
anova(pretest1_anova)
# Save the output in a tibble with more meaningful column names
anova_tab <- broom::tidy(anova(pretest1_anova))
# Elements include `statistic`, `df`, `p.value`
# the syntax package::function allows you to access
# functions without loading packages (or prevent disambiguation)