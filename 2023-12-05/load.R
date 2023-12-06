## Load in data

library(dplyr)
library(ggplot2)
library(showtext)
library(forcats)

## Load in data

tuesdata <- tidytuesdayR::tt_load(2023, week = 48)

drwho_episodes <- tuesdata$drwho_episodes
drwho_directors <- tuesdata$drwho_directors
drwho_writers <- tuesdata$drwho_writers

rm(tuesdata)
