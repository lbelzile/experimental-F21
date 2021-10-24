## R Code from slides 8

# Load packages
library(tidyverse)
library(emmeans)

# This is a 2x2 factorial design
# The response is 'likelihod'
# the explanatories are 'condition' and 'gender'
url1 <- "https://edsm.rbind.io/data/RG08rep.csv"
RS_unb <- read_csv(url1, col_types = c("iiff"))
# Balanced data (obtained by dropping observations)
url2 <- "https://edsm.rbind.io/data/RG08rep_bal.csv"
RS_bal <- read_csv(url2, col_types = c("iiff"))

# Compute summary statistics
summary_stats <- 
  RS_unb %>% 
  group_by(condition, gender) %>% 
  summarize(nobs = n(),
            mean = mean(likelihood))
# Note strong gender inbalance

# Contrast the estimated marginal means
options(contrasts = c("contr.sum", "contr.poly"))
model <- lm(likelihood ~ gender*condition,
            data = RS_unb)

emm_condit <- emmeans(model, specs = "condition")
emm_gender <- emmeans(model, specs = "gender")

# Compare with the summary statistics 
# compute the sample mean per condition
emm_condit_p <- emmeans(model, 
                        specs = "condition", 
                        weights = "proportional")
emm_condit
emm_condit_p
# Proportional weights are equivalent
# to marginal summary statistics
RS_unb %>% 
  group_by(condition) %>% 
  summarize(mean = mean(likelihood))

## With balanced samples, the improvement 
## in fit due to factor A doesn't depend on B
## (and vice-versa)
# anova(model1, model2) compares two nested models
anova(lm(likelihood ~ condition, data = RS_bal), 
      lm(likelihood ~ condition + gender, data = RS_bal))
# The sum of square is the same as that of 
anova(lm(likelihood ~ 1, data = RS_bal), 
      lm(likelihood ~ gender, data = RS_bal))

# Compare analysis of variance methods
# type 1: sequential 
anova(lm(likelihood ~ gender*condition, data = RS_unb)) 
anova(lm(likelihood ~ condition*gender, data = RS_unb))
car::Anova(model, type = '2') 
# F-tests for main effects:
#  gender | condition and condition | gender
car::Anova(model, type = '3')
# F-tests for main effect of gender:
#  gender | condition + interaction, 
#  but constraining average of gender to be the same

#  but constraining the average of 