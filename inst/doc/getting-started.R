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

## ----nyc-list-datasets--------------------------------------------------------
nyc_list_datasets() |> head()

## ----nyc-311-pull-------------------------------------------------------------
nyc_motor_vehicle_collisions_data <- nyc_pull_dataset(
  dataset = "h9gi-nx95", limit = 2)

nyc_motor_vehicle_collisions_data <- nyc_pull_dataset(
  dataset = "motor_vehicle_collisions_crashes", limit = 2)

## ----filter-brooklyn----------------------------------------------------------

brooklyn_collisions <- nyc_pull_dataset(dataset = "h9gi-nx95",limit = 2, timeout_sec = 90, filters = list(borough = "BROOKLYN"))
brooklyn_collisions

# Checking to see the filtering worked
brooklyn_collisions |>
  distinct(borough)

## ----filter-brooklyn-nypd-----------------------------------------------------
# Creating the dataset
brooklyn_sedan <- nyc_pull_dataset("h9gi-nx95", limit = 50, timeout_sec = 90, filters = list(vehicle_type_code1 = "Sedan", borough = "BROOKLYN"))

# Calling head of our new dataset
brooklyn_sedan |>
  slice_head(n = 6)

# Quick check to make sure our filtering worked
brooklyn_sedan |>
  summarize(rows = n())

brooklyn_sedan |>
  distinct(vehicle_type_code1)

brooklyn_sedan |>
  distinct(borough)

## ----compaint-type-graph, fig.alt="Bar chart showing the frequency of collision contributing factors in Brooklyn involving a Sedan.", fig.cap="ar chart showing the frequency of collision contributing factors in Brooklyn involving a Sedan.", fig.height=5, fig.width=7----
# Visualizing the distribution, ordered by frequency
brooklyn_sedan |>
  count(contributing_factor_vehicle_1) |>
  ggplot(aes(
    x = n,
    y = reorder(contributing_factor_vehicle_1, n)
  )) +
  geom_col(fill = "steelblue") +
  theme_minimal() +
  labs(
    title = "Top 50 Collisions in Brooklyn Involving a Sedan",
    x = "Number of Collisions",
    y = "Contributing Factor"
  )

