# Load packages
library(tidyverse)
# Fetch data from OSF
gk_s3_data_raw <- haven::read_sav("https://osf.io/8j36p/download")

# Modify database
gks3_data <- gk_s3_data_raw %>%
  # Keep selected variables
  select(age.group,
         Condition,
         RES_1:RES_4) %>%
  # change names (lower case)
  rename(age = age.group,
         condition = Condition,
         limits = RES_1,
         compr = RES_2,
         persp = RES_3,
         change = RES_4) %>%
  # haven::as_factor takes SPSS variables
  # and make them factor extracting labels
  mutate(age = haven::as_factor(age),
         condition = haven::as_factor(condition))

alpha <- 0.05 # unadjusted level

# We fit the model separately for each response
# technically, could use a multivariate ANOVA...
# but this comes later
mod_old1 <- lm(limits ~ condition,
               data = gks3_data,
               subset = (age == "old"))
# Specify the model with pairwise differences
mod_emm_old1 <- emmeans::emmeans(mod_old1,
                                 specs = 'condition')

#TODO repeat this for the 7 other models
# with other response variables
# and the other age category ("young")

# Check order here to specify your contrasts
levels(gks3_data$condition)
contrast_specif <- list(
  selfdistvsselfimmersed = c(-1, 1, 0, 0)
  #TODO Add the other three contrasts here
)


# Compute the contrasts
#TODO use the naming convention to match
#names in allcontrasts below
#repeat this for the 7 others
contrasts_res_old1 <-
  emmeans::contrast(object = mod_emm_old1,
                    method = contrast_specif,
                    adjust = "none")
# no p-value adjustment because
# otherwise the adjustment is wrong (why?)


# once you have defined each
# pool all tests together
allcontrasts <- rbind(
  # broom::tidy(contrasts_res_old1),
  # broom::tidy(contrasts_res_old2),
  # broom::tidy(contrasts_res_old3),
  # broom::tidy(contrasts_res_old4),
  # broom::tidy(contrasts_res_young1),
  # broom::tidy(contrasts_res_young2),
  # broom::tidy(contrasts_res_young3),
  # broom::tidy(contrasts_res_young4)
)

#TODO enter the correct number of comparisons
m <- #number of tests in the family
  
# Compare confidence intervals
# with and without Bonferroni adjustment
# Compute unadjusted confidence intervals
allcontrasts <- allcontrasts %>%
  mutate(lower = estimate + std.error*qt(p = alpha/2, df = df),
         upper = estimate + std.error*qt(p = 1-alpha/2, df = df))


# Consider multiplicity adjustment
# See ?p.adjust.method and ?p.adjust
# p.adjust(p = allcontrasts$p.value, method = "", n = m)

#TODO compute the number of tests
#for which we get a rejection of H0
sum(with(allcontrasts, p.value <= alpha))
