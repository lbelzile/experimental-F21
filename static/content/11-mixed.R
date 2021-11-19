# Illusory Increases in Font Size Improve Letter Recognition
# Martin Lages, Stephanie C. Boyle, Rob Jenkins
# Psychological Science (2017)
# http://doi.org/10.1177/0956797617705391
# Experiment 1A
library(tidyverse)
url <- "https://osf.io/tnjsu/download"
lages <- read.csv(url, header = TRUE) 
lages_long <- lages %>%
   pivot_longer(cols = NA10P1:WA25P5, # all columns in this range
                names_sep = c(2,4,6), # where to break labels,
                names_to = c("adaptation", "fontsize", "position"),
                values_to = "ncorrect") %>%
   mutate(adaptation = factor(adaptation),
          fontsize = factor(fontsize),
          position = factor(position),
          ObsID = factor(ObsID),
          Group = factor(Group))

# adaptation, fontsize and position are crossed
# ObsID is Subject effect, nested within Group
library(afex) 
model <- afex::aov_ez(id = "ObsID",
             dv = "ncorrect", 
             within = c("adaptation","position","fontsize"), 
             data = lages_long, 
             between = "Group")

effectsize::eta_squared(model, ci = FALSE)
anova(model, 
      es = "pes", #partial eta square effect size (es)
      correction = "none") # no correction for sphericity

# Quick and dirty ggplot
afex_plot(object = model, 
          x = "fontsize", 
          trace = c("adaptation","Group"),
          mapping = c("color","linetype")) +
   theme_classic() +
   theme(legend.position = "bottom") +
  labs(x = "font size",
       y = "number of correct words")
# Seems flipped relative to the paper
# 
# Contrasts
# Nonlinear effect: can we model it with a
# simple polynomial
model %>% 
  emmeans(specs = c("fontsize")) %>%
  contrast(method = "poly")
# Clear that the pattern is nonlinear...