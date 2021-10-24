# Class 6: Examples of two-way ANOVA

url <- "https://edsm.rbind.io/data/KW_tab11p8.txt"
monkey <- read.table(url, 
                     header = TRUE,
                     stringsAsFactors = TRUE)
# Sum-to-zero parametrization for each factor
# This overrides the default parametrization of linear models
# so that contr.treatment is replaced with 
options(contrasts = c("contr.sum", "contr.poly"))
#  mu + alpha (row) + beta (column) + [alpha*beta] (cell)
#  Makes a difference with unbalanced samples
linmod <- lm(errors ~ deprivation*drug, 
             data = monkey)
# The following is not needed because of global call

# Anova table
anova(linmod)
# Effect sizes with confidence intervals (90% by default)
cohensf <- effectsize::cohens_f(linmod, partial = TRUE)
omegasq <- effectsize::omega_squared(linmod, partial = TRUE)
Rsquared <- effectsize::eta_squared(linmod, partial = TRUE)
# Partial Cohen's f and R squared are related via
# f = sqrt( R2 / (1-R2) )
isTRUE(all.equal(
  sqrt(Rsquared$Eta2_partial / (1 - Rsquared$Eta2_partial)),
  cohensf$Cohens_f_partial))
# Another estimator of Cohen's f via omega-square
# (used for sample size + power calculations)
cohensf_alt <- sqrt(omegasq$Omega2_partial / (1 - omegasq$Omega2_partial))
# If omega-squared is negative, report zero

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
emmAB_monkey = emmeans(linmod, specs = c("drug", "deprivation"))
emmAB_monkey
# Display to see order of AB combos for contrast coefficients
summary(contrast(emmAB_monkey, 
        list(AB = c(-1, 0, 1, 1, 0, -1)), 
        infer = c(TRUE, TRUE)))
        #infer option: two booleans 
        #first for CI (yes/no)
        #second for t-test and p-values
# Multiple comparisons: A
emmA_monkey <- emmeans(linmod, specs = "drug")

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
# We cannot fit an interaction because there is 
# only one replication per unit
# We need 15 observations for each mean parameter,
#  none left for variance!