# agilaire dataset example

library(tidyverse)

ncore_quants <- readr::read_csv(
  "data-raw/ncore_quants.csv",
  progress = TRUE,
  name_repair = "minimal",
  show_col_types = FALSE,
  skip_empty_rows = FALSE,
)

agilaire_flags <- readr::read_csv(
  "data-raw/agilaire_flags.csv",
  progress = TRUE,
  name_repair = "minimal",
  show_col_types = FALSE,
  skip_empty_rows = FALSE
)

usethis::use_data(ncore_quants, overwrite = TRUE)
usethis::use_data(agilaire_flags, overwrite = TRUE)
