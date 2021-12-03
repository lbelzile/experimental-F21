library(tidyverse)
url <- "https://edsm.rbind.io/data/Anandarajan2002_fake.csv"
# Load data
# Cast 'format' to categorical
# Create dummy for 
data <- read.csv(file = url) %>%
  mutate(format = factor(format))
# Check format of data
str(data)

# Check for balance
xtabs(~ format, data = data)
# Nope (need roughly balanced data for good power)

# Sum-to-zero parametrization
options(contrasts = c("contr.sum", "contr.poly"))
# Fit a multivariate linear model
# bind columns on the left for the response
model <- manova(cbind(prime, debt, profitability) ~ format, 
            data = data)
# Check whether there is sufficient correlation
cor(resid(model))
# Print all coefficients
dummy.coef(model)
# Create MANOVA table
# Pick a test statistic among 
# "Pillai", "Wilks", "Hotelling-Lawley", "Roy"
summary(model, test = "Pillai")
# Pillai's trace is more robust to departures from the null hypothesis

# The multivariate linear model is also properly
# handled using 'anova' when fitted with 'lm' 
# (synonym with previous) 'manova' command
anova(lm(cbind(prime, debt, profitability) ~ format, 
         data = data))
# Effect size
effectsize::eta_squared(model)
# Post-hoc comparison using discriminant analysis
# Swap factor explanatory and responses
# Find the best lines that separate groups
# LD shows the weights
MASS::lda(format ~ prime + debt + profitability,
          data = data)

# Checking model assumptions
# Equality of covariance matrix
# Test has small power, but very sensitive
# to model assumptions - may reject for wrong reasons
biotools::boxM(data[, c("prime", "debt", "profitability")],
               grouping = data$format)
# Small p-value, so evidence against equality of covariance matrices

# Test of normality
car::qqPlot(rstudent(model)[,1], 
id = FALSE, # don't flag outliers
ylab = "studentized residuals (prime)")
car::qqPlot(rstudent(model)[,2], 
            id = FALSE, 
            ylab = "studentized residuals (debt)")
car::qqPlot(rstudent(model)[,3], 
            id = FALSE, 
            ylab = "studentized residuals (profitability)")
# Test of multivariate normality
# requires observations to have equal mean
# Detrend using multivariate linear model
# Pass matrix of residuals - transposed!
mvnormtest::mshapiro.test(U = t(model$residuals))
# Evidence against multivariate normality, but 
# matters less (also discrete measurements in
# univariate measures explain rejection of H0)

# Since assumptions are doubtful, use Pilai's trace
# as test statistic for the MANOVA