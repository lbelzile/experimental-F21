#############################################
## Two-way ANOVA with gender and condition ##
#############################################


i <- 1L # TODO replace this number by the one associated to your ID
# Install these packages first
suppressPackageStartupMessages(library(tidyverse)) # data manipulation and grammar of graphics
library(emmeans) # estimated marginal means and contrasts
suppressPackageStartupMessages(library(car)) # diagnostics plots
suppressPackageStartupMessages(library(effectsize)) # effect size estimates

# URL of the database
url <- "https://edsm.rbind.io/data/RisenGilovichRepBalanced.csv"
# Read data
data <- read_csv(file = url,
                   col_types = "fiff") %>%  
  #f = factor, i = integer
        subset(lab == i) 
# If you remove the subsetting, you would get the whole experiment

# Make sure the model is fitted with sum-to-zero constraint
options(contrasts = c("contr.sum","contr.poly"))

# Explanation of the data: see Many Labs 2 (2018) 
# https://doi.org/10.1177%2F2515245918810225
# likelihood is response (Likert scale from 1 to 10)
# gender is a categorical covariate
# condition is the experimental factor 
# lab is the identifier of the replication laboratory

##########################################################
## 1) Plot data 
## below, I use bar plots because the response is discrete
## so I can count the number of unique occurrences
ggplot(data = data, 
       mapping = aes(x = likelihood,
                     group = condition,
                     fill = condition)) + 
  geom_bar(position = position_dodge2(preserve = "single"), # move aside by condition 
           aes(y = ..prop..), 
           stat = "count") + # display proportion rather than total counts
  scale_x_continuous(breaks = seq(from = 2L, to = 10L, by = 2L)) + # make integer break  
  scale_y_continuous(labels=scales::percent) + #percentage scale  
  facet_wrap(~ gender) + # one plot for each gender  
  labs(y = "proportion") + # change y-axis label
  theme_classic() + #change theme
  theme(legend.position = "bottom") #move caption to bottom instead of right
  
  
## 2) Check model assumptions
## Is dataset balanced?
data %>% group_by(condition, gender) %>% summarize(nobs = n())
# Contingency table with counts in each group
with(data, table(gender, condition))
## Independence? 
## Since observations have been reordered by condition
## we cannot check this assumption
## Equal variance? 
## Use Levene's test
car::leveneTest(likelihood ~ gender*condition, 
                data = data,
                center = mean)
## If there is no evidence the variance are different,
## proceed as usual

## 3) Fit the linear model (two way ANOVA with interaction)
model <- lm(likelihood ~ gender*condition, data = data)
# Model coefficients: mu, alpha, beta, (alpha*beta)
coef(model)
# Model summary with coefficients and t-tests
summary(model)
# Because it is a 2^2 factorial experiment, inferences agree
# with the ANOVA table
anova_tab <- anova(model) 

## If the sample size is small-ish per group, 
## check QQ-plot for normality
## points should be roughly on a line
## staircase pattern is due to discrete observations
## (likelihood is a Likert scale on a scale of 1 to 10)
# Quantile-quantile plots: 
car::qqPlot(model, id = FALSE, ylab = "empirical quantiles")

## NOTE: If variance were unequal per cell, use instead the following call
## which estimates a difference variance in each group
## (so-called Welch's ANOVA). 'emmeans' will adapt it's calculation
## so Tukey's HSD is now Games-Howell method (same, but different name)
# library(nlme)
# # Fit model with
# model <- nlme::gls(model = likelihood ~ gender*condition, 
#                    data = data,
#                    weights = varIdent(form ~ gender*condition))
# car::Anova(model, type = "3")
# car::qqPlot(resid(model), id = FALSE, ylab = "residuals")

## 4) Contrast: comparison between experimental condition
## If interaction is statistically significant
# We are interested in comparing condition for each gender
# so we report two values
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
# we could instead work with the marginal mean 
# (i.e., pool gender groups as if this was a one way ANOVA)
# but accounting for the fact we estimated four different averages
# and potentially also four variance (with Welch ANOVA)
marg_means <- emmeans::emmeans(model, specs = "condition")
# Note warning to indicate the above isn't useful with interactions
marg_pairs <- contrast(marg_means, method = "pairwise")
# Same as pairs (different syntax)
pairs(marg_means)

## Effect size computed from emmeans package
# Basically Cohen's d with Delta/sigma, where
# sigma is the value you provide
emmeans::eff_size(cell_means, 
         sigma = sigma(model),   # standard deviation (ASSUMED EQUAL VARIANCE)
         edf = df.residual(model))

## Diagnostics plots and tests
# With all data, we would necessarily reject null, 
# but not so with data from a single lab
# Overall evidence is nearly the same, so it doesn't matter

# If you reject, you can report instead of the ANOVA the Welch ANOVA results (write "Welch ANOVA' and proceed accordingly with the description)

cell_contrasts <- emmeans::contrast(cell_means, 
                                    method = "pairwise",
                                    by = "gender")

# Default R plots are produced with
# plot(model)

# Fancier graphs with helper for interpretation
# (note "Influential Observations" -> Outliers, is hard to interpret
# in the present context because all points have the same 'leverage')
# a consequence of balanced samples in the ANOVA
performance::check_model(model)

## Remark regarding the QQ-plot (expert opinion on the matter)
# Based on an analysis of the full data



## Diagnostics plots and tests
# With all data, we would necessarily reject null, 
# but not so with data from a single lab
# Overall evidence is nearly the same, so it doesn't matter
car::leveneTest(likelihood ~ gender*condition, data = data)
# If you reject, you can report instead of the ANOVA the Welch ANOVA results (write "Welch ANOVA' and proceed accordingly with the description)
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

