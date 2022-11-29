# basic loading and preprocessing
library(readr)
library(dplyr)
department_df <- read_csv("data/UOF_BY_DEPARTMENTS.csv")
officer_df <- read_csv("data/UOF-BY-INDIVIDUALS_10_1_20-10_31_22.csv")
translation_df <- read_csv("data/translation.csv")
# melt department DF

department_df$period <- 1216


# create a second department_df based on teh officer df
# Dummy used for now
department_df2 <- department_df
department_df2$period <- 2021

# label officer df by department
# Translate agency name to department name used in department df
# using translation_df


# label officer df by incident type binary column to determine if 
officer_df$compliance_hold <- TRUE
officer_df$hand_fists <- TRUE
officer_df$pepper_spray <- TRUE
officer_df$baton <- TRUE
officer_df$take_down <- TRUE
officer_df$deadly_force <- TRUE

# combine two dfs vertically using append or concat
final_dept_df <- bind_rows(department_df, department_df2)
# output two filtered dfs that have combined data.