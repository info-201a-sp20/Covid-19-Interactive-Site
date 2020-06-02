library(dplyr)
library(tidyr)
library(leaflet)
library(ggplot2)
library(shiny)
library(plotly)

ui <- fluidPage(
  titlePanel(
    h1("COVID-19 vs Pandemics")
  ),
  # Main Panel
  mainPanel(
    tabsetPanel(
      # Tab Panel for all summary information
      tabPanel(
        "Summary Information",
        navbarPage(
          title = "",
          tabPanel(
            "Project Goal",
            tags$h2("Our Objective"),
            tags$p(
              "Our group decided to focus our project on illustrating
               the deadliness of", strong("COVID-19"), " through comparisons
               with other recent pandemics including", em("Ebola"), "and",
              em("SARS"), "as well as ongoing viruses like", em("Influenza"),
              ". We hope that these comparisons in the forms of interactive
               charts and maps will shine light on the", strong("deadliness"),
              "of COVID-19 and incentivize people to follow the guidelines
               listed by our local governments. Our research will provide a
               surface level insight of relevant information regarding the
               differnces in these diseases' spread rates, death rates, and
               recovery rates. "
            ),
            tags$p(
              "Our project goes to show how any individual, regardless of
                    having a data science background or not, can access data
                    about COVID-19 and develop their own", strong("intuition"),
              "and conclusions about the situation. There is no excuse
                    to not be informed about something this dangerous and
                    relevant to our lives. "
            )
          ),
          tabPanel(
            "Context",
            tags$h4("What is the Problem?"),
            tags$p("From being an over-saturated topic of interest abused by
                    news channels for content to being one of the deadliest
                    diseases in recent history, COVID-19 has affected the
                    lives of everyone in the world. It is the responsibility of
                    every person to be informed as to how deadly this disease
                    is and the importance of taking measures in order to
                    prevent its spread."),
            tags$h4("Why Should We Care?"),
            tags$p("As shelter in place regulations have been in place for
                    months, people are beginning to revert back to their
                    usual outside activity. Hospital workers are working
                    tirelessly day and night while risking their lives to
                    treat those who have fallen victim to the disease yet
                    so many are still not taking regulations seriously. ")
          ),
          tabPanel(
            "Contributions",
            tags$p("Issac Lai"),
            tags$p("Fame Benjasiriwan"),
            tags$p("Jonathan Li"),
            tags$p("Victoria Jones"),
            tags$i("Informatics 201 A Spring Quarter 2020")
          )
        )
      )
    )
  )
)

# Define a `server` function (with appropriate arguments)
# This function should perform the following:
server <- function(input, output) {



  # Assign a reactive `renderText()` function to the output's `cost` value
  # The reactive expression should return the input `price` times the `quantity`
  # So it looks nice, paste a "$" in front of it!
  output$cost <- renderText({
    return(paste0("$", input$price * input$quantity))
  })
}


# Create a new `shinyApp()` using the above ui and server
shinyApp(ui = ui, server = server)
