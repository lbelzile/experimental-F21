# Reproduction of Spatial Orientation Shrinks and Expands Psychological Distance
# by Maglio and Polman (2014), Psychological Science
# Data from "https://osf.io/846cb/download"
library(tidyverse)
# Name of subway stations
labs <- c("Bloor-Yonge", "Sherbourne", "Spadina", "St. George")
# Order of stations from West to East is 
# Spadina > St. George > Bay > Bloor-Yonge > Sherbourne
olabs <- c("Spadina", "St. George", "Bloor-Yonge", "Sherbourne")
data <- read_csv("https://edsm.rbind.io/data/MaglioPolman2014S1.csv",
                 col_types = "fiff") %>%
  # STN_NUMBER redundant with STN_NAME
  transmute(station = fct_relevel(factor(STN_NAME, labels = labs), olabs),
            direction = factor(DIRECTION, labels = tolower(levels(DIRECTION))),
            distance = DISTANCE)

# A 5x2 factorial design (two-way ANOVA)
options(contrasts = c("contr.sum", "contr.poly"))
model <- lm(distance ~ station*direction, data = data)
# List coefficients 
# (global mean mu, deviation by station, etc.)
dummy.coef(model)
# The missing coefficients can be deduced 
# from the sum-to-zero constraint, e.g.,
# the coefficient for Sherbourne station is
# 0.7254515 = -0.4877592 + 0.4545485 + 0.7586622
# Sherbourne = - Spadina - St. George - Bloor-Yonge



car::Anova(model, type = "3")

# Interaction plot 
# average of each subgroup, with +/- 1 std. error

data %>%
  group_by(direction, station) %>%
  summarize(mean = mean(distance),
            se = sigma(model) / sqrt(n()),
            lower = mean - se,
            upper = mean + se) %>%
  ggplot(mapping = aes(x = station,
                       y = mean, 
                       group = direction,
                       col = direction)) + 
  geom_line() +
  geom_errorbar(aes(ymin = lower, 
                    ymax = upper),
                width = 0.2) +
  geom_point() +
  theme_classic() +
  theme(legend.position = "top") + 
  scale_colour_grey() +
  labs(y = "subjective distance",
       x = "subway station",
       col = "direction of travel")
  
library(emmeans)
emm <- emmeans(model, specs = c('direction', 'station'))
emmeans(model, specs = "direction", by = "station")
pairw <- contrast(emm, by = "station", method = "pairwise")
p.adjust(summary(pairw)$p.value, method = "holm")

# custom contrasts
custom_contrast <- list(SpadinaEvsW = c(1, -1, rep(0, 6)),
                        symmetry = c(1, -1, 1, -1, 1, -1, 1, -1))
confint(contrast(emm, 
         method = custom_contrast,
         adjust = "scheffe",
         infer = TRUE), scheffe.rank = 7)
# Scheffe's method has an argument scheffe.rank ng-1

# Effect size and power
library(effectsize)
# sigmasq_{AB} / (sigmasq_{AB} + sigmasq_{res})
omsq <- omega_squared(model)$Omega2_partial
cohensf <- sqrt(omsq / (1 - omsq))

# Power calculations
library(WebPower)
wp.kanova(ndf = 3, f = cohensf[3], ng = 8, power = 0.8)
wp.kanova(ndf = 3, f = 0.3381892, ng = 8, alpha = 0.01, power = 0.99)
