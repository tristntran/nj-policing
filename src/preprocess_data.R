# basic loading and preprocessing
library(readr)
library(dplyr)
library(tidyverse)
department_df <- read_csv("data/UOF_BY_DEPARTMENTS.csv") %>% 
  select(pd_dept, pct_complaince_hold, pct_hands_fists,
         pct_pepper_spray, pct_baton, pct_take_down, pct_deadly_force)
officer_df <- read_csv("data/UOF-BY-INDIVIDUALS_10_1_20-10_31_22.csv") %>%
  select(agency_name3, TypeofForce, Officer_Name2, INCIDENTID, incident_date)
translation_df <- read_csv("data/translation.csv") %>% filter(!is.na(agency_name3))
# melt department DF

department_df$period <- 1216


# create a second department_df based on teh officer df
# Dummy used for now
department_df2 <- department_df
department_df2$period <- 2021

# label officer df by department
# Translate agency name to department name used in department df
# using translation_df

officer_df <- inner_join(translation_df, officer_df, by="agency_name3") %>% 
  filter(!is.na(pd_dept)) %>%separate_rows(TypeofForce, sep = ',') %>%
  mutate(TypeofForce = gsub(" ", "", TypeofForce, fixed = TRUE))
# label officer df by incident type binary column to determine if 

officer_df$compliance_hold <- TRUE
officer_df$hand_fists <- TRUE
officer_df$pepper_spray <- TRUE
officer_df$baton <- TRUE
officer_df$take_down <- TRUE
officer_df$deadly_force <- TRUE

# combine two dfs vertically using append or concat
final_dept_df <- bind_rows(department_df, department_df2)
# only have departments that have both data points