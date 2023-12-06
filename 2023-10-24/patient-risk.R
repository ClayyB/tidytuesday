library(dplyr)
library(ggplot2)
library(janitor)
library(tidyr)
library(stringr)

# Load data

tuesdata <- tidytuesdayR::tt_load(2023, week = 43)
patient_risk_profiles <- tuesdata$patient_risk_profiles

patient_risk = patient_risk_profiles %>% 
  clean_names() 

rm(patient_risk_profiles, tuesdata)

# -------------- #

patient_risk = patient_risk %>% 
  mutate(sex = ifelse(sex_female == 1, "Female", "Male"))

ggplot(patient_risk, aes(x = sex)) +
  geom_bar()

# what do I want to do? 
# compare risk for certain health problems with age group
# e.g. age group across the bottom, and count for each thing in one of 
# those plots with the dots that spread evenly? Density plot?
# simpler version - multi-bar chart? 
patient_risk %>% 
  pivot_longer(starts_with("age_group"), names_to = "age_group") %>% 
  filter(value == 1) %>% 
  mutate(age_group = str_remove(age_group, "age_group_")) %>% 
  select(person_id, age_group) %>% 
  separate_wider_delim(age_group, delim = "_", names = c("min_age", "max_age"))
         