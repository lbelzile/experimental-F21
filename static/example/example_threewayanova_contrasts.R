
library(tidyverse)
library(emmeans)

words <- words %>%
   mutate(feedback = factor(feedback, labels = c("none",
                                                 "positive",
                                                 "negative")),
          material = factor(material, labels = c("low freq/low emotion",
                                                 "high freq/low emotion",
                                                 "high freq/high emotion")),
          age = factor(age, labels = c("fifth grade", "senior")))

options(contrasts = c("contr.sum","contr.poly")) #unordered factors, ordered factors
model <- lm(words ~ feedback*material*age, 
            data = words)
anova(model)

# Interaction plot
words %>% 
   group_by(feedback, material, age) %>%
   summarize(meanwords = mean(words)) %>%
ggplot(mapping = aes(y = meanwords,
                     x = feedback,
                     group = material,
                     color = material)) +
   geom_line() +
   facet_wrap(~ age) +
   theme(legend.position = 'bottom') +
   labs(y = "mean words recalled")

# Interaction plot by word type and age
words %>% 
   group_by(material, age) %>%
   summarize(meanwords = mean(words)) %>%
   ggplot(mapping = aes(y = meanwords,
                        x = material,
                        group = age,
                        color = age)) +
   geom_line() +
   theme(legend.position = 'bottom') +
   labs(y = "mean words recalled")

## Reproduce Keppel and Wickens (Chapter 22)
# Note that all degrees of freedom in that chapter are off (90 observations - 18 coefs = 72)
# Main-effects contrasts
# Marginal estimate (average over levels of material and age)
margA <- emmeans(model, specs = "feedback")
# Check that this is indeed the mean of each word count by feedback
words %>% group_by(feedback) %>% summarize(mean = mean(words))
# Compute the marginal contrast: comparison between no-feedback and combined feedback conditions
contrast(margA, list(interaction = c(1,-0.5,-0.5)))


# Simple effects: BxC is significant, so we test for difference between levels of B
# for each value of C (averaged over all feedback replicates)
simpleBpC <- emmeans(model, specs = c("material","age")) %>% 
   joint_tests(by = "age")
# Simple contrasts (p. 498)
margBC <- emmeans(model, specs = c("material","age"), by = "age") %>%
   contrast(method = list(contrast = c(1, 1, -2)))
# Note that K&W report F statistics, so take t.ratio and square it to get the same estimate  

# Interaction components based on marginal means
# Compare b2 and b3: is there difference between groups of C?
emmeans(model, specs = c("material","age"), by = "age") %>%
   contrast(method = list(contrast = c(0, 1, -1)))%>% joint_tests()

# Compute differences between feedback and material (p. 499)
emmeans(model, specs = c("feedback","material")) %>%
   contrast(method = list(contrast = c(0, 0, 0, 1, -0.5, -0.5, -1, 0.5, 0.5)))

# Three factor interaction p.503
# A: no feedback vs feedback: mu1 - 0.5 mu2 - 0.5 mu3
# B: low vs high emotional feedback: mu2 - mu3
# C: fifth grader vs seniors
emmeans(model, specs = c("feedback","material","age")) %>%
   contrast(method = list(contrast = c(c(0, 0, 0, 1, -0.5, -0.5, -1, 0.5, 0.5),
                                       -c(0, 0, 0, 1, -0.5, -0.5, -1, 0.5, 0.5))))

# Compute differences between feedback and material (p. 504)
emmeans(model, specs = c("feedback","material"), by = "age") %>%
   contrast(method = list(contrast = c(0, 0, 0, 1, -0.5, -0.5, -1, 0.5, 0.5)))


# Effect size calculation
omega_sq <- effectsize::omega_squared(model = model, partial = TRUE)
