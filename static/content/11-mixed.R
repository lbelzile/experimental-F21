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



# Curley et al. (2021+)
# Verdict spotting: investigating the effects of juror bias, evidence anchors and verdict system in jurors
# To appear in Psychiatry, Psychology and Law
# https://doi.org/10.1080/13218719.2021.1904450
# Load packages
library(tidyverse) # tidy data analysis, grammar of graphics
library(afex) # analysis of factorial experiments
library(emmeans) # estimated marginal means
options(contrasts = c("contr.sum", "contr.poly"))
# Load data
url <- "https://edsm.rbind.io/data/Curley2021.csv"
curley <- read.csv(url, header = TRUE) %>%
  mutate(id = factor(id), # cast explanatories to factor
         anchor = factor(anchor),
         vignette = factor(vignette),
         verdictsyst = factor(verdictsyst))
str(curley)
# How are conditions manipulated?
with(curley, xtabs(~ anchor + verdictsyst))
# Thus for each individual we see only two pairs of anchor + verdict system
# With only two measurements, no interaction is possible within participants
# Likewise, we cannot have interaction between subject-effect
# and with anchor and verdict system (why?)
model <- mixed(guilt ~ anchor*verdictsyst + 
                 vignette + pjaq + (1 | id),
      data = curley)
model <- lme4::lmer(guilt ~ anchor*verdictsyst + 
                      vignette + pjaq + (1 | id),
                    data = curley)
car::Anova(model, test.statistic = "F")
emmeans(model, spec = "anchor") %>% pairs()

