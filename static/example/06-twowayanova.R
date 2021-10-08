# Class 6: Example of two-way ANOVA
# 
url <- "https://edsm.rbind.io/data/KW_tab11p8.txt"
monkey <- read.table(url, 
                     header = TRUE,
                     stringsAsFactors = TRUE)
linmod <- lm(errors ~ deprivation*drug, 
             data = monkey)
# Anova table
anova(linmod)
# Effect sizes with confidence intervals (90% by default)
effectsize::cohens_f(linmod, partial = TRUE)
effectsize::omega_squared(linmod, partial = TRUE)
effectsize::eta_squared(linmod, partial = TRUE)




# Replication of Study 4a of 
# Janiszewski & Uy (2008, Psychological Science) 
# by J. Chandler 
# See https://osf.io/aaudl
library(tidyverse)
# Load data
url <- "https://osf.io/26mxf/download"
JU_data <- haven::read_sav(file = url)
# The response is labelled 'mean2'
# the explanatories are 'anchortype' and 'magnitude'
# This is a 2x2 factorial design
# 
# Transform data so that explanatories are factors
# as_factor will automatically detect SPSS labels
JU_data <- JU_data %>%
  mutate(anchortype = as_factor(Anchortype),
         magnitude = as_factor(magnitude))
# Tasks:
# 1) compute the average in each group and create 
# a plot of the means with one-standard error
# Use `summarize` with `group_by` to create 
# a summary table and feed the result to ggplot
# with geom_line() and geom_point()
# 2) Determine if the study is balanced.
summary_tab <- 
  JU_data %>% 
  group_by(anchortype, 
           magnitude) %>% 
  summarize(nobs = n(),
            mean = mean(mean2))
# NOT BALANCED
ggplot(data = summary_tab,
       mapping = aes(x = anchortype,
                     group = magnitude,
                     color = magnitude,
                     y = mean)) + 
  geom_line() + 
  theme_classic() +
  theme(legend.position = "bottom") +
  labs(title = "Adjustment for a measure",
       x = "anchor type",
       color = "magnitude",
       y = "average")
# Lines are parallel -> no interaction


# Fit two-way ANOVA model
linmod_inter <- lm(mean2 ~ anchortype*magnitude, 
                   data = JU_data)
linmod_main <- lm(mean2 ~ anchortype + magnitude, 
                  data = JU_data) # no interaction
# Note the syntax: A*B is equivalent to A + B + A:B
# meaning interaction of A and B
anova(linmod_main, linmod_inter)
# No evidence of interaction
# CAREFUL: with unbalanced samples, 
# we lose important properties. 

# Compute marginal mean estimates
library(emmeans)
# Here, we would possibly only be interested
#  in the effect of the anchor
#  Below, we show how to obtain comparisons within
#  a level of another factor using emmeans
emm_anch <- emmeans(object = linmod_inter, 
                    pairwise ~ anchortype | magnitude)
# Careful: ignoring an interaction can lead to 
# misleading marginal means
emm_magn <- emmeans(object = linmod_inter, 
                    specs = "magnitude")
emm_all  <- emmeans(object = linmod_inter, 
                    specs = c("anchortype", "magnitude"))
