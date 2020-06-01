library("shiny")
library("plotly")
library("lintr")
library("dplyr")
library("ggplot2")
library(tidyverse)


# Other Stuff


data <- read.csv(file = "../data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
data_by_country <- data %>%
  group_by(Country) %>%
  summarize(
    "Confirmed Cases" = sum(Confirmed),
    "Recovered Cases" = sum(Recovered),
    "Total Deaths" = sum(Deaths)
  )
country_names <- pull(data_by_country, 1)
country_data <- function(a){
  var <- data_by_country %>% filter(Country == a)
  return(var)
}

# UI section


page_one_sidepanel <- sidebarPanel(
  h2("Country Selector"),
  radioButtons(
    inputId = "countryName",
    label = h3("Choose a Country"),
    choices = country_names,
    selected = "Afghanistan"
  )
)
# calculations
country_deaths <- function(a){
  data_by_country %>% filter(Country == a) %>% pull(`Total Deaths`)
}
country_cases <- function(a){
  data_by_country %>% filter(Country == a) %>% pull(`Confirmed Cases`)
}
country_recoveries <- function(a){
  data_by_country %>% filter(Country == a) %>% pull(`Recovered Cases`)
}
# page_one_mainpanel <- mainPanel(
#   h2("Country Statistics"), 
#   p(
#     "Stats will be displayed below"
#   ),
#   verbatimTextOutput(
#     outputId = "intro"
#   )
# )
page_one_mainpanel <- mainPanel(
  h2("Country Statistics"), 
  fluidPage(
    plotOutput(
      outputId = "chart"
    )
  )
)
# page_two <- tabPanel(
#   "Page two",
#   fluidPage(
#     h2("Demo using plotly"),
#     textInput(
#       inputId = "title",
#       label = h3("Enter the title you want for the graph"),
#     ),
#     plotlyOutput(
#       outputId = "demoplotly"
#     )
#   )
# )
isaac_page <- tabPanel (
  "Country Statistics",
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


server2 <- function(input, output){
  output$chart <- renderPlot({
    data_new <- country_data(input$countryName) %>%
      pivot_longer(names_to = "Types",
                   values_to = "Number",
                   c("Confirmed Cases",
                     "Recovered Cases",
                     "Total Deaths"))
    plot <- ggplot(data_new, aes(Types, Number)) + geom_col(stat = "identity")
    return(plot)
  })
  # output$intro <- renderText({
  #   msg <- paste0("Stats for ",
  #                 input$countryName,
  #                 ": ",
  #                 "\n",
  #                 "Number of confirmed Cases: ",
  #                 country_cases(input$countryName),
  #                 "\n",
  #                 "Number of recorded Recoveries: ",
  #                 country_recoveries(input$countryName),
  #                 "\n",
  #                 "Number of recorded Deaths: ",
  #                 country_deaths(input$countryName)
  #                 )
  #   return(msg)
  # })
}


# App test


shinyApp(ui = ui2, server = server2)