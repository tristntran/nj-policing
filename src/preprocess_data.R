# basic loading and preprocessing
library(readr)
library(dplyr)
library(tidyverse)
department_df <- read_csv("data/UOF_BY_DEPARTMENTS.csv") %>% 
  select(pd_dept, pct_complaince_hold, pct_hands_fists,
         pct_pepper_spray, pct_baton, pct_take_down,
         pct_leg_strikes, pct_deadly_force)
officer_df <- read_csv("data/UOF-BY-INDIVIDUALS_10_1_20-10_31_22.csv") %>%
  select(agency_name3, TypeofForce, Officer_Name2, INCIDENTID, incident_date)
translation_df <- read_csv("data/translation.csv") %>% filter(!is.na(agency_name3))
useofforce_df <- read_csv("data/useofforce.csv") %>% filter(!is.na(label))
# melt department DF

department_df$period <- 2016


# create a second department_df based on teh officer df
# Dummy used for now
# label officer df by department
# Translate agency name to department name used in department df
# using translation_df

officer_df <- inner_join(translation_df, officer_df, by="agency_name3") %>% 
  filter(!is.na(pd_dept)) %>%separate_rows(TypeofForce, sep = ',') %>%
  mutate(TypeofForce = gsub(" ", "", TypeofForce, fixed = TRUE)) %>%
  inner_join(useofforce_df, by="TypeofForce")
# label officer df by incident type binary column to determine if 
department_df2 <- officer_df %>% group_by(pd_dept) %>% 
  summarise(
    count_incedents = n_distinct(INCIDENTID),
    count_compliance_hold = sum(label =="compliance_hold"),
    count_hand_fists = sum(label =="hands_fists"),
    count_pepper_spray = sum(label == "pepper_spray"),
    count_baton = sum(label == "baton"),
    count_take_down = sum(label == "take_down"),
    count_leg_strikes = sum(label == "leg_strikes"),
    count_deadly_force = sum(label == "deadly_force")
    ) %>% 
  mutate(pct_complaince_hold = count_compliance_hold/count_incedents * 100,
         pct_hands_fists = count_compliance_hold/count_hand_fists * 100,
         pct_pepper_spray = count_compliance_hold/count_pepper_spray * 100,
         pct_baton = count_compliance_hold/count_baton * 100,
         pct_take_down = count_compliance_hold/count_take_down * 100,
         pct_leg_strikes = count_compliance_hold/count_leg_strikes * 100,
         pct_deadly_force= count_compliance_hold/count_deadly_force * 100
         ) %>%
  select(pd_dept, pct_complaince_hold, pct_hands_fists,
         pct_pepper_spray, pct_baton, pct_take_down,
         pct_leg_strikes, pct_deadly_force)
department_df2$period <- 2021
department_df <- department_df[department_df$pd_dept %in% department_df2$pd_dept, ]
# combine two dfs vertically using append or concat
final_dept_df <- bind_rows(department_df, department_df2)
final_dept_df <- melt(final_dept_df,
                      id = c("pd_dept", "period")) %>% rename("force_type" = "variable",
                                                              "percent" = "value")
# only have departments that have both data points


