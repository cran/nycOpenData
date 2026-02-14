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
library(tidyr)

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_borough_population(limit = 5)
small_sample

# Seeing what columns are in the dataset
colnames(small_sample)

## ----full-data----------------------------------------------------------------
population_data <- nyc_borough_population()
head(population_data)

## ----filter-brooklyn----------------------------------------------------------
brooklyn_pop <- nyc_borough_population(filters = list(borough = "   Brooklyn"))
brooklyn_pop

## ----population-trends, fig.alt="Line chart showing population trends for NYC's five boroughs from 1950 to 2040.", fig.cap="Population trends for NYC's five boroughs from 1950 to 2040, including historical data and projections.", fig.height=6, fig.width=8----

# Get full dataset and filter for Total Population rows only
population_data <- nyc_borough_population()

# Clean borough names and filter to get individual boroughs (exclude NYC Total)
borough_data <- population_data %>%
  mutate(borough = trimws(borough)) %>%  # Remove leading/trailing spaces
  filter(age_group == "Total Population", borough != "NYC Total")

# Reshape from wide to long format
pop_long <- borough_data %>%
  select(borough, `_1950`, `_1960`, `_1970`, `_1980`, `_1990`, `_2000`, `_2010`, `_2020`, `_2030`, `_2040`) %>%
  pivot_longer(cols = starts_with("_"), names_to = "year", values_to = "population") %>%
  mutate(
    year = as.numeric(gsub("_", "", year)),
    population = as.numeric(population)
  )

# Create line chart
ggplot(pop_long, aes(x = year, y = population, color = borough)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal() +
  labs(
    title = "NYC Population by Borough: 1950-2040",
    subtitle = "Historical data and projections",
    x = "Year",
    y = "Population",
    color = "Borough"
  ) +
  theme(legend.position = "bottom")

## ----summary-2040-------------------------------------------------------------
pop_long %>%
  filter(year == 2040) %>%
  arrange(desc(population))

