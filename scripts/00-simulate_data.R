#### Preamble ####
# Purpose: Simulates a dataset where chance a person supports Biden depends on
# their race and education.
# Author: Shuyang Qiu
# Date: 14 March 2024
# Contact: shuyang.qiu@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(111)

num_obs <- 1000

us_political_preferences <- tibble(
  education = sample(0:4, size = num_obs, replace = TRUE),
  race = sample(0:3, size = num_obs, replace = TRUE),
  support_prob = ((education + race) / 7),
) |>
  mutate(
    supports_biden = if_else(runif(n = num_obs) < support_prob, "yes", "no"),
    education = case_when(
      education == 0 ~ "< High school",
      education == 1 ~ "High school",
      education == 2 ~ "Some college",
      education == 3 ~ "College",
      education == 4 ~ "Post-grad"
    ),
    race = case_when(
      race == 0 ~ "White",
      race == 1 ~ "Black",
      race == 2 ~ "Hispanic",
      race == 3 ~ "Asian"
    ),
  ) |>
  select(-support_prob, supports_biden, race, education)

#### Validate data ####

education_levels <-
  c("< High school", "High school", "Some college", "College", "Post-grad") |>
  sort()

races <-
  c("White", "Black", "Hispanic", "Asian") |>
  sort()

us_political_preferences$supports_biden |> unique() |> sort() == c("yes", "no") |> sort()
us_political_preferences$education |> unique() |> sort() == education_levels
us_political_preferences$race |> unique() |> sort() == races
