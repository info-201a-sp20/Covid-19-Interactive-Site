library(knitr)
library(dplyr)
library(plotly)
library(lintr)
library(styler)

data <- read.csv(file = "data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
get_info <- function(data){
  country_with_most_cases <- group_by(Country) %>% summarize(test = sum(Confirmed)) %>% filter(test == max(test)) %>% pull(Country)
  country_with_least_cases <- group_by(Country) %>% summarize(test = sum(Confirmed)) %>% filter(test == min(test)) %>% pull(Country)
  most_cases <- group_by(Country) %>% summarize(test = sum(Confirmed)) %>% filter(test == max(test)) %>% pull(test)
  least_cases <- group_by(Country) %>% summarize(test = sum(Confirmed)) %>% filter(test == min(test)) %>% pull(test)
  most_deaths <- group_by(Country) %>% summarize(test = sum(Deaths)) %>% filter(test == max(test)) %>% pull(test)
  info <- list( c(,))
}
