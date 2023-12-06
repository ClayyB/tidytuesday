tuesdata <- tidytuesdayR::tt_load(2023, week = 37)

all_countries <- tuesdata$all_countries
country_regions <- tuesdata$country_regions
global_human_day <- tuesdata$global_human_day
global_economic_activity <- tuesdata$global_economic_activity

View(global_economic_activity)

library(ggplot2)

ggplot(global_human_day, aes(x=Subcategory, y=hoursPerDay)) +
    geom_col()
