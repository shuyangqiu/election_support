#### Preamble ####
# Purpose: Tests cleaned data to check for correct number of wards and reasonable income and population values.
# Author: Shuyang Qiu
# Date: 24 January 2023
# Contact: shuyang.qiu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Test data ####
data <- read_parquet("./outputs/data/cleaned_data.parquet")

education_levels <- c("No HS", "High school graduate", "Some college", "2-year", "4-year", "Post-grad")
races <- c("White", "Black", "Hispanic", "Asian", "Other")

all(data$voted_for %in% c("Trump", "Biden"))
all(data$education %in% education_levels)
all(data$race %in% races)
data$voted_for |> levels() |> length() == 2
data$education |> levels() |> length() == education_levels |> length()
data$race |> levels() |> length() == races |> length()