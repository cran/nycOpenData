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

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_locallaw18_payreport (limit = 3)
small_sample

# Seeing what columns are in the dataset
colnames(small_sample)

## ----filter-brooklyn----------------------------------------------------------

lessthan5_locallaw18payreport <- nyc_locallaw18_payreport(limit = 3, filters = list(number_of_employees = "<5"))
lessthan5_locallaw18payreport 


# Checking to see the filtering worked
unique(lessthan5_locallaw18payreport)

## ----filter-brooklyn-nypd-----------------------------------------------------
# Creating the dataset
lessthan5TI_payreport <- nyc_locallaw18_payreport(
  limit = 15,
  filters = list(
    number_of_employees = "<5",
    agency_name = "TECHNOLOGY & INNOVATION",
    gender = "Female"
  )
)


# Calling head of our new dataset
head(lessthan5TI_payreport)

# Quick check to make sure our filtering worked
nrow(lessthan5TI_payreport)
unique(lessthan5TI_payreport$agency_name)
unique(lessthan5TI_payreport$gender)

## ----compaint-type-graph, fig.alt="Bar chart showing the ethnicity of female workers in departments with less than 5 employees in Technology & Innovation.", fig.cap="Bar chart showing the ethnicity of female workers in municipal departments with less than 5 people in Technology & Innovation (15 most recent.", fig.height=5, fig.width=7----

# Visualizing the distribution, ordered by frequency

lessthan5TI_payreport %>%
  count(ethnicity) %>%          # count how many rows fall in each ethnicity
  ggplot(aes(
    x = n,                       # n = number of rows per ethnicity
    y = reorder(ethnicity, n)    # reorder ethnicities by their counts
  )) +
  geom_col(fill = "steelblue") + # geom_col uses the counts we already computed
  theme_minimal() +
  labs(
    title = "Ethnicity of Female Employees in Bracket of TI Agencies with Fewer Than 5 Employees",
    subtitle = "Most Recent 15 Records",
    x = "Number of Records",
    y = "Ethnicity"
  )


