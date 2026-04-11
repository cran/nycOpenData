## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(nycOpenData)
library(ggplot2)
library(dplyr)

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_pull_dataset(dataset = "gakf-suji", limit = 3)
small_sample

# Seeing what columns are in the dataset
names(small_sample)

## ----filter-incident----------------------------------------------------------

incident_slash_stab <- nyc_pull_dataset("gakf-suji", limit = 3, filters = list(incident_type = "Stabbing"))
head(incident_slash_stab)

# Checking to see the filtering worked
incident_slash_stab |>
  distinct(incident_type)

## ----slashing-stabbing--------------------------------------------------------
# Creating the datasets
slash <- nyc_pull_dataset("gakf-suji", limit = 50, filters = list(facility = "AMKC", incident_type = "Slashing"))

stab <- nyc_pull_dataset("gakf-suji", limit = 50, filters = list(facility = "AMKC", incident_type = "Stabbing"))

# Calling head of our new dataset
slash |>
  slice_head(n = 6)

stab |>
  slice_head(n = 6)

# Quick check to make sure our filtering worked
slash |>
  summarize(rows = n())

stab |>
  summarize(rows = n())

## ----fig.cap="This figure shows incident types by facility."------------------
data <- nyc_pull_dataset("gakf-suji", limit = 100) |>
  filter(incident_type %in% c("Slashing", "Stabbing")) |>
  count(incident_type, name = "count")

ggplot(data, aes(x = incident_type, y = count)) +
  geom_col(position = "dodge") +
  theme_minimal() +
  labs(
    title = "Slashing vs Stabbing Incidents by Facility",
    x = "Incident Type",
    y = "Number of Incidents",
    fill = "Facility"
  )

