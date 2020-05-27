library("shiny")
library("plotly")
library("lintr")
library("dplyr")


# Other Stuff


data <- read.csv(file = "data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
data_by_country <- data %>%
  group_by(Country) %>%
  summarize(
    "Confirmed Cases" = sum(Confirmed),
    "Recovered Cases" = sum(Recovered),
    "Total Deaths" = sum(Deaths)
  )
country_names <- pull(data_by_country, 1)


# UI section


page_one_sidepanel <- sidebarPanel(
  h2("Country Selector"),
  radioButtons(
    inputId = "countryName",
    label = h3("Choose a Country"),
    choices = country_names,
    selected = 1
  )
)
page_one_mainpanel <- mainPanel(
  h2("Country Statistics"), 
  p(
    "this is a paragraph with",
    strong("bold"),
    " text."
  ), 
  textOutput(
    outputId = "message"
  )
)
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
  output$message <- renderText({
    msg <- paste0("Stats for", input$countryName)
    return(msg)
  })
}


# App test


shinyApp(ui = ui2, server = server2)