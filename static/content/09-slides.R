# Load packages, set global options
library(tidyverse)
library(emmeans)
options(contrasts = c("contr.sum", "contr.poly"))
# Load data
url <- "https://edsm.rbind.io/data/vanStekelenburg2021S2.csv"
exp2 <- read.csv(url, header = TRUE) %>%
  mutate(condition = factor(condition))
# Check balance
with(exp2, table(condition))

# Scatterplot of data
ggplot(data = exp2,
       aes(x = prior,
           y = post)) +
  geom_point(aes(col = condition)) +
  geom_smooth(method = "lm",
              se = FALSE,
              col = "black") +
  theme(legend.position = "bottom")

# Transform data so that all observations
# measurements are in a single column
# post/prior become labels of a categorical variable
exp2_long <- exp2 %>%
  pivot_longer(cols = c("prior","post"),
               names_to = "time",
               values_to = "belief") %>%
  mutate(time = relevel(factor(time),
                        ref = "prior"))
# Compute summary statistics by group
# average and its standard error = std.dev / sqrt(n)
exp2_summary <- exp2_long %>%
  group_by(condition, time) %>%
  summarize(mean = mean(belief),
            se = sd(belief)/sqrt(n()))

# Create a plot of data by timing
# jitter observations to avoid overlay
ggplot(data = exp2_summary,
       # Aesthetics common to all
       aes(x = time,
           group = condition)) +
  geom_point(data = exp2_long,
             mapping = aes(x = time,
                           y = belief,
                           col = condition,
                           group = condition),
             position = position_jitterdodge(jitter.width = 0.25)) +
  # Add plus or one standard error for the mean
  geom_linerange(data = exp2_summary,
                 aes(ymin = mean - se,
                     ymax = mean + se),
                 position = position_dodge(width = 0.75)) +
  # Add a line for each group mean
  geom_errorbar(data = exp2_summary,
                aes(x = time,
                    ymax = mean,
                    ymin = mean,
                    color = condition),
                position = position_dodge(width = 0.75)) +
  # Add lines for each group (prior to post)
  geom_line(data = exp2_summary,
            mapping =
              aes(x = time,
                  group = condition,
                  color = condition,
                  y = mean),
    position = position_dodge(0.75)
  ) +
  theme_classic() +
  theme(legend.position = "bottom")

# Analysis of covariance

# Check that the data are well randomized
car::Anova(lm(prior ~ condition, data = exp2), type = 3)


# Fit linear model with continuous covariate (ANCOVA)
model1 <- lm(post ~ condition + prior, data = exp2)
# Fit model without for comparison (one-way ANOVA)
model2 <- lm(post ~ condition, data = exp2)
# Global test for differences - of NO INTEREST
# only displayed to show the increase in F stat
car::Anova(model1, type = 3)
car::Anova(model2, type = 3)


# Contrasts
emm1 <- emmeans(model1, specs = "condition")
# Note order: Boost, BoostPlus, consensus
emm2 <- emmeans(model2, specs = "condition")
# Not comparable: emm1 uses detrended data,
# emm2 uses group averages
#
# Compute planned contrasts
contrast_list <- list(
  "boosts vs control" = c(1,  1, -2), #av. boosts vs control
  "Boost vs BoostPlus" = c(1, -1,  0)) #Boost vs BoostPlus
c1 <- contrast(emm1,
         method = contrast_list,
         p.adjust = "holm")
# Without controlling for prior beliefs
c2 <- contrast(emm2,
         method = contrast_list,
         p.adjust = "holm")


# Test equality of variance
levene <- car::leveneTest(
  resid(model1) ~ condition,
  data = exp2,
  center = 'mean')
# Alternative test for equality of variance

# Equality of slopes (interaction)
car::Anova(lm(post ~ condition * prior,
              data = exp2),
           model1, type = 3)
# Testing for normality - doesn't matter here because of sample size
# Strong heterogeneity (compliers and those who don't change much their opinions?)
car::qqPlot(model1,
            id = FALSE,
            line = "robust",
            ylab = "empirical quantiles",
            xlab = "theoretical quantiles",
            pch = 20)

