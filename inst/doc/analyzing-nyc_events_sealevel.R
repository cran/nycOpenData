## ----setup--------------------------------------------------------------------
library(nycOpenData)
library(dplyr)
library(ggplot2)
library(knitr)

## ----retrieve-sample----------------------------------------------------------
sample_data <- nyc_events_sealevel(limit = 10)
sample_data

## ----key-metrics--------------------------------------------------------------
summary_table <- sample_data %>%
  select(period, number_of_heatwaves_year, cooling_degree_days, heating_degree_days) %>%
  head(10)
summary_table

## ----visualization------------------------------------------------------------
ggplot(sample_data, aes(x = period, y = as.numeric(number_of_heatwaves_year))) +
  geom_col() +
  labs(
    title = "Projected Number of Heatwaves by Scenario",
    x = "Climate Scenario",
    y = "Number of Heatwaves"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

