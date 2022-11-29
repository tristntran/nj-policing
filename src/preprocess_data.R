# basic loading and preprocessing
library(readr)
department_df <- read_csv("data/UOF_BY_DEPARTMENTS.csv")
officer_df <- read_csv("data/UOF-BY-INDIVIDUALS_10_1_20-10_31_22.csv")

# melt department DF

officer_df$period <- 1216
