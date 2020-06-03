library("shiny")
library("plotly")
library("lintr")
library("dplyr")
library("ggplot2")
library("tidyverse")

source("pages/isaac_page.R")
source("pages/jon_page.R")
source("pages/fames_page.R")
#source("pages/victoria_page.R")

final_ui <- fluidPage(
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
              em("SARS"), "in hopes that these comparisons in the forms of
               interactive charts and maps will shine light on the",
              strong("deadliness"), "of COVID-19 and incentivize people to
               follow the guidelines listed by our local governments. Our
               research will provide a surface level insight of relevant
               information regarding the differnces in these diseases'
               spread rates, death rates, and recovery rates. "
            ),
            tags$p(
              "Our project goes to show how any individual, regardless of
                    having a data science background or not, can access data
                    about COVID-19 and develop their own", strong("intuition"),
              "and conclusions about the situation. There is no excuse
                    to not be informed about something this dangerous and
                    relevant to our lives. "
            ),
            img("", src = "https://media.giphy.com/media/dVuyBgq2z5gVBkFtDc/giphy.gif")
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
                    so many are still not taking regulations seriously. "),
            img("", src = "https://2yc1i12zey253fx89m2v35s3-wpengine.netdna-ssl.com/wp-content/uploads/2020/04/coronavirus-2-1024x681.png")
          ),
          tabPanel(
            "Contributions",
            tags$p("Isaac Lai"),
            tags$p("Fame Benjasiriwan"),
            tags$p("Jonathan Li"),
            tags$p("Victoria Jones"),
            tags$i("Informatics 201 A Spring Quarter 2020")
          ),
          tabPanel(
            "Sources",
            tags$p(a("COVID-19 Dataset",
                     href = "https://github.com/datasets/covid-19/blob/master/data/worldwide-aggregated.csv"
            )),
            tags$p(a("Influenza Dataset",
                     href = "http://www.ufiddynamics.org/data"
            )),
            tags$p(a("Ebola Dataset",
                     href = "https://www.kaggle.com/imdevskp/ebola-outbreak-20142016-complete-dataset"
            )),
            tags$p(a("SARS Dataset",
                     href = "https://www.kaggle.com/imdevskp/sars-2003-outbreak-analysis"
            )),
          )
        )
      ),
      tabPanel(
        "COVID Rates by Country",
        isaac_page
      ),
      tabPanel(
        "Infection Map",
        fame_page
      )
    )
  )
)