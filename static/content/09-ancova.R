# Filter observations with negative Prior opinions

library(tidyverse)
library(emmeans)
url <- "https://edsm.rbind.io/data/vanStekelenburg2021S3.csv"
df <- read.csv(url, header = TRUE)

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
# TODO 
