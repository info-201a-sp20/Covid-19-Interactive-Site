remove(list = ls())

# Import all libraries
library(stringr)
library(dplyr)
library(leaflet)
library(ggplot2)
library(tidyverse)
library(lintr)
library(styler)
library(knitr)

# Takes covid-19 dataset as a parameter and returns bar chart of countries with
# most deaths
bar_chart_plot <- function(dataset) {
  # Reads data
  data <- read.csv(dataset)
  
  # Aggregates deaths by country
  deaths_by_country <- aggregate(x = data$Deaths,
                                 by = list(data$Country),
                                 FUN = sum)
  
  # Renames columns to Deaths and Countries
  deaths_by_country <- deaths_by_country %>% 
    rename("Deaths" = x,
           "Countries" = Group.1
    )
  
  # Arranges data in ascending death order
  deaths_by_country <- arrange(deaths_by_country, Deaths)
  # Selects bottom 10 countries
  deaths_by_country <- tail(deaths_by_country, 10)
  
  # ggplot(deaths_by_country, aes(x, Group.1)) + geom_boxplot() # For Boxplot
  
  # Makes bar plot of countires and respective deaths from Covid-19
  plot = ggplot(data = deaths_by_country) +
    geom_col(mapping = aes(x = Countries, y = Deaths,
                           fill = Deaths)) +
    labs(
      title = "Top 10 Countries with most Deaths from Covid-19",
      x = "Countries",
      y = "Deaths"
    ) +
    coord_flip()
}