## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(nycOpenData)
library(ggplot2)
library(dplyr)

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_slash_stab(limit = 100)
small_sample

# Seeing what columns are in the dataset
colnames(small_sample)
unique(small_sample$facility)

## ----filter-incident----------------------------------------------------------

incident_slash_stab <- nyc_slash_stab(limit = 3, filters = list(incident_type = "Stabbing"))
incident_slash_stab

# Checking to see the filtering worked
unique(incident_slash_stab$incident_type)

## ----slashing and stabbing----------------------------------------------------
# Creating the datasets
slash <- nyc_slash_stab(limit = 50, filters = list(facility = "AMKC", incident_type = "Slashing"))
stab <- nyc_slash_stab(limit = 50, filters = list(facility = "AMKC", incident_type = "Stabbing"))

# Calling head of our new dataset
head(slash)
head(stab)

# Quick check to make sure our filtering worked
nrow(slash)
nrow((stab))
unique(slash$facility)
unique(stab$facility)

## ----fig.cap="This figure shows incident types by facility."------------------
data <- nyc_slash_stab(limit = 100) %>%
  filter(incident_type %in% c("Slashing", "Stabbing")) %>%
  count(facility, incident_type, name = "count")

ggplot(data, aes(x = incident_type, y = count, fill = facility)) +
  geom_col(position = "dodge") +
  theme_minimal() +
  labs(
    title = "Slashing vs Stabbing Incidents by Facility",
    x = "Incident Type",
    y = "Number of Incidents",
    fill = "Facility"
  )

