library(knitr)
library(dplyr)
library(plotly)
library(lintr)
library(styler)

data <- read.csv(file = "data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
get_info <- function(data){
  country_with_most <- group_by(Country) %>% summarize(test = sum())
  country_with_least
}