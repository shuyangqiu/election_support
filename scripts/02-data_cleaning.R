#### Preamble ####
# Purpose: Cleans and combines the raw ward and raw water datasets.
# Author: Shuyang Qiu
# Date: 24 January 2023
# Contact: shuyang.qiu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####

# Read raw data
raw_data <-
  read_csv(
    "./inputs/data/ces2020.csv",
    col_types = cols(
      "votereg" = col_integer(),
      "CC20_410" = col_integer(),
      "race" = col_integer(),
      "educ" = col_integer()
    )
  )

cleaned_data <-
  raw_data |>
  filter(votereg == 1, CC20_410 %in% c(1, 2)) |> # Filter only registered voters who voted either Trump or Biden
  mutate( # Convert to human readable labels
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    race = case_when(
      race == 1 ~ "White",
      race == 2 ~ "Black",
      race == 3 ~ "Hispanic",
      race == 4 ~ "Asian",
      race >= 5 ~ "Other"
    ),
    race = factor(
      race,
      levels = c(
        "White",
        "Black",
        "Hispanic",
        "Asian",
        "Other"
      )
    ),
    education = case_when(
      educ == 1 ~ "No HS",
      educ == 2 ~ "High school graduate",
      educ == 3 ~ "Some college",
      educ == 4 ~ "2-year",
      educ == 5 ~ "4-year",
      educ == 6 ~ "Post-grad"
    ),
    education = factor(
      education,
      levels = c(
        "No HS",
        "High school graduate",
        "Some college",
        "2-year",
        "4-year",
        "Post-grad"
      )
    )
  ) |>
  select(voted_for, race, education)

#### Save data ####
write_parquet(cleaned_data, "outputs/data/cleaned_data.parquet")
