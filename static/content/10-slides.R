# Load packages, set global options
library(tidyverse) # grammar of graphics, etc.
library(emmeans) # estimated marginal mean
library(lme4) # linear mixed models
library(lmerTest) # F-tests for lme4 output
library(afex) # factorial experiment 
options(contrasts = c("contr.sum", "contr.poly"))

# Example 1 in slides
url <- "https://edsm.rbind.io/data/faces.csv"
faces <- read.csv(url, header = TRUE, 
                  stringsAsFactors = TRUE) %>%
  mutate(id = factor(participant),
         condition = relevel(condition, ref = "real"))
# Data must be in long format (one measurement per line)
# Declare participant ID as categorical

# Plot observations (only one replicate per participant)
# n = 9 people, a = 3 conditions
ggplot(data = faces,
       aes(x = id,
           group = condition,
           colour = condition,
           y = amplitude)) +
  geom_point() +
  theme_classic() +
  theme(legend.position = "bottom")

# Fit model with aov
aov(amplitude ~ condition + Error(id), data = faces)
# Random intercept for participant
model <- lme4::lmer(amplitude ~ condition + (1 | id), 
                    data = faces)
car::Anova(model, test = "F", type = 3)

# Diagnostic plots
# Linearity (Tukey-Anscombe plot of residuals vs individual means)
plot(model, ylab = "residuals", xlab = "fitted")
# Std.error of residuals and participants
VarCorr(model)
confint(model)
########################
### Diagnostic plots ###
########################
# Catterpillar plot
# Plot conditional mode of random effects 
# (should be straight line)
lattice::qqmath(lme4::ranef(model, condVar = TRUE))
# QQ of random effects 
# these are stored in a list
car::qqPlot(as.vector(unlist(lme4::ranef(model)$id)),
            xlab = "theoretical normal quantiles",
            ylab = "random effects", 
            id = FALSE)
# QQ plot of residuals
car::qqPlot(as.vector(resid(model)), 
            xlab = "theoretical normal quantiles",
            ylab = "residuals", 
            id = FALSE)

# Assumption of sphericity
# There are options in car and base R
# but it's a mess and the below is simpler
modspher <- afex::aov_ez(id = "id",
                         dv = "amplitude", 
                         data = faces, 
                         within = "condition")
summary(modspher)
# P-value for test of sphericity is large
# so no evidence against this hypothesis
# can proceed without correction.

# Test group homoscedasticity with Levene's test
car::leveneTest(resid(model) ~ condition, 
                data = faces,
                center = 'mean')
# All seems good

# Pairwise comparisons
emmeans(model, specs = "condition") %>% pairs()
# Unsurprisingly, none of the difference are significant - they were not overall.

# Power analysis
WebPower::wp.rmanova(n = 9, # number of subjects
                     ng = 3, # number of groups
                     nm = 35, # number replications
                     #corresponds to number per person,
                     nscor = 0.9, #sphericity correction,
                     power = 0.9) # power
# Could detect an effect size of 1.65
# this is the ratio of variance 
