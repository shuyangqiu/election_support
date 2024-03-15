#### Preamble ####
# Purpose: Generate model for political preference based on race and education.
# Author: Shuyang Qiu
# Date: 14 March 2024
# Contact: shuyang.qiu@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(arrow)
library(rstanarm)


data <- read_parquet("./outputs/data/cleaned_data.parquet")
seed <- 111

#### Create Model ####
political_preferences <-
  stan_glm(
    voted_for ~ race + education,
    data = data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = seed
  )

#### Save Model ####
saveRDS(
  political_preferences,
  file = "./outputs/models/political_preferences.rds"
)