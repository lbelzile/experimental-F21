# Class 6: Example of two-way ANOVA



url <- "https://edsm.rbind.io/data/KW_tab11p8.txt"
monkey <- read.table(url, 
                     header = TRUE,
                     stringsAsFactors = TRUE)
# Sum-to-zero parametrization for each factor
# This overrides the default parametrization of linear models
# so that contr.treatment is replaced with 
options(contrasts = c("contr.sum", "contr.poly"))
#  mu + alpha (row) + beta (column) + [alpha*beta] (cell)
linmod <- lm(errors ~ deprivation*drug, 
             data = monkey)
# The following is not needed because of global call
# lm(errors ~ deprivation*drug, 
#   data = monkey, 
# contrasts = list(deprivation = contr.sum,
#                  drug = contr.sum))

# Anova table
anova(linmod)
# Effect sizes with confidence intervals (90% by default)
effectsize::cohens_f(linmod, partial = TRUE)
effectsize::omega_squared(linmod, partial = TRUE)
effectsize::eta_squared(linmod, partial = TRUE)

# Computing estimated marginal means, contrasts
# Sum over each row, column is zero for coefficients
# Main-effect-of-B contrast: B1-B2
library(emmeans)
emmB_monkey <- emmeans(linmod, ~ deprivation)
summary(contrast(emmB_monkey, 
                 list("1h vs 24h" = c(1, -1))), 
        infer = c(TRUE, TRUE))
pairs(emmB_monkey)
# AB-interaction contrast: 
# Difference between drug2 vs control
# comparing deprivation 24h vs 1h
# AB32-AB12-AB31+AB21 = 0 
emmAB_monkey = emmeans(linmod, ~ drug:deprivation) 
emmAB_monkey
# Display to see order of AB combos for contrast coefficients
summary(contrast(emmAB_monkey, 
        list(AB = c(-1, 0, 1, 1, 0, -1)), 
        infer = c(TRUE, TRUE)))
        #infer option: two booleans 
        #first for CI (yes/no)
        #second for t-test and p-values
# Multiple comparisons: A
emmA_monkey <- emmeans(linmod, ~ drug)

# lsmeans for B and 99% CIs
# Tukey’s method: adjust for pairwise contrast
summary(contrast(emmA_monkey, 
                 method = "pairwise", 
                 adjust = "tukey"),
        infer = c(TRUE, TRUE), level = 0.99)
# Dunnett’s method
summary(contrast(emmA_monkey, 
                 method="trt.vs.ctrl", 
                 adj = "mvt", ref = 1),
        infer = c(TRUE, TRUE))

## Diagnostic plots
## 

# Replication of Study 4a of 
# Janiszewski & Uy (2008, Psychological Science) 
# by J. Chandler 
# See https://osf.io/aaudl
library(tidyverse)
# Load data
url <- "https://osf.io/26mxf/download"
JU_data <- haven::read_sav(file = url)
# The response is labelled 'mean2'
# the explanatories are 'anchortype' and 'magnitude'
# This is a 2x2 factorial design
# 
# Transform data so that explanatories are factors
# as_factor will automatically detect SPSS labels
JU_data <- JU_data %>%
  mutate(anchortype = as_factor(Anchortype),
         magnitude = as_factor(magnitude))
# Tasks:
# 1) compute the average in each group and create 
# a plot of the means with one-standard error
# Use `summarize` with `group_by` to create 
# a summary table and feed the result to ggplot
# with geom_line() and geom_point()
# 2) Determine if the study is balanced.
summary_tab <- 
  JU_data %>% 
  group_by(anchortype, 
           magnitude) %>% 
  summarize(nobs = n(),
            mean = mean(mean2))
# NOT BALANCED
ggplot(data = summary_tab,
       mapping = aes(x = anchortype,
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
# Lines are parallel -> no interaction


# Fit two-way ANOVA model
linmod_inter <- lm(mean2 ~ anchortype*magnitude, 
                   data = JU_data)
linmod_main <- lm(mean2 ~ anchortype + magnitude, 
                  data = JU_data) # no interaction
# Note the syntax: A*B is equivalent to A + B + A:B
# meaning interaction of A and B
car::Anova(linmod_main, linmod_inter, type = "3")
# No evidence of interaction
# CAREFUL: with unbalanced samples, 
# we lose important properties. 

# Compute marginal mean estimates
library(emmeans)
# Here, we would possibly only be interested
#  in the effect of the anchor
#  Below, we show how to obtain comparisons within
#  a level of another factor using emmeans
emm_anch <- emmeans(object = linmod_inter, 
                    pairwise ~ anchortype | magnitude)
# Careful: ignoring an interaction can lead to 
# misleading marginal means
emm_magn <- emmeans(object = linmod_inter, 
                    specs = "magnitude")
emm_all  <- emmeans(object = linmod_inter, 
                    specs = c("anchortype", "magnitude"))


# Cox and Cochran
# Randomized block experiment
block_f <- factor(paste("block", 1:3))
treat_f <- factor(paste("Treatment", 1:5))
df <- data.frame(
  expand.grid(treatment = treat_f, 
              block = block_f),
         strength = c(7.62, 8.14, 7.76, 7.17, 7.46,
           8.00, 8.15, 7.73, 7.57, 7.68,
           7.93, 7.87, 7.74, 7.80, 7.21))
# Without blocking
anova(lm(strength ~ treatment, data = df))
# With blocking - note the decrease in sum of square
# albeit the evidence for difference in treatment isn't stronger
# because the two additional parameters to estimate 
anova(lm(strength ~ treatment + block, data = df))
# We cannot fit an interaction because there is only one replication per unit
# We need 15 observations for each mean parameter, none left for variance!