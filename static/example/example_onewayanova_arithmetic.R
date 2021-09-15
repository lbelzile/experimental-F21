###################################################
####      Analysis of variance - Example       ####
###################################################

##
## Step 1: load and clean data
## 

# Load libraries
library(tidyverse) 
library(emmeans) # used for contrasts

# Load and reformat data
url <- "https://edsm.rbind.io/data/arithmetic.csv"
arithmetic <- read_csv(url) %>%
  mutate(group = factor(group,  
                        levels = LETTERS[1:5], 
                        labels = c("control 1",
                                   "control 2",
                                   "praised",
                                   "reproved",
                                   "ignored")))
# change labels to something more meaningful
# categorical == factor <fct> 
glimpse(arithmetic)

##
## Step 2: Compute summary statistics
##

summary_stats <- 
  arithmetic %>% 
  group_by(group) %>%
  summarize(mean = mean(score),
            sd = sd(score))
# Write down table in Rmarkdown for printing
knitr::kable(summary_stats,
             digits = 2,
             caption = "Summary statistics of arithmetic scores")

##
## Step 3: create graphs
##

# Boxplot with jittered data
# make it horizontal to ensure the labels are readable
ggplot(data = arithmetic,
       mapping = aes(y = group,
                     x = score, 
                     color = group)) +
  geom_boxplot() +
  geom_jitter(height = 0.3) +
  theme_bw() + 
  theme(legend.position = "none") +
  labs(title = "Impact of encouragement on learning outcomes",
       y = "", # empty label
       x = "scores on arithmetic test") 

##
## Step 4: Parameter estimates
##


# Parametrization 1 (default): contrasts 
# the intercept is the average of group "control 1"
# the other coefficients are mean differences relative to control 1
mod_param1 <- lm(score ~ group, data = arithmetic)
# Parametrization 2: sum-to-zero
# Intercept is average of group averages 
# other parameters are differences between Intercept and group mean
# Warning: intercept is not the (overall) mean of the response
# unless the sample is balanced (n is the same for each group)
mod_param2 <- lm(score ~ group, 
                 data = arithmetic, 
                 contrasts = list(group = contr.sum))
# Parametrization 3: mean of each group 
# Use summary statistics or 
mod_emm <- emmeans(mod_param1, specs = 'group')
# WARNING! don't use lm(score ~ 0 + group ...
# removing the 'intercept' messes up output
# you get wrong values for anova, R-square, etc.

# Notice that the standard errors are the same
# This is because the sample is balanced:
#   same number of observations in each group
# Special magic, simpler calculations and formulas
# We will see later that such a specification is optimal 
# provided the variances are the same (maximizes power)

##
## Step 5: F-test
##

# Testing the global null that there is no mean difference
ftest <- anova(mod_param1)
# Fix the column labels for easier references
broom::tidy(ftest)


##
## Step 6: Testing contrasts (planned comparisons)
##

# Suppose we were interested in praise versus control
# and we had the following hypothesis
# before we collected the data!
# (1) compare average control versus praise
# (2) effect of attention (praise or reprove) is the same
# Thus H0: average control = praised =>
# (0.5 control1 + 0.5 control2) = praised
# if we move everything to the left
# 0.5 control1 + 0.5 control2 - 1 praised + 0 reproved...
contrast_specif <- list(
  controlvspraised = c(0.5, 0.5, -1, 0, 0),
  praisedvsreproved = c(0, 0, 1, -1, 0)
)
contrasts_res <- 
  emmeans::contrast(object = mod_emm, 
                    method = contrast_specif)
# Obtain confidence intervals instead of p-values
confint(contrasts_res)

##
## Step 7: Multiple testing (post-hoc)
##

# You will sometimes see all pairwise differences reported. 
# Often, these are not of scientific interest 
# The more tests you do, the more chance of false positive
# This has a default adjustment to correct
# Tukey's honest difference
# Differences and p-values are based on pooled t-tests
pairwise_diff <- emmeans(mod_param1, pairwise ~ group)
pairwise_diff
pwpp(mod_emm, type = "response")
