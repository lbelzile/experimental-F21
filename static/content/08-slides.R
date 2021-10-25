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



# Polynomial models

# Load data
url <- "https://edsm.rbind.io/data/bean.txt"
beans <- read.table(url, header = TRUE)
g1 <- ggplot(data = beans,
             aes(x = time, y = length)) + 
  # add horizontal jittering for clarity
  geom_point(position = position_jitter(width = 0.5)) +
  theme_classic() +
  labs(y = 'length (cm)',
       x = 'time (hours)')
# Print plot
g1 
# Fit models of different orders using lm
model3 <- lm(length ~ poly(time, degree = 3), 
             data = beans) #cubic model
model2 <- lm(length ~ poly(time, degree = 2), 
             data = beans) #quadratic
model1 <- lm(length ~ poly(time, degree = 1), 
             data = beans) #linear
model_anov <- lm(length ~ factor(time), 
                 data = beans) #one-way ANOVA

# Testing between nested model: can we simplify the cubic model?
# Model 3 is equivalent to ANOVA
anova(model3, model_anov)
# drop cubic term?
anova(model2, model3) 
# drop quadratic + cubic?
anova(model1, model3) 

# Add fitted line with confidence interval
g1 + stat_smooth(method = "lm", fullrange = FALSE,
                 formula = y ~ poly(x, 3),
                 col = 2)

# Pairwise differences using Tukey's method
pairwise_diff <- 
  contrast(
    emmeans(model_anov, 
            specs = "time"),
    method = "pairwise",
    adjust = "tukey",
    level = 0.99,
    infer = c(TRUE, FALSE))

knitr::kable(summary(pairwise_diff)[,c(1,2,5,6)],
             colnames = c("contrast","difference",
                          "lower CI","upper CI"),
             digits = c(0,2,2,2),
             caption = "Pairwise differences\nwith 99% CI (Tukey's method)")