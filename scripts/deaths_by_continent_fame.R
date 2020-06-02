library(dplyr)
library(ggplot2)
library(scales)
# parameters:

chart_death_by_cont <- function(covid, continents) {
  # clean up country names before processing
  covid[covid$Country == "Taiwan*", "Country"] <- "China"

  covid_death_by_country <- covid %>%
    group_by(Country) %>%
    summarise(deaths = max(Deaths))

  # post processing
  # US <- united states
  # congo B <- congo
  # congo k <- 	Congo, Democratic Republic of
  # cote divore <- Ivory Coast
  # timor leste
  covid_death_by_country[covid_death_by_country$Country ==
                           "Congo (Brazzaville)", "Country"] <-
    "Congo"

  covid_death_by_country[covid_death_by_country$Country ==
                           "Congo (Kinshasa)", "Country"] <-
    "Congo, Democratic Republic of"

  covid_death_by_country[covid_death_by_country$Country ==
                           "Cote d'Ivoire", "Country"] <-
    "Ivory Coast"

  covid_death_by_country[covid_death_by_country$Country ==
                           "Burma", "Country"] <-
    "Burma (Myanmar)"

  covid_death_by_country[covid_death_by_country$Country ==
                           "Bahamas", "Country"] <-
    "The Bahamas"

  covid_death_by_country[covid_death_by_country$Country ==
                           "Guinea-Bissau", "Country"] <-
    "Guinea Bissau"
  
  
  
  
  covid_continents <-
    left_join(continents, covid_death_by_country, by = "Country")
  covid_continents$deaths[is.na(covid_continents$deaths)] <- 0

  death_by_cont <- covid_continents %>%
    group_by(Continent) %>%
    summarise("Total Death" = sum(deaths)) %>%
    mutate(prop = `Total Death` / sum(`Total Death`) * 100) %>%
    mutate(lab.ypos = cumsum(prop) - 0.5 * prop)


  plot <- ggplot(death_by_cont, aes(x = "", y = prop, fill = Continent)) +
    geom_bar(stat = "identity", color = "white") +
    coord_polar(theta = "y", start = 0) +
    ggtitle("Death By Continent") +
    xlab("") +
    ylab("")

  return(plot)
}
