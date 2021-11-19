library(tidyverse)
url <- "https://edsm.rbind.io/data/Bobak2019S2.csv"
bobak_full <- read.csv(url, header = TRUE)
bobak <- bobak_full %>%
  select(pnum:diffmon) %>%
  pivot_longer(cols = starts_with("diff"),
               names_to = "color",
               names_prefix = "diff",
               values_to = "pcorr") %>%
  mutate(color = factor(color),
         sex = factor(sex))

