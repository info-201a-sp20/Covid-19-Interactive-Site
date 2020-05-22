library(knitr)
library(dplyr)
library(plotly)
library(lintr)
library(styler)

data <- read.csv(file = "data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
get_info <- function(data) {
  grouped_data <- data %>% group_by(Country)
  country_with_most_cases <-
    summarize(grouped_data, test = sum(Confirmed)) %>%
    filter(test == max(test)) %>%
    pull(Country)
  country_with_least_cases <-
    summarize(grouped_data, test = sum(Confirmed)) %>%
    filter(test == min(test)) %>%
    pull(Country)
  most_cases <-
    summarize(grouped_data, test = sum(Confirmed)) %>%
    filter(test == max(test)) %>%
    pull(test)
  least_cases <-
    summarize(grouped_data, test = sum(Confirmed)) %>%
    filter(test == min(test)) %>%
    pull(test)
  most_deaths <-
    summarize(grouped_data, test = sum(Deaths)) %>%
    filter(test == max(test)) %>%
    pull(test)
  info <- list(
    country_with_most_cases,
    country_with_least_cases,
    most_cases,
    least_cases,
    most_deaths
  )
}
grouped_data <- data %>% group_by(Country)
country_with_most_cases <-
  summarize(grouped_data, test = sum(Confirmed)) %>%
  filter(test == max(test)) %>%
  pull(Country)
country_with_least_cases <-
  summarize(grouped_data, test = sum(Confirmed)) %>%
  filter(test == min(test)) %>%
  pull(Country)
most_cases <-
  summarize(grouped_data, test = sum(Confirmed)) %>%
  filter(test == max(test)) %>%
  pull(test)
least_cases <-
  summarize(grouped_data, test = sum(Confirmed)) %>%
  filter(test == min(test)) %>%
  pull(test)
most_deaths <-
  summarize(grouped_data, test = sum(Deaths)) %>%
  filter(test == max(test)) %>%
  pull(test)