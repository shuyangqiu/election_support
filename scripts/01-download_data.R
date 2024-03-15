#### Preamble ####
# Purpose: Downloads and saves CES 2020 data.
# Author: Shuyang Qiu
# Date: 24 January 2023
# Contact: shuyang.qiu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None


#### Workspace setup ####
library(dataverse)
library(tidyverse)

#### Download data ####

ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |>
  select(votereg, CC20_410, race, educ)

#### Save data ####

write_csv(ces2020, "./inputs/data/ces2020.csv")
