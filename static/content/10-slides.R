# Load packages, set global options
library(tidyverse) # grammar of graphics, etc.
library(emmeans) # estimated marginal mean
library(lme4) # linear mixed models
library(lmerTest) # F-tests for lme4 output

options(contrasts = c("contr.sum", "contr.poly"))


data(TVbo, package = "lmerTest")
# One-way ANOVA (fixed effect)
mod0_fixeff <- lm(Coloursaturation ~ Assessor, data = TVbo)
# One-way random effect ANOVA
mod0_raneff <- lmer(Coloursaturation ~ (1 | Assessor), data = TVbo)

# Compare fitted means
newdat <- data.frame(Assessor = unique(TVbo$Assessor))
# alpha_i + mu, where alpha1 (reference category) is - alpha2 - ... - alpha8
predict(mod0_fixeff, newdata = newdat)
predict(mod0_raneff, newdata = newdat)
# More shrinkage towards the mean for the random effect
anova(mod0_fixeff)

## Repeated measure ANOVA (from Table 16.3 in Kepel & Wickens)

t16p3 <- data.frame(
  subjects = factor(rep(paste0("s", 1:6), length.out = 18)),
  string = factor(rep(c("word", "nonword", "random"), each = 6)),
  time = c(745,777,734,779,756,721,764,786,733,801,786,732,774,788,763,797,785,740))

mod1_fixeff <- lm(time ~ string + subjects, data = t16p3)
# For a random effect, put (1 | grouping) where grouping is a factor
mod1_raneff <- lmer(time ~ (1 | subjects) + string, data = t16p3)
# Similar, but with aov (requires balanced samples)
mod1b_raneff <- aov(time ~ string + Error(subjects), data = t16p3)

rstatix::anova_test(data = t16p3, dv = time, wid = subjects, within = string)

# Analysis of variance model (fixed vs random)
anova(mod1_fixeff)
anova(mod1_raneff)
summary(mod1b_raneff)
# Confidence intervals for the variance
confint(mod1_raneff)


# Data from Clayton (2018)

# Nested random effects (individuals within village
# sex and age are crossed 
url <- "https://edsm.rbind.io/data/ImplicitBias2014.csv"
Clayton <- read_csv(file = url, col_types = "dffffdf")


# Don't use "aov" with Error (as data are unbalanced)
range(xtabs(~village, data = Clayton))
# Effect of quota varies between villages 
mod_clay <- lmer(d.score ~ quota*female*under25 + (1 | village/quota), data = Clayton)
# Include female and under25 for blocking fixed effects
anova(mod_clay)
# Nothing going on there...
# Marginalize over rest and keep difference in quota
emmeans(mod_clay, specs = "quota") %>% contrast(method = "pairwise")

# Account for clustering with clustered standard errors instead of mixed models
aov_clay <- lm(d.score ~ quota*female*under25, data = Clayton)
lmtest::coeftest(aov_clay,
         vcov = sandwich::vcovCL,
         cluster = ~village)
# Not much change, as we often have a single observation per village...
# Testing sphericity
mauchly.test(mod_clay)
