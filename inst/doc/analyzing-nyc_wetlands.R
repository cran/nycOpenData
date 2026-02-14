## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(nycOpenData)
library(ggplot2)
library(dplyr)
library(knitr)

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_wetlands(limit = 3)
small_sample

# Seeing what columns are in the dataset
colnames(small_sample)

## ----full-data----------------------------------------------------------------
wetlands_data <- nyc_wetlands(limit = 100)

# Let's take a look at what our full dataset looks like
head(wetlands_data)

## ----ver-status---------------------------------------------------------------
unique(wetlands_data$verificationstatus)

## ----filter-brooklyn-nypd-----------------------------------------------------
# Creating the dataset
verified_wetlands <- wetlands_data %>% filter(verificationstatus != "Unverified")

# Quick check to make sure our filtering worked
nrow(verified_wetlands)
unique(verified_wetlands$verificationstatus)

## ----year-summary-------------------------------------------------------------
verified_per_year <- verified_wetlands %>% 
  group_by(verificationstatusyear) %>% 
  count(verificationstatusyear)

verified_per_year %>% kable(caption = "Verified Wetland Features Per Year")

## ----fig.width=7, fig.height=4------------------------------------------------
ggplot(data = verified_wetlands, aes(x = classname)) +
  geom_bar(fill = "forestgreen") +
  labs(title = "Total Number of Wetland Features By Classification", x = "Classification Name", y = "Total Count") +
  theme_minimal()

