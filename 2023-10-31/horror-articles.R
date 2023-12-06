library(ggplot2)
library(lubridate)
library(dplyr)

# load data
tuesdata <- tidytuesdayR::tt_load(2023, week = 44)
horror_articles <- tuesdata$horror_articles

horror_new = horror_articles %>% 
  mutate(published_year = year(ymd(horror_articles$published)),
         published_day = day(ymd(horror_articles$published)))

ggplot(horror_new, aes(x = published_year, y = published_day)) +
  geom_point(aes(colour = rating), alpha = 0.3)

ggplot(horror_new, aes(x = author)) +
  geom_bar(aes(fill = rating))

horror_articles %>% 
  mutate(published_year = year(ymd(horror_articles$published)),
         published_day = day(ymd(horror_articles$published))) %>% 
  filter(rating == "false") %>% 
  ggplot(aes(x = published_year)) +
  geom_bar(aes(fill = author))
