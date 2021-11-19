# Filter observations with negative Prior opinions

library(tidyverse)
library(emmeans)
url <- "https://edsm.rbind.io/data/vanStekelenburg2021S3.csv"
df <- read.csv(url, header = TRUE) %>%
  filter(Prior > 0) %>%
  mutate(Condition = factor(Condition))
options(contrasts = c("contr.sum", "contr.poly"))
# Chi-square tests for differences in proportion
# for participants that mention
# consensus as part of their reasoning
# Compare Boost+ with Consensus
with(df %>%
       filter(Condition != "Control"),
     chisq.test(x = Consensus_mention_auto,
                y = Condition))

model <- lm(Post ~ Condition + Prior, data = df) #
# Check assumptions
car::leveneTest(resid(model) ~ Condition, 
                data = df)
# We could use robust standard errors to account for heteroscedasticity
car::Anova(model, type = 3, white.adjust = TRUE)

# Or we could fit a model with different variance per group
model <- nlme::gls(Post ~ Condition + Prior,
          weights = nlme::varIdent(form = ~1 | Condition),
          data = df,
          method = "ML")
car::Anova(model, type = 3)
# This does not change the conclusions
# With the second option, 
# we need mode = 'df.error' for the degrees of freedom
# because we added a covariate for pre/post
emmeans(model, specs = "Condition", 
        mode = "df.error") %>%
  contrast(method = "pairwise")
effectsize::eta_squared(model)
car::Anova(model, type = 3) # sign difference between Consensus only and control
etaSquared(model2_NO, type = 3) # get effect size, also small to medium, but smaller than h1
get.ci.partial.eta.squared(10.583, 1, 571, conf.level = 0.90)
