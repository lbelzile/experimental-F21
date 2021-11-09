# Filter observations with negative Prior opinions

library(tidyverse)
library(emmeans)
url <- "https://edsm.rbind.io/data/vanStekelenburg2021S3.csv"
df <- read.csv(url, header = TRUE)

# Chi-square tests for differences in proportion
# for participants that mention
# consensus as part of their reasoning
# Compare Boost+ with Consensus
dfsub <- df %>%
  filter(Prior > 0,
         Condition != "Control")
with(dfsub,
     chisq.test(x = Consensus_mention_auto,
                y = Condition))

