
######################################################
# Script produced in the Introduction channel videos #
######################################################

## Part 1: create a new Project

## Part 2: load the data in R
## Load the packages of the tidyverse
# install.packages("tidyverse") # do this once
library(tidyverse)
## Loading data
## Option 1: load data from a package
# data(arithmetic, package = "SMPracticals")
## Option 2: load data directly from an URL
url <- "https://edsm.rbind.io/data/arithmetic.csv"
arithmetic <- readr::read_csv(url, show_col_types = FALSE)
## Option 3: load data from local folder
## you need to have a subfolder data (case-sensitive)
# arithmetic <- read_csv(file = "data/arithmetic.csv")
glimpse(arithmetic)


## Part 3: clean and modify the data
## We create a vector of meaningful labels
## See help for more details
# ?SMPracticals::arithmetic
unique(arithmetic$group)
labs <- c("control 1",
          "control 2",
          "praised",
          "reproved",
          "ignored")
# Transform database: map strings, binary variables
# to factor if they are categorical variables
arithmetic <-
  arithmetic %>%
  mutate(group = factor(x = group,
                        levels = c("A","B","C","D","E"),
                        labels = labs))
## Peak at data to make sure this is correct
glimpse(arithmetic)

## Part 4: Summary statistics
## Compute summary statistics and
## save them in a new tibble
summary_stats <-
  arithmetic %>%
  group_by(group) %>%
  summarize(mean = mean(score),
            sd = sd(score),
            nobs = n())
summary_stats

## Part 5: create graphics
## Use the grammar of graphics and ggplot
## to create a nice figure

set.seed(1234)
ggplot(data = arithmetic,
       mapping = aes(y = group,
                     x = score,
                     color = group)) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(position = position_jitter(width = 0.1)) +
  labs(y = "",
       x = "score on test",
       subtitle = "Experiment for learning arithmetic") +
  theme_bw() +
  theme(legend.position = "none")

## Part 6: compute the F-statistic for the global null of
## equality of variance

## Fit the linear model (equivalent to the one-way ANOVA)
mod <- lm(formula = score ~ group, 
          data = arithmetic)
## Create the table with the test statistic and the p-value
(anova_tab <- broom::tidy(anova(mod)))

## Check by hand the calculation of the p-value
pf(q = anova_tab$statistic[1],
   df1 = 4,
   df2 = 40,
   lower.tail = FALSE)


######################################################
#    Script produced for the one-way ANOVA videos    #
######################################################

## Part 1: Contrasts and estimated marginal means
library(emmeans)
emm_mod <- emmeans(object = mod, specs = "group")
emm_mod
pairs(emm_mod)
pairs(emm_mod, adjust = "none")
coef(pairs(emm_mod)) #contrasts columns sum to zero

# Comparison between control groups and praise
# Comparison between control groups and reprove
# Comparison between praise and reprove
specif_contrasts <- list(
  controlvspraised = c(0.5, 0.5, -1, 0, 0),
  controlvsreproved = c(0.5, 0.5, 0, -1, 0),
  praisedvsreproved = c(0, 0, 1, -1, 0)
)
contrasts_bonf <- 
  contrast(object = emm_mod, 
         method = specif_contrasts,
         adjust = "bonferroni") #Bonferroni
contrasts_scheffe <- 
  contrast(object = emm_mod, 
           method = specif_contrasts,
           adjust = "scheffe") # Scheffe adjustment for all contrasts
contrasts_noadjust <- 
  contrast(object = emm_mod, 
           method = specif_contrasts) # no adjustment
confint(contrasts_noadjust)


## Part 2: Multiple testing adjustments
?p.adjust.methods
summary_contrasts <- summary(contrasts_ari)
p.adjust(p = summary$p.value, method = "holm") # Holm-Bonferroni method
# Alternative: give a vector of p-values and a method
# can also use n (n>p) if you are only 
# passing the smallest p-values

## Part 3: effect size
# From library emmeans
effect_size <- 
  emmeans::eff_size(
  object = emm_mod,
  sigma = sigma(mod), 
  edf = df.residual(mod)
  )

# effect size for custom contrasts
effect_size_contrast <- 
  emmeans::eff_size(
    object = contrasts_noadjust,
    sigma = sigma(mod), 
    edf = df.residual(mod)
  )
# Compare with confidence intervals from 
confint(contrasts_noadjust)

## Part 4: power 

# Size of effect
f <- pwr::cohen.ES(test = "anov",
                   size = "small")$effect.size
# f is R2/(1-R2), and f = sqrt(Delta/n)
# When k=2 groups, f=d/2 where d is Cohen's d
pwr_curve <- pwr::pwr.anova.test(
  k = 5, # number of groups
  power = 0.8, # power
  sig.level = 0.05, # level alpha 
  f = f # size of effect
)
plot(pwr_curve)

# Suppose we look instead at what effect size we could detect
pwr::pwr.anova.test(
  k = 5, # number of groups
  power = 0.8, # power
  sig.level = 0.05, # level alpha 
  n = 9 # size of effect
)

# load package (companion to applied regression)
library(car)
plot(mod, which = 1:3)
# Test of equality of variance
car::leveneTest(mod)
# quantile-quantile plot
# If observations are normal
# points should be aligned
# points should fall (roughly) 
qqplot <- car::qqPlot(mod, reps = 1000)
