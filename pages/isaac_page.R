library("shiny")
library("plotly")
library("lintr")
library("dplyr")


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
# page_two_sidepanel <- sidebarPanel(
#   h2("Begining Date Selector"),
#   sliderInput("integer", "Integer:",
#               min = 0, max = 1000,
#               value = 500)
# )
# page_three_sidepanel <- sidebarPanel(
#   h2("Ending Date Selector"),
#   sliderInput("integer", "Integer:",
#               min = 0, max = 1000,
#               value = 500)
# )
page_one_mainpanel <- mainPanel(
  h2("Country Statistics"), 
  p(
    "Stats will be displayed below"
  ),
  textOutput(
    outputId = "intro"
  )
)
isaac_page <- tabPanel (
  "Country Statistics",
  sidebarLayout(
    page_one_sidepanel,
    # page_two_sidepanel,
    # page_three_sidepanel,
    page_one_mainpanel
  )
)
ui2 <- navbarPage(
  "Placeholder",
  isaac_page
)


# server section


server2 <- function(input, output){
  output$intro <- renderText({
    msg <- paste0("Stats for ",
                  input$countryName,
                  ": ",
                  "\n",
                  "Number of confirmed Cases: ",
                  
                  "Number of recorded Deaths: "
                  
                  )
    return(msg)
  })
}


# App test


shinyApp(ui = ui2, server = server2)