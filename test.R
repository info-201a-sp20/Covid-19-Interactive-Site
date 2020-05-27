library(knitr)
library(dplyr)
library(plotly)
library(lintr)
library(styler)


data <- read.csv(file = "data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
data_by_country <- data %>%
  group_by(Country) %>%
  summarize(
    "Confirmed Cases" = sum(Confirmed),
    "Recovered Cases" = sum(Recovered),
    "Total Deaths" = sum(Deaths)
  )
country_names <- pull(data_by_country, 1)
