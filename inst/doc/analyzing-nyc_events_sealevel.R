## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(nycOpenData)
library(dplyr)
library(ggplot2)

## ----retrieve-sample----------------------------------------------------------
sample_data <- nyc_pull_dataset("38ps-fnsg", limit = 10)
nyc_list_datasets()

sample_data

## ----key-metrics--------------------------------------------------------------
summary_table <- sample_data |>
  select(period, number_of_heatwaves_year, cooling_degree_days, heating_degree_days) |> dplyr::slice_head(n = 10)

summary_table

## ----visualization------------------------------------------------------------
plot_data <- sample_data |>
  mutate(number_of_heatwaves_year = as.numeric(number_of_heatwaves_year))

ggplot(plot_data, aes(x = period, y = number_of_heatwaves_year)) +
  geom_col() +
  labs(
    title = "Projected Number of Heatwaves by Climate Period",
    x = "Climate Period",
    y = "Projected Heatwaves per Year"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

