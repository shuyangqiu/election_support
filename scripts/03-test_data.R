#### Preamble ####
# Purpose: Tests cleaned CES data.
# Author: Shuyang Qiu
# Date: 14 March 2024
# Contact: shuyang.qiu@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Test data ####
data <- read_parquet("./outputs/data/cleaned_data.parquet")

education_levels <- c("No HS", "High school graduate", "Some college", "2-year", "4-year", "Post-grad")
races <- c("White", "Black", "Hispanic", "Asian", "Other")

# Check all values are valid
all(data$voted_for %in% c("Trump", "Biden"))
all(data$education %in% education_levels)
all(data$race %in% races)

# Check all possible values exist
data$voted_for |> levels() |> length() == 2
data$education |> levels() |> length() == education_levels |> length()
data$race |> levels() |> length() == races |> length()