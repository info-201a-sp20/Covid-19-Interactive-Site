library(shiny)
library(dplyr)
library(plotly)

Covid <- read.csv("final-project-jzli23/Data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
Ebola <- read.csv("final-project-jzli23/Data/ebola_2014_2016_clean.csv", stringsAsFactors = FALSE)
Sars <- read.csv("final-project-jzli23/Data/sars_2003_complete_dataset_clean.csv", stringsAsFactors = FALSE)

Covid <- mutate(Covid, month = factor(format(as.Date(Date, format = "%Y-%m-%d"), "%b"), levels = month.abb)) %>%
  group_by(month) %>%
  summarise(Cases = sum(Confirmed), Deaths = sum(Deaths), Recovered = sum(Recovered))

Ebola[is.na(Ebola)] <- 0
Ebola <- mutate(Ebola, month = factor(format(as.Date(Date, format = "%Y-%m-%d"), "%b"), levels = month.abb)) %>%
  group_by(month) %>%
  summarise(Cases = sum(No..of.confirmed.cases), Deaths = sum(No..of.confirmed.deaths), Recovered = 0)

Sars <- mutate(Sars, month = factor(format(as.Date(Date, format = "%Y-%m-%d"), "%b"), levels = month.abb)) %>%
  group_by(month) %>%
  summarise(Cases = sum(Cumulative.number.of.case.s.), Deaths = sum(Number.of.deaths), Recovered = sum(Number.recovered))

# data <- full_join(covid, ebola, by = "month") %>%
#   full_join(., sars, by = "month")
# data[is.na(data)] <- 0

# UI
infection_page_side <- sidebarPanel(
  h2("Infection Comparison"),
  selectInput(
    inputId = "type",
    label = "Disease Information",
    choices = list("Recovered", "Cases", "Deaths")
  ),
  radioButtons(
    inputId = "disease",
    label = h3("Disease:"),
    choices = list("Covid", "Sars", "Ebola")
  )
)

infection_main <- mainPanel(
  plotlyOutput(
    outputId = "infection"
  )
)

infection_page <- tabPanel(
  "Infection Comparison:",
  sidebarLayout(
    infection_page_side,
    infection_main
  )
)

ui <- infection_page

#server
server <- function(input, output) {
  output$infection <- renderPlotly({
    final = eval(parse(text = input$disease))
    plot <- plot_ly(
      data = final,
      x = ~month,
      y = final[[input$type]]
   ) %>%
     layout(
       title = input$disease,
       xaxis = list(title = "Month"),
       yaxis = list(title = input$type)
    )
    return(plot)
  })
}

shinyApp(ui = ui, server = server)
