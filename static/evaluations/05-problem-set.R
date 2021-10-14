#############################################
## Two-way ANOVA with gender and condition ##
#############################################


i <- 1L # TODO replace this number by the one associated to your ID
options(tidyverse.quiet = TRUE)
library(tidyverse) # data manipulation and grammar of graphics
library(emmeans) # estimated marginal means and contrasts
library(car, quietly = TRUE) # diagnostics plots
library(effectsize) # effect size estimates

url <- "https://edsm.rbind.io/data/RisenGilovichRepBalanced.csv"
data <- read_csv(file = url,
                   col_types = "fiff") %>%  #f = factor, i = integer
        subset(lab == i) 
# If you remove the subsetting, you would get the whole experiment

# likelihood is response (Likert scale from 1 to 10)
# gender is a categorical covariate
# condition is the experimental factor 
# lab is the identifier of the replication laboratory

##########################################################
## 1) Plot data (bar plot)
ggplot(data = data, 
       mapping = aes(x = likelihood,
                     group = condition,
                     fill = condition)) + 
  geom_bar(position = position_dodge2(preserve = "single"), # move aside by condition 
           aes(y = ..prop..), 
           stat="count") + # display proportion rather than total counts
  scale_x_continuous(breaks = seq(from = 2L, to = 10L, by = 2L)) + # make integer break  
  scale_y_continuous(labels=scales::percent) + #percentage scale  
  facet_wrap(~ gender) + # one plot for each gender  
  labs(y = "proportion") + # change y-axis label
  theme_classic() + #change theme
  theme(legend.position = "bottom") #move caption to bottom instead of right
  
  
## 2) Fit two-way ANOVA model
# Make sure the model is fitted with sum-to-zero constraint
options(contrasts = c("contr.sum","contr.poly"))
# Contingency table with counts in each group
with(data, table(gender, condition))
# Fit the linear model (two way ANOVA with interaction)
model <- lm(likelihood ~ gender*condition, data = data)
# Model coefficients: mu, alpha, beta, (alpha*beta)
coef(model)
# Model summary with coefficients and t-tests
summary(model)
# Because it is a 2^2 factorial experiment, inferences agree
# with the ANOVA table
anova_tab <- anova(model) 

## If interaction is statistically significant
# We are interested in comparing condition for each gender
cell_means <- emmeans::emmeans(model, c("gender","condition"))
cell_contrasts <- emmeans::contrast(cell_means, 
                                    method = "pairwise",
                                    by = "gender")
# Same as manual specification below except for adjustment
# Check order of variables from cell_means
contrasts_list <- 
  list(male_unprvsprep = c(1,0,-1,0),
       female_unprvsprep = c(0, 1, 0, -1))
emmeans::contrast(cell_means, # emmeans object with mean of each group 
                  method = contrasts_list, # List of contrasts
                  infer = rep(TRUE, 2), #print both p-values and confidence intervals
                  adjust = "holm")

## If interaction is not statistically significant
# we could instead work with the marginal mean (pool gender groups)
marg_means <- emmeans::emmeans(model, specs = "condition")
# Note warning to indicate the above isn't useful with interactions
marg_pairs <- contrast(marg_means, method = "pairwise")
# Same as pairs (different syntax)
pairs(marg_means)

## Effect size computed from emmeans package
emmeans::eff_size(cell_means, 
         sigma = sigma(model),   # standard deviation (ASSUMED EQUAL VARIANCE)
         edf = df.residual(model))


# If all you have is the statistic and sample sizes, you can use the 'compute.es' package to convert these to effect sizes
# e.g. compute.es::mes converts mean + SD with sample sizes to Cohen's d
compute.es::tes(n.1 = 14, 
                n.2 = 14,
                t = summary(marg_pairs)$t.ratio)
# Largely agrees with above for
# male unprepared - male prepared

## Effect size computed using effectsize package
# Omega-squared is less biased estimator 
# of percentage of variability than eta-squared
# Here, we would account for gender (not an experimental factor)
om_sq  <- 
  effectsize::omega_squared(model = model, 
                            partial = TRUE, # partial effect (SS_effect) vs SS_effect + SS_resid
                            ci = 0.8, # level of confint
                            alternative = "greater") # alternative - default to 'greater'
# Note that the confidence interval is one-sided so
# only report lower bound - these are very small 
# may be rounded to zero when printed ...
# upper bound on fraction of variance is automatically 1
# 


# IN YOUR REPORT, CLEARLY INDICATE
# - the coefficient used (f, eta-squared, omega-squared)
# - whether it is a partial measure (partial = effect vs effect + residuals)
# - the confidence interval level (if one-sided, etc.)

## Diagnostics plots and tests
# With all data, we would necessarily reject null, 
# but not so with data from a single lab
# Overall evidence is nearly the same, so it doesn't matter
car::leveneTest(likelihood ~ gender*condition, data = data)
oneway.test(likelihood ~ gender*condition, data = data)


# Default R plots are produced with
# plot(model)

# Fancier graphs with helper for interpretation
# (note "Influential Observations" -> Outliers, is hard to interpret
# in the present context because all points have the same 'leverage')
# a consequence of balanced samples in the ANOVA
performance::check_model(model)

## Remark regarding the QQ-plot (expert opinion on the matter)
# Based on an analysis of the full data
# Observations are discrete (likelihood is on a scale of 1 to 10)
# Some evidence of accumulation at extremes (problem with additivity?)
# otherwise, staircase pattern is due to discreteness
# Because of bounds, observations are too light-tailed.
# Quantile-quantile plots: points should be on a line
car::qqPlot(model, id = FALSE, ylab = "empirical quantiles")
