library(knitr)
library(dplyr)
library(plotly)
library(lintr)
library(styler)

data <- read.csv(file = "data/Countries_with_covid19.csv", stringsAsFactors = FALSE)

table_maker <- function(data){
  data_table <-
    data %>%
    group_by(Country) %>%
    summarize(
      "Confirmed Cases" = sum(Confirmed),
      "Recovered Cases" = sum(Recovered),
      "Total Deaths" = sum(Deaths)
    )
  data_table <- data_table[order(-data_table[2]), ]
  # Sorted by number of confirmed cases
  data_table <- top_n(data_table, 20)
  # Only using the twenty highest countries
  
  # Only thing missing is the introduction and interpretation
  return(data_table)
}