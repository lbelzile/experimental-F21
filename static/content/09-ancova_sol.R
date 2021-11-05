# Filter observations with negative Prior opinions

# Check differences in proportion that mention
# consensus as part of their reasoning
# (1) Compare Boost+ with Consensus
dfsub <- df %>%
  filter(Prior > 0,
         Condition != "Control")
with(dfsub,
     chisq.test(x = Consensus_mention_auto,
                y = Condition))

# (2) Compare Boost+ with Control
dfsub <- df %>%
  filter(Prior > 0,
         Condition != "Consensus")
with(dfsub,
     chisq.test(x = Consensus_mention_auto,
                y = Condition))


dfC2_NO <-
  dfC2[-c(15, 94, 241, 308, 513),]
model2_NO <- lm(Post ~ Condition + Prior, dfC2_NO) #

Anova(model2_NO, type = 3) # sign difference between Consensus only and control
etaSquared(model2_NO, type = 3) # get effect size, also small to medium, but smaller than h1
get.ci.partial.eta.squared(10.583, 1, 571, conf.level = 0.90)
