library(tidyverse) #load package

# Fetch data
url <- "https://edsm.rbind.io/data/teller.txt"
tellers <- read.table(url, header = TRUE) %>%
  mutate(id = factor(id),
         course = factor(course),
         nweeks = factor(nweeks))
# Set sum-to-zero parametrization as default for factors
options(contrasts = c("contr.sum", "contr.poly"))
lm(error ~ nweeks*course, data = tellers)

# Plot error per week!

# Interaction plot
tellers %>% 
  group_by(course, nweeks) %>%
  summarize(merror = mean(error)) %>%
 ggplot(aes(x = nweeks,
            y = merror,
            group = course,
            color = course)) +
  geom_line() +
  theme_classic() + 
  theme(legend.position = "bottom") + 
  labs(y = "",
       subtitle = "average monthly error (USD)",
       x = "number of weeks of 1-1 training")