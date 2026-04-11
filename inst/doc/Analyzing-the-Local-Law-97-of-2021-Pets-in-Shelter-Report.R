## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(nycOpenData)
library(ggplot2)
library(dplyr)

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_pull_dataset("5nux-zfmw", limit = 3)

# Seeing what columns are in the dataset
names(small_sample)

## ----filter-year--------------------------------------------------------------

recent_quarters <- nyc_pull_dataset(
  "5nux-zfmw", 
  limit = 3,
  filters = list(date_year = 2024))

recent_quarters

# Checking to see the filtering worked
recent_quarters |>
  distinct(date_year)

## ----filter-multiple----------------------------------------------------------
# Creating the dataset
pets_filtered <- nyc_pull_dataset(
  "5nux-zfmw",
  limit = 20,
  filters = list(
    date_year = "2024",
    number_of_birds = 0))

# Calling head of our new dataset
pets_filtered |>
  slice_head(n = 2)

# Quick check to make sure our filtering worked
pets_filtered |>
  summarize(rows = n())

pets_filtered |>
  distinct(date_year)

pets_filtered |>
  distinct(number_of_birds)

## ----had-pet-year-graph, fig.alt="Bar chart showing the number of shelter applicants with pets by year.", fig.cap="Bar chart showing the number of shelter applicants with pets by year.", fig.height=5, fig.width=7----

pets <- nyc_pull_dataset("5nux-zfmw", limit = 100)
pets <- pets |>
  mutate(had_pet = as.numeric(had_pet))

# summarize by year
pet_by_year <- pets |>
  group_by(date_year) |>
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

