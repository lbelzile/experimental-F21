# Load packages
suppressPackageStartupMessages(library(tidyverse))
library(emmeans)
library(pwr)
# Load data
url <- "https://edsm.rbind.io/data/words.txt"
words <- read.table(url, header = TRUE)
words <- words %>%
   mutate(feedback = factor(feedback, labels = c("none",
                                                 "positive",
                                                 "negative")),
          material = factor(material, labels = c("low freq/low emotion",
                                                 "high freq/low emotion",
                                                 "high freq/high emotion")),
          age = factor(age, labels = c("fifth grade", 
                                       "senior")))
# unordered factors, ordered factors
options(contrasts = c("contr.sum","contr.poly"))
# are the data balanced
words %>% 
  group_by(feedback, material, age) %>%
  summarize(nsamp = n())
# This is a 3x3x2 factorial design with r=5 replicates
model <- lm(words ~ feedback*material*age, 
            data = words)
anova(model)

# Interaction plot - group average (for each subgroup)
words %>%
  group_by(feedback, material, age) %>%
  summarize(meanwords = mean(words)) %>%
ggplot(mapping = aes(x = feedback, 
                     y = meanwords,
                     group = material,
                     color = material)) +
  geom_line() + # connect the dots
  facet_wrap(~age) +
  theme(legend.position = "bottom") +
  labs(subtitle = "mean number of words remembered",
       y = "")

# Plot raw data
ggplot(data = words,
         mapping = aes(x = age, 
                       y = words,
                       group = material,
                       color = material)) +
  geom_point(position = position_jitterdodge(jitter.height = 0.1,
                                             dodge.width = 0.3)) + 
  facet_wrap(~feedback) + # wrap by third variable
  theme_classic() + # change default theme
  theme(legend.position = "bottom") + # move caption
  labs(subtitle = "mean number of words remembered",
       y = "") # add more meaningful axis labels

# Post-hoc effect estimation
# Keppel and Wickens (Chapter 22)
# Note that all degrees of freedom in this chapter are off by 2
# Main effects and contrasts
# Estimated marginal mean (EMM) 
# Marginal estimate (averaged over levels of material and age)
margA <- emmeans(model, specs = "feedback")
# Check that this is indeed the mean of each word count by feedback
words %>% group_by(feedback) %>% summarize(mean = mean(words))
# Compute a marginal contrast: 
# comparison between no-feedback and the average of pos + neg
contrast(object = margA, 
         method = list(interaction = c(1, -0.5, -0.5)))
# H0: MU_none = 0.5*(MU_positive + MU_negative)
# 1MU_none - 0.5MU_positive - 0.5MU_negative = 0

# Simple effects: B x C (material x age) is significant,
# so can test for difference between levels of B
# within each value of C (average over all feedback)
simpleBpC <- emmeans(model, specs = c("material", "age")) %>%
  joint_tests(by = "age")
# Simple contrasts
margBC <- emmeans(model, 
                  specs = c("material", "age"), 
                  by = "age") %>%
  contrast(method = list(contrast = c(-0.5,-0.5,1)))

# Interaction components based on marginal means
# Compare b2 and b3: is there difference between groups of C?
emmeans(model, 
        specs = c("material", "age"), 
        by = "age") %>% 
  contrast(method = list(b2vsb3 = c(0, 1, -1))) %>%
  joint_tests()

# Compute differences between feedback and material
emmeans(model, specs = c("feedback", "material")) %>%
  contrast(method = list(nonevsaverageforb2vsb3 = 
  c(0, 0, 0, -1, 0.5, 0.5, 1, -0.5, -0.5)))
# Three factor interaction
# A: no feedback vs feedback (none vs average of pos & neg)
# B: low vs high emotional feedback (b2 vs b3)
# C: fifth graders vs seniors
threewaycontrast <- emmeans(model, specs = c("feedback", "material","age")) %>%
  contrast(method = list(contrast = 
                           c(0, 0, 0, -1, 0.5, 0.5, 1, -0.5, -0.5,
                               0, 0, 0, 1, -0.5, -0.5, -1, 0.5, 0.5)))
summary(threewaycontrast, adjust = "scheffe", scheffe.rank = 17)

library(effectsize)
library(WebPower)

# Need to compute an effect size for the contrasts or other quantities
omega_sq <- effectsize::omega_squared(model, partial = TRUE)
omega_sq_contrast <- (1.993^2-1) / ((1.993^2-1) + 90)

# The value of omega-square (partial) for the three-way interaction is 0.01418
# Need to convert omega-square (partial) to Cohen's f (partial)

cohens_f <- sqrt(omega_sq$Omega2_partial/(1-omega_sq$Omega2_partial))
cohens_f_alt <- effectsize::cohens_f(model, partial = TRUE)$Cohens_f_partial
cohens_f_contrast <- sqrt(omega_sq_contrast / (1-omega_sq_contrast))
?WebPower::wp.kanova()
# Power calculation
# Contrast
wp.kanova(ndf = 1, f = cohens_f_contrast, ng = 18, power = 0.8)
# 14*18 = 252
# Three-way interaction
wp.kanova(ndf = 4, f = cohens_f_alt[7], ng = 18, power = 0.8)
# 47*18 = 846 observations
# Main effect (feedback)
wp.kanova(ndf = 2, f = cohens_f[1], ng = 18, power = 0.8)
