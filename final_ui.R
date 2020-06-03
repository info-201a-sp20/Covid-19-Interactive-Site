library("shiny")
library("plotly")
library("lintr")
library("dplyr")
library("ggplot2")
library("tidyverse")

source("pages/isaac_page.R")
source("pages/jon_page.R")
source("pages/fames_page.R")
source("pages/victoria_page.R")

final_ui <- fluidPage(
  includeCSS("style.css"),
  titlePanel(
    h1("COVID-19 vs Pandemics")
  ),
  # Main Panel
  mainPanel(
    tabsetPanel(
      # Tab Panel for all summary information
      tabPanel(
        "Overview",
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
      ),
      tabPanel(
        "Infection Comparison",
        infection_page
      ),
      tabPanel(
        "Summary",
        tags$h3("Takeaways"),
        tags$p("One main takeaway from this project was that COVID-19 spreads
        much faster than both Ebola and SARS. Another interesting aspect is
        the geographical spread of these 3 diseases. COVID-19 is a global
        pandemic that has spread to every continent. Ebola was mainly present
        in Africa while SARS was prevalent in Asia. By visualizing the spread
        of these respective diseases in regards to time and geographical
        location, we can conclude that COVID-19 spreads significantly faster
        than the other 2 viruses."),
        tags$p("Another takeaway is the drastic difference in the number of
        deaths, recoveries, and cases among the 3 cases. Within the same
        5-month span, COVID-19 resulted in over 300,000 cases which resulted
        in easily 50-100 times more cases than from both SARS and Ebola.
        Similarly, this large gap in cases can be said about the death counts
        of the viruses. Unfortunately, our dataset for Ebola did not contain
        information about recovered cases. But from the 2 points mentioned
        above, it is fair to say that these trends are likely to continue for
        recovered cases as well."),
        tags$p("The last takeaway was the proportion of confirmed cases in
        contrast to that of recovered cases and total deaths. For most
        countries in the world, we see that confirmed cases are highest,
        while recovered cases make up usually 40% of the confirmed cases, and
        cases from death end up being around 5% of the confirmed cases.
        However, countries like the Dominican Republic and the United States
        had a 12% recovery rate that is considered absurdly low that calls
        into question these countries’ preparedness for outbreaks like this.
        Similarly, countries like the United Kingdom had arbitrarily high death
        rates of 15% of total cases which demonstrate their lack of personnel
        in the health department and a higher proportion of older citizens. In
        contrast, countries like Cambodia have had 100% recovery rates with 0
        deaths. It’s reasonable to assume that the difference in the number of
        cases can be explained by the government’s implementation of effective
        strategies for tackling the pandemic."),
        tags$p("Regardless of where you live, everyone has a role to play in
        these trying times. "),
        img("", src = "https://www.health.qld.gov.au/__data/assets/image/0033/947454/varieties/800-lg.jpg")
      )
    )
  )
)