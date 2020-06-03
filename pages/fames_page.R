library(shiny)
library(dplyr)
library(leaflet)
# setwd("/Users/famebenjasiriwan/Desktop/Fame/UDUB/info201/final-project-jzli23/pages")



# Handling UI -----------------------------------------------------------
page_one_sidepanel <- sidebarPanel(
  h2("Disease Map"),
  selectInput(
    inputId = "diseaseName",
    label = h3("Choose an infectious disease"),
    choices = list(`COVID-19` = "covid", Ebola = "ebola",
                  `SARS` ="sars"),
    selected = "covid"
  ),
  uiOutput("slider")
)

page_one_mainpanel <- mainPanel(
  h2("Aggregate Infection Statistics by Country"), 
  fluidPage(
    leafletOutput(
      outputId = "the_map"
    )
  )
)

fame_page <- tabPanel (
  "Infection Map",
  sidebarLayout(
    page_one_sidepanel,
    page_one_mainpanel
  )
)
ui2 <- navbarPage(
  "Placeholder",
  fame_page
)

# Handling Server -----------------------------------------------------------

# preprocessing
source("fame_preprocess.R")

#covid_data
server2 <- function(input, output) {
  
  output$slider <- renderUI({
    disease <- input$diseaseName
    data <- "dummy"
    if(disease == "covid") {
      data <- covid
    } else if (disease == "sars") {
      data <- sars
    } else {
      data <- ebola
    }
    maxDate <- unique(data[data$Date == max(data$Date),"Date"])
    minDate <- unique(data[data$Date == min(data$Date),"Date"])
    
    sliderInput("max_date", "Date:",
                min = minDate, max = maxDate, value = maxDate, ticks = FALSE)
  })
  
  output$the_map <- renderLeaflet({
    disease <- input$diseaseName
    data <- "dummy"
    if(disease == "covid") {
      data <- covid
    } else if (disease == "sars") {
      data <- sars
    } else {
      data <- ebola
    }
    
    data <- data[data$Date <= input$max_date,]
    
    data <- data %>% group_by(Country) %>% 
      summarise(total_cases = max(confirmed, na.rm = TRUE))
    
    
    geo_data <- sf::st_read("../data/countries.geojson", quiet = TRUE, stringsAsFactors = FALSE)
    
    joined <- left_join(geo_data, data, by = c("ADMIN" = "Country"))
    joined$total_cases[is.na(joined$total_cases)] <- 0
    
    pal <- colorNumeric(
      palette = blues9,
      domain = joined$total_cases
    )
    
    v_lab = sprintf(stringr::str_c("<strong>Country:</strong> %s<br>",
                                   "<strong>Total Cases:</strong> %s<br>",
                                   collapse = ""),joined$ADMIN, joined$total_cases) 
    
    v_lab = purrr::map(v_lab, htmltools::HTML)
    m <- leaflet(joined) %>%
      addPolygons(
        data = joined$geometry,
        weight = 0.5,
        opacity = 1,
        fillOpacity = 1,
        color = "black",
        label = v_lab,
        highlightOptions = highlightOptions(color = "white", weight = 1,
                                            bringToFront = TRUE),
        fillColor = pal(joined$total_cases)) %>%
      addLegend("bottomright",
                pal = pal, values = joined$total_cases,
                title = "Confirmed Cases",
                opacity = 1
      ) %>%
      addControl("Global Confirmed Cases", position = "bottomleft")
      
    return(m)
  })
}

shinyApp(ui = ui2, server = server2)
