library(shiny)
library(dplyr)
library(plotly)

Covid <- read.csv("Data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
Ebola <- read.csv("Data/ebola_2014_2016_clean.csv", stringsAsFactors = FALSE)
Sars <- read.csv("Data/sars_2003_complete_dataset_clean.csv", stringsAsFactors = FALSE)

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

# UI
infection_page_side <- sidebarPanel(
  class = "sidebar",
  fluidPage(
    selectInput(
      inputId = "type",
      label = h3("Disease Information:"),
      choices = list("Recovered", "Cases", "Deaths")
    ),
    radioButtons(
      inputId = "disease",
      label = h3("Disease:"),
      choices = list("Covid", "Sars", "Ebola")
    )
  )
)

infection_main <- mainPanel(
  h2("Infection Comparison"),
  fluidPage(
    plotlyOutput(
      outputId = "infection"
    )
  )
)

infection_page <- tabPanel(
  "Infection Comparison",
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
    ) %>%
      add_trace(
        hovertemplate = paste0(input$type, ":", "%{y}", "<extra></extra>")
      )
    return(plot)
  })
}

shinyApp(ui = ui, server = server)
