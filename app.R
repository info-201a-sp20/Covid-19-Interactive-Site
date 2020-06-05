library("shiny")
library("plotly")
library("lintr")
library("dplyr")
library("ggplot2")
library("tidyverse")

source("final_ui.R")
source("final_server.R")


shinyApp(ui = final_ui, server = final_server)