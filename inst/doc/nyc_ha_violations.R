## ----setup, include = FALSE---------------------------------------------------
library(nycOpenData)
library(dplyr)
library(ggplot2)

## -----------------------------------------------------------------------------
data <- nyc_ha_violations()

head(data)

## -----------------------------------------------------------------------------
data %>%
  count(boro_nm)

## -----------------------------------------------------------------------------
data %>%
  count(boro_nm) %>%
  ggplot(aes(x = boro_nm, y = n)) +
  geom_col() +
  labs(
    title = "Number of NYCHA Violations by Borough",
    x = "Borough",
    y = "Number of Violations"
  )

