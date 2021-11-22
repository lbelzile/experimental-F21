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

