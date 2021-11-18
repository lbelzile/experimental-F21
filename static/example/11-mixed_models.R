
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

fm <- aov(Coloursaturation ~ TVset * Picture + Error(Assessor/(Picture*TVset)), data = TVbo)
