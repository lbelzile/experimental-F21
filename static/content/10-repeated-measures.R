library(tidyverse)
url <- "https://edsm.rbind.io/data/Bobak2019S2.csv"
bobak_full <- read.csv(url, header = TRUE)
bobak <- bobak_full %>%
  select(pnum:diffmon) %>%
  pivot_longer(cols = starts_with("diff"),
               names_to = "color",
               names_prefix = "diff",
               values_to = "pcorr")


library(lme4)
library(lmerTest)
# TV data from Bang & Olufsen
data(TVbo, package = "lmerTest")
# Crossed factors (Picture and TVset)
# 15 response variables (characteristics of product)
# these are nested within assessors (8)
fm <- lmer(Coloursaturation ~ TVset * Picture + 
       (1 | Assessor) + 
       (1 | Assessor:TVset) + 
       (1 | Assessor:Picture), data = TVbo)
ranova(fm)
anova(fm, ddf = "Kenward-Roger")
