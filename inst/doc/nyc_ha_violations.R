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

## -----------------------------------------------------------------------------
violations <- nyc_pull_dataset("im9z-53hg")

violations |>
  dplyr::slice_head(n = 6)

## -----------------------------------------------------------------------------
borough_counts <- violations |>
  count(boro_nm, sort = TRUE)

borough_counts

## -----------------------------------------------------------------------------
borough_counts |>
  ggplot(aes(x = reorder(boro_nm, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Number of NYCHA Housing Maintenance Violations by Borough",
    x = "Borough",
    y = "Number of Violations"
  ) +
  theme_minimal()

