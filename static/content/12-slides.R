# Mediation analysis
# Data from Preacher and Hayes (2004)
# install.packages("mediation")
library(mediation)
set.seed(1234)
url <- "https://edsm.rbind.io/data/mediator.csv"
mediator <- read.csv(mediator, 
                     header = TRUE, 
                     stringsAsFactors = TRUE)
# Response (y): satis
# Mediator (m): attrib
# Treatment (t): therapy
mediat <- mediation::mediate(
  model.m = lm(attrib ~ therapy, 
               data = mediator),
  model.y = lm(satis ~ therapy + attrib, 
               data = mediator),
  sims = 1e3,
  boot = TRUE,
  boot.ci.type = "perc",
  treat = "therapy",
  mediator = "attrib")
summary(mediat)
plot(mediat) # Plot coefs and 95%CI

# JOBS II Field experiment
# with confounders
# from documentation of ?mediate (Example 1)
data(jobs)
med_mod <- lm(job_seek ~ treat + econ_hard + sex + age, data = jobs)
res_mod <- lm(depress2 ~ treat + job_seek + econ_hard + sex + age, data = jobs)


# Estimation via nonparametric bootstrap
contcont.boot <- 
  mediate(model.m = med_mod,
          model.y = res_mod,
          boot = TRUE, 
          sims = 1e3,
          treat = "treat", 
          mediator = "job_seek")
summary(contcont.boot)
# Allowing treatment-mediator interaction
res_mod2 <- lm(depress2 ~ treat + job_seek + treat:job_seek + econ_hard + sex + age, data = jobs)
contcont.int <- mediate(
  model.m = med_mod,
  model.y = res_mod2,
  sims = 1e3, 
  boot = TRUE,
  treat = "treat", 
  mediator = "job_seek")
summary(contcont.int)