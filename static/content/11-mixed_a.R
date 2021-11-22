# Singmann and Klauer (2011)
# Deductive and inductive conditional inferences
# Thinking and Reasoning
# doi:10.1080/13546783.2011.572718
# The data can be found in the 'afex' package
# ?sk2011.2
library(tidyverse)
library(lme4)
library(lmerTest)
options(contrasts = c("contr.sum","contr.poly"))
# Load data from afex package
data(sk2011.2, package = "afex")
data <- sk2011.2 %>%
  filter(!id %in% c(7, 8, 9, 12, 17, 24, 30),
         what == "denial") %>%
  mutate(inference = droplevels(inference))
str(data)
mod <- lme4::lmer(response ~ instruction * inference* type +
             (1 | id) + 
             (1 | id:inference) + 
             (1 | id:type) + 
             (1 | id:inference:type),
           data = data)
car::Anova(mod, type = 3, test = "F")
aov_ez(id = "id", 
       dv = "response", 
       data = data, 
       between = "instruction", 
       within = c("inference", "type"),
       anova_table = list(es = "pes", 
                        correction = "none"))
