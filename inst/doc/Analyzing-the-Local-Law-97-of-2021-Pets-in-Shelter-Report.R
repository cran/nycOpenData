## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(nycOpenData)
library(ggplot2)
library(dplyr)

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_locallaw97_shelter_pets(limit = 3)
small_sample

# Seeing what columns are in the dataset
colnames(small_sample)

## ----filter-year--------------------------------------------------------------

recent_quarters <- nyc_locallaw97_shelter_pets(
  limit = 3,
  filters = list(date_year = 2024))

recent_quarters

# Checking to see the filtering worked
unique(recent_quarters$date_year)

## ----filter-multiple----------------------------------------------------------
# Creating the dataset
pets_filtered <- nyc_locallaw97_shelter_pets(
  limit = 20,
  filters = list(
    date_year = 2024,
    had_pet = 1))

# Calling head of our new dataset
head(pets_filtered)

# Quick check to make sure our filtering worked
nrow(pets_filtered)
unique(pets_filtered$date_year)
unique(pets_filtered$had_pet)

## ----had-pet-year-graph, fig.alt="Bar chart showing the number of shelter applicants with pets by year.", fig.cap="Bar chart showing the number of shelter applicants with pets by year.", fig.height=5, fig.width=7----

pets <- nyc_locallaw97_shelter_pets(limit = 100)
pets$had_pet <- as.numeric(pets$had_pet)

# Summarize by year
pet_by_year <- pets %>%
  group_by(date_year) %>%
  summarize(applicants_with_pets = sum(had_pet, na.rm = TRUE))

# Plot
ggplot(pet_by_year, aes(x = date_year, y = applicants_with_pets)) +
  geom_col(fill = "darkseagreen") +
  theme_minimal() +
  labs(
    title = "Shelter Applicants With Pets by Year (NYC)",
    subtitle = "Local Law 97 - Pets in Shelter Report",
    x = "Year",
    y = "Number of Applicants With Pets"
  )

