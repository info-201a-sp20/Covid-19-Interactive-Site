
## COVID 
covid <- read.csv("Data/Countries_with_covid19.csv", stringsAsFactors = FALSE)
covid[covid$Country ==
             "Congo (Brazzaville)", "Country"] <-
  "Republic of Congo"

covid[covid$Country ==
             "Congo (Kinshasa)", "Country"] <-
  "Democratic Republic of the Congo"

covid[covid$Country ==
             "Cote d'Ivoire", "Country"] <-
  "Ivory Coast"

covid[covid$Country ==
             "Timor-Leste", "Country"] <-
  "East Timor"

covid[covid$Country ==
             "Taiwan*", "Country"] <-
  "Taiwan"

covid[covid$Country ==
             "Korea, South", "Country"] <-
  "South Korea"

covid[covid$Country ==
             "US", "Country"] <-
  "United States of America"

covid[covid$Country ==
             "Tanzania", "Country"] <-
  "United Republic of Tanzania"

covid <- rename(covid, confirmed = Confirmed, deaths = Deaths, recovered = Recovered)

covid$Date <- as.Date(covid$Date, format = "%Y-%m-%d")

## EBOLA 
ebola <- read.csv("Data/ebola_2014_2016_clean.csv", stringsAsFactors = FALSE)
ebola <- rename(ebola, confirmed = No..of.confirmed.cases, 
                deaths = No..of.confirmed.deaths)

ebola$Date <- as.Date(ebola$Date, format = "%Y-%m-%d")



## SARS 
sars <- read.csv("Data/sars_2003_complete_dataset_clean.csv", stringsAsFactors = FALSE)


sars[sars$Country ==
             "Hong Kong SAR, China", "Country"] <-
  "Hong Kong S.A.R."

sars[sars$Country ==
            "Taiwan, China", "Country"] <-
  "Taiwan"

sars[sars$Country ==
            "Viet Nam", "Country"] <-
  "Vietnam"

sars[sars$Country ==
            "Macao SAR, China", "Country"] <-
  "Macao S.A.R"

sars[sars$Country ==
            "Republic of Korea", "Country"] <-
  "South Korea"

sars[sars$Country ==
            "Republic of Ireland", "Country"] <-
  "Ireland"

sars[sars$Country ==
            "Russian Federation", "Country"] <-
  "Russia"

sars <- rename(sars, confirmed = Cumulative.number.of.case.s., 
               deaths = Number.of.deaths, recovered = Number.recovered)

sars$Date <- as.Date(sars$Date, format = "%Y-%m-%d")

