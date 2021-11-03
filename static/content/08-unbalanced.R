# Replication of Study 4a of
# Janiszewski & Uy (2008, Psychological Science)
# by J. Chandler
# See https://osf.io/aaudl
library(tidyverse)
# Load data
url <- "https://osf.io/26mxf/download"
JU_data <- haven::read_sav(file = url)
# The response is labelled 'mean2'
# the explanatories are 'anchor' and 'magnitude'
# This is a 2x2 factorial design
#
# Transform data so that explanatories are factors
# as_factor will automatically detect SPSS labels
JU_data <- JU_data %>%
  mutate(anchor = as_factor(Anchortype),
         magnitude = as_factor(magnitude),
         gender = as_factor(Gender)) %>%
  filter(JU_data$DROP == 0) %>% # keep only some observations
  dplyr::select(anchor, magnitude, gender, mean2) %>%
  rename(madjust = mean2)
# Tasks:
# 1) compute the average in each group and create
# a plot of the means with one-standard error
# Use `summarize` with `group_by` to create
# a summary table and feed the result to ggplot
# with geom_line() and geom_point()
# 2) Determine if the study is balanced.
summary_tab <-
  JU_data %>%
  group_by(anchor,
           magnitude) %>%
  summarize(nobs = n(),
            mean = mean(madjust))
# Alternative code to check balance
with(JU_data, table(magnitude, anchor))
# BALANCED if you filter the DROP==0

# Interaction plot
ggplot(data = summary_tab,
       mapping = aes(x = anchor,
                     group = magnitude,
                     color = magnitude,
                     y = mean)) +
  geom_line() +
  theme_classic() +
  theme(legend.position = "bottom") +
  labs(title = "Adjustment for a measure",
       x = "anchor type",
       color = "magnitude",
       y = "average")
# Lines are parallel -> likely no interaction


options(contrasts = c("contr.sum","contr.poly"))
# Fit two-way ANOVA model with interaction
model1 <- lm(madjust ~ anchor*magnitude,
             data = JU_data)
# Note the syntax: A*B is equivalent to A + B + A:B
# A:B meaning interaction of A and B

# Because data are unbalanced, use type III effects
car::Anova(model1, type = "3")
# No evidence of interaction

# But are null distributions and p-values reliable?

car::qqPlot(model1, id = FALSE)
# Assumption of equality of variance
car::leveneTest(madjust ~ anchor*magnitude,
                data = JU_data,
                center = 'mean')
# looks like some subgroups have different variances

# Fit a model with No(mu_{ij}, sigmasq_{ij})
# different mean and variance in each group
model2 <- nlme::gls(madjust ~ anchor*magnitude,
                   data = JU_data,
                   weights = varIdent(form = ~ 1 | anchor*magnitude))
# The weird syntax for weights indicates constant variance
# with | indicating to calculate different values for each group

# OPTIONAL: if a reviewer asks you to use a different statistic
# than Levene's test
# alternatives include Brown-Forsythe (less sensitive to outliers, less powerful)
car::LeveneTest(madjust ~ anchor*magnitude,
                data = JU_data,
                center = 'median')
# The likelihood ratio test (assumes normality)
model1b <- nlme::gls(madjust ~ anchor*magnitude, data = JU_data)
# Could alternative use the likelihood ratio test
anova(model1b, model2)
# Amounts to (roughly) the same as Bartlett's test
# (sensitive to departures from normality)
bartlett.test(madjust ~ interaction(anchor, magnitude),
              data = JU_data)
# Many different tests for the same conclusion: heterogeneity

# Compute marginal mean estimates
# Here, we would possibly only be interested
#  in the effect of the anchor
#  Below, we show how to obtain comparisons within
#  a level of another factor using emmeans
emm_anch <- emmeans(object = model2,
                    pairwise ~ anchor | magnitude)
# Careful: ignoring an interaction can lead to
# misleading marginal means

# marginal estimates from model1 would be unreliable here (why?)
emm_magn <- emmeans(object = model2,
                    specs = "magnitude")
#
emm_all  <- emmeans(object = model2,
                    specs = c("anchor", "magnitude"))
contrast(emm_all, method = "pairwise", by = "anchor")
contrast(emm_all, method = "pairwise", by = "magnitude")
# If you use emmeans with a gls object that has unequal variances
# it will adjust all calculations correctly.
# Note the terminology difference: the Tukey's method is called
# Games-Howell with unequal variances
