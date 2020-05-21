library(dplyr)


covid <- read.csv("Data/Countries_with_covid19.csv", stringsAsFactors = FALSE)

# clean up country names before processing
# taiwan <- china
covid[covid$Country == "Taiwan*", "Country"] = "China"



covid_death_by_country <- covid %>% 
  group_by(Country) %>%
  summarise(deaths = max(Deaths))

# post processing
# US <- united states
# congo B <- congo
# congo k <- 	Congo, Democratic Republic of
# cote divore <- Ivory Coast
# burma <- burma (myanmar)
# timor leste
# covid_death_by_country[covid_death_by_country$Country == <Change From>,"Country"] = <Change to>
covid_death_by_country[covid_death_by_country$Country == "Congo (Brazzaville)","Country"] = "Congo"

covid_death_by_country[covid_death_by_country$Country == "Congo (Kinshasa)","Country"] = "Congo, Democratic Republic of"

covid_death_by_country[covid_death_by_country$Country == "1	Cote d'Ivoire","Country"] = "Ivory Coast"

covid_death_by_country[covid_death_by_country$Country == "Burma","Country"] = "Burma (Myanmar)"

covid_death_by_country[covid_death_by_country$Country == "Timor-Leste","Country"] = "East Timor"

continents <- read.csv("Data/Countries-Continents.csv", stringsAsFactors = FALSE)

covid_continents <- left_join(continents, covid_death_by_country, by="Country")
covid_continents$deaths[is.na(covid_continents$deaths)] <- 0

death_by_cont <- covid_continents %>%
  group_by(Continent) %>%
  summarise("Total Death" = sum(deaths))


library(ggplot2)
death_by_cont_chart <- ggplot(data = death_by_cont) +
  geom_col(mapping = aes(x = Continent, y = `Total Death`))


