library(targets)
library(tarchetypes)
source("R/functions.r")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("biglm", "dplyr", "ggplot2", "readr", "tidyr"))

list(
  # 1. obtain data
  tar_target(
    raw_data_file,
    "data/raw_data.csv",
    format = "file"
  ),
  # 2. read data
  tar_target(
    raw_data,
    read_csv(raw_data_file, col_types = cols())
  ),
  # 3. pre process data
  tar_target(
    data,
    raw_data %>%
      filter(!is.na(Ozone))
  ),
  # 4. make histogram plot
  tar_target(hist, create_plot(data)),
  # 5. make fit of data
  tar_target(fit, biglm(Ozone ~ Wind + Temp, data)),
  # 6. render a report
  tar_render(report, "reports/index.Rmd")
)