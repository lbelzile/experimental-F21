library(tidyverse)
library(lmerTest)
url <- "https://edsm.rbind.io/data/Bobak2019S2.csv"
bobak_full <- read.csv(url, header = TRUE)
# ADD THE FOLLOWING LINE
colnames(bobak_full)[1] <- "pnum"
bobak <- bobak_full %>%
  select(pnum:diffmon) %>%
  pivot_longer(cols = starts_with("diff"),
               names_to = "color",
               names_prefix = "diff",
               values_to = "pcorr")

bobak <- bobak %>%
  mutate(pnum = factor(pnum),
         color = factor(color))
str(bobak)
library(lme4)
library(lmerTest)
options(contrasts = c("contr.sum", "contr.poly"))
model <- lme4::lmer(data = bobak,
                    pcorr ~ (1 | pnum) + color)
model
# global F test for null hypothesis
car::Anova(model, test = "F")
# pairwise difference
emmeans::emmeans(model, specs = "color") %>%
  pairs()
# Sphericity assumption
summary(afex::aov_ez(data = bobak,
                     dv = "pcorr",
                     id = "pnum",
                     within = "color"))
# normality assumption for random effects and residuals via QQ plots
lattice::qqmath(ranef(model))
car::qqPlot(resid(model), ylab = "observed quantiles (residuals)", xlab = "theoretical quantiles (normal)", id = FALSE)
# Equality of variance (group heteroscedasticity)
car::leveneTest(resid(model) ~ color, data = bobak)
plot(model)
# Plot raw data
ggplot(data = bobak,
       aes(x = color,
           y = pcorr,
           group = pnum,
           color = pnum)) +
  geom_point() +
  theme_bw() +
  theme(legend.position = "none")