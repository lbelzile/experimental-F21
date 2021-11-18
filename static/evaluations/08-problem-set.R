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

