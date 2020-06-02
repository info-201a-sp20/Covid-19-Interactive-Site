library(knitr)
library(dplyr)
library(plotly)
library(lintr)
library(styler)
library(tidyverse)

data <- read.csv(file = "data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
data_by_country <- data %>%
  group_by(Country) %>%
  summarize(
    "Confirmed Cases" = sum(Confirmed),
    "Recovered Cases" = sum(Recovered),
    "Total Deaths" = sum(Deaths)
  )
country_names <- pull(data_by_country, 1)
country_deaths <- function(a){
  data_by_country %>% filter(Country == a) %>% pull(`Total Deaths`)
}
country_cases <- function(a){
  data_by_country %>% filter(Country == a) %>% pull(`Confirmed Cases`)
}
country_recoveries <- function(a){
  data_by_country %>% filter(Country == a) %>% pull(`Recovered Cases`)
}
country_deaths("Afghanistan")
country_data <- function(a){
  var <- data_by_country %>% filter(Country == a)
  return(var)
}
country_data("Afghanistan")
data_new <- country_data("Afghanistan") %>%
  pivot_longer(names_to = "Types",
               values_to = "Number",
               c("Confirmed Cases",
                 "Recovered Cases",
                 "Total Deaths"))

ggplot(data_new, aes(Types, Number)) + geom_col(stat = "identity")
