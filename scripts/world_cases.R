worldCases <- function(data, geodata) {
  filtered_data <- data %>%
    group_by(Country) %>%
    summarise(Confirmed = sum(Confirmed), Deaths = sum(Deaths), Recovered = sum(Recovered))
  filtered_data[filtered_data$Country == "US", "Country"] <- "United States of America"
  joined <- inner_join(filtered_data, geodata, by = c("Country" = "ADMIN"))
  pal <- colorNumeric(
    palette = "Blues",
    domain = joined$Confirmed)
  leaflet(joined) %>%
    addPolygons(data = joined$geometry,
                stroke = FALSE,
                smoothFactor = 0.2,
                fillOpacity = 1,
                color = pal(joined$Confirmed)) %>%
  addLegend("bottomright", pal = pal, values = ~Confirmed,
            title = "Confirmed Cases",
            opacity = 1
  ) %>%
  addControl("Global Confirmed Cases", position = "bottomleft")
  
<<<<<<< HEAD
}

worldCases(read.csv("Data/Countries_with_covid19.csv", stringsAsFactors = FALSE), 
           sf::st_read("Data/countries.geojson", quiet = TRUE))
=======
}
>>>>>>> ef8d0a4e473cda5a28ab6104fd6d2c7e1349960a
