library(dplyr)
library(ggplot2)
library(readr)

tuesdata = tidytuesdayR::tt_load(2023, week = 19)

childcare_costs = tuesdata$childcare_costs
counties = tuesdata$counties

abortion_states = read_csv("abortion-states.csv")

states_status = merge(counties, abortion_states, by = "state_name")

counties_status = merge(states_status, childcare_costs, by = "county_fips_code")

ones_vector = 200 * rep(1, 50)

my_colours = c("#8c5a0a", "#e60505", "#f78383", "#a2f2ba", "#078a00")

states_average = counties_status %>% 
  filter(study_year == 2018) %>% 
  group_by(state_name) %>% 
  summarise(mean_cost = mean(mfccsa, na.rm = TRUE)) %>% 
  merge(abortion_states, by = "state_name") %>% 
  cbind(ones_vector)

ggplot(states_average, aes(x = reorder(state_name, mean_cost, sum))) +
  geom_col(aes(y = ones_vector, fill = status), alpha = 0.4) +
  scale_fill_manual(values = my_colours) +
  geom_point(aes(y = mean_cost), colour = "black") +
  theme_classic() +
  labs(x = "State",
       y = "Mean childcare costs") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

# geom_col(aes(y = mean_cost), fill = "#ffffff", colour = "black", width = 0.5) +
  
