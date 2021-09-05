# Preprocessing files to transform them into CSV
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
reading <-
  carData::Baumann %>%
  rename(pretest1 = pretest.1,
         pretest2 = pretest.2,
         posttest1 = post.test.1,
         posttest2 = post.test.2,
         posttest3 = post.test.3) %>%
  mutate(group = fct_recode(.f = group,
                            DR = "Basal",
                            TA = "Strat"))
write_csv(reading, file = "reading.csv")


arithmetic <- as_tibble(SMPracticals::arithmetic) %>%
  mutate(y = as.integer(y))
write_csv(arithmetic, file = "arithmetic.csv")
