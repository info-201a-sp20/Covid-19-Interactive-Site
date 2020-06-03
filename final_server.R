library("shiny")
library("plotly")
library("lintr")
library("dplyr")
library("ggplot2")
library("tidyverse")


final_server <- function(input, output) {
  output$chart <- renderPlot({
    data_new <- country_data(input$countryName) %>%
      pivot_longer(
        names_to = `Types of Recorded Cases`,
        values_to = `Number of Cases`,
        c(
          "Confirmed Cases",
          "Recovered Cases",
          "Total Deaths"
        )
      )
    plot <- ggplot(data_new, aes(Types_of_Recorded_Cases, Number_of_Cases)) +
      geom_col(stat = "identity")
    return(plot)
  })
}