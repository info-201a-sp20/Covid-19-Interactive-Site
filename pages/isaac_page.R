library("shiny")
library("plotly")
library("lintr")
library("dplyr")
library("ggplot2")
library("tidyverse")


# Other Stuff


data <-
  read.csv("Data/Countries_with_covid19.csv",
           stringsAsFactors = FALSE)
data_by_country <- data %>%
  group_by(Country) %>%
  summarize(
    "Confirmed Cases" = sum(Confirmed),
    "Recovered Cases" = sum(Recovered),
    "Total Deaths" = sum(Deaths)
  )
country_names <- pull(data_by_country, 1)
country_data <- function(a) {
  var <- data_by_country %>% filter(Country == a)
  return(var)
}

# UI section

country_deaths <- function(a) {
  data_by_country %>%
    filter(Country == a) %>%
    pull(`Total Deaths`)
}
country_cases <- function(a) {
  data_by_country %>%
    filter(Country == a) %>%
    pull(`Confirmed Cases`)
}
country_recoveries <- function(a) {
  data_by_country %>%
    filter(Country == a) %>%
    pull(`Recovered Cases`)
}
page_one_sidepanel <- sidebarPanel(
  class = "sidebar",
  h2("Country Selector"),
  fluidPage(
    selectInput(
      inputId = "countryName",
      label = h3("Select Country"),
      choices = country_names,
      selected = "Afghanistan"
    )
  )
)

page_one_mainpanel <- mainPanel(
  h2("Country Statistics"),
  fluidPage(
    plotlyOutput(
      outputId = "chart"
    )
  ),
  p(
    "This chart serves to compare the number of confirmed cases, recorded deaths, and recorded recoveries from the Corona virus. "
  )
)
isaac_page <- tabPanel(
  "Country Statistics Explorer",
  sidebarLayout(
    page_one_sidepanel,
    page_one_mainpanel
  )
)
ui2 <- navbarPage(
  "Placeholder",
  isaac_page
)


# server section

namex <- "Types of Recorded Cases"
namey <- 

server3 <- function(input, output) {
  output$chart <- renderPlotly({
    data_new <- country_data(input$countryName) %>%
      pivot_longer(
        names_to = "Types of Recorded Cases",
        values_to = "Number of Cases",
        c(
          "Confirmed Cases",
          "Recovered Cases",
          "Total Deaths"
        )
      )
    plot <- ggplot(data_new, aes(`Types of Recorded Cases`, `Number of Cases`)) +
      geom_col(stat = "identity")
    return(plot)
  })
}

shinyApp(ui2, server3)