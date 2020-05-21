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

data <- read.csv("Data/Countries_with_covid19.csv")

# Aggregates deaths by country
deaths_by_country <- aggregate(x = data$Deaths,
                               by = list(data$Country),
                               FUN = sum)
# Arranges data in ascending death order
deaths_by_country <- arrange(deaths_by_country, x)
# Selects bottom 10 countries
deaths_by_country <- tail(deaths_by_country, 10)

# ggplot(deaths_by_country, aes(x, Group.1)) + geom_boxplot() # For Boxplot

# Makes bar plot of countires and respective deaths from Covid-19
ggplot(data = deaths_by_country) +
  geom_col(mapping = aes(x = Group.1, y = x,
                         fill = x)) +
  labs(
    title = "Top 10 Countries with most Deaths from Covid-19",
    x = "Countries",
    y = "Deaths"
  ) +
  coord_flip()