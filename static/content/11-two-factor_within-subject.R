# Load packages
library(tidyverse)
library(lme4)
library(lmerTest)
library(emmeans)
options(contrasts = c("contr.sum","contr.poly"))
# Load data
url <- "https://edsm.rbind.io/data/KW_tab18p3.txt"
data <- read.table(url, header = TRUE) %>%
   transmute(subject = factor(s),
             wordtype = factor(a),
             repetition = factor(b),
             recall = recall)
# # With 'aov' (balanced designs only)
# summary(aov(recall ~ wordtype*repetition + Error(subject/(wordtype*repetition)), data = data))
# With lme4::lmer (linear mixed model)
mixmod <- lmer(recall ~ wordtype*repetition + 
                 (1 | subject) + 
                 (1 | subject:wordtype) + 
                 (1 | subject:repetition), 
               data = data)
# With afex aov_ez
within <- afex::aov_ez(id = "subject", 
             dv = "recall", 
             within = c("repetition","wordtype"), 
             data = data)
# Maximal random effects: wordtype and repetition are crossed
# Because we have repetitions 
# (we see 4 repetitions of word type, 
# and 3 word type per repetition round)
# Can include another layer of variability there

# Analysis of variance table and F-tests
anova(within, correction = "none")

# Plot marginal means
afex_plot(within, 
          trace = "wordtype", 
          x = "repetition", 
          error = "within",
          mapping = c("shape", "color")) +
  theme_classic() + 
  theme(legend.position = "bottom")
# Diagnostic plots
lattice::qqmath(ranef(mixmod))
car::qqPlot(resid(mixmod), id = FALSE, ylab = "residuals")

# Contrast for the effect of repetition
# This corresponds to a linear trend 
# (with an increase over time from r1 to r4)
# Testing overall trend (marginal)
within %>% 
   emmeans(specs = "repetition") %>% 
   contrast(method = list(trend = c(-3,-1,1,3)))
# Testing differences in trends between word type
within %>% 
   emmeans(specs = "repetition", by = "wordtype") %>% 
   contrast(method = "poly") %>%
   joint_tests(by = "contrast") 
# Watch out: the above degrees of freedom are correct F(2,7)
# Contrast with mixmod

# To get these, we could compute manually a column response
# with the contrast and run a one-way within-subject ANOVA
# To get these results
data_contrast <- data %>% 
  pivot_wider(names_from = repetition, 
              values_from = recall, 
              names_prefix = 'r') %>%
  mutate(contrast = -3*r1 - r2 + r3 + 3*r4)
model_contrast <- lmer(contrast ~ wordtype + (1 | subject),
     data = data_contrast)
emmeans(model_contrast, "wordtype") %>% joint_tests()

# Marginal analysis with A=a2 (wordtype)
simple_a2 <- afex::aov_ez(id = "subject", 
             dv = "recall", 
             within = "repetition", 
             data = data %>% filter(wordtype == 2))
anova(simple_a2, correction = "none")
# Simple contrast difference between rep4 and rep1
simple_a2 %>% 
  emmeans(specs = "repetition") %>% 
  contrast(method = list(delta = c(-1, 0, 0, 1)))
# Interaction contrast
# Simultaneously, have 
# psiA = 2*mua1-mua2-mua3 (wordtype) 
# psiB = -3*mub1 - mub2 + mub3 + 3*mub4 (repetition)
intcont <- list(int_contrast = 
                  c(2*c(-3,-1,1,3), 
                    -c(-3,-1,1,3), 
                    -c(-3,-1,1,3)))
within %>% 
  emmeans(specs = c("repetition","wordtype")) %>%
  contrast(method = intcont)


# Effect size and power
# We can get R-squared partial as usual, but
# partial omega-squared is unresolved (see Keppel & Wickens, p.427)
# The 'afex' package returns generalized eta-squared estimate
# put anova_table = list(es = "pes") in the options to aov_ez
# to get instead partial eta-squared
# afex::aov_ez(id = "subject", 
#              dv = "recall", 
#              within = c("repetition","wordtype"), 
#              data = data, anova_table = list(es = "pes"))
# effectsize::effectsize(within, generalized = TRUE)
effectsize::eta_squared(within, ci = FALSE)
# Another option is to have "observed" variable (for blocking factors or
# any condition that is not experimentally manipulated).
# These are partial Rsquared
