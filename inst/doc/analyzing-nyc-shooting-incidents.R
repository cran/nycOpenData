## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE)
library(nycOpenData)
library(ggplot2)

## ----small-sample-------------------------------------------------------------
small_sample <- nyc_shooting_incidents(limit = 3)
small_sample

# Seeing what columns are in the data set
colnames(small_sample)

## ----shooting incidents per borough location typegraph, fig.alt="Cluster bar graph showing the number of shooting incidents per borough with the amount of shootings that took place either outside or inside", fig.cap="Cluster bar graph showing shooting incidents per borough based on the location of shooting."----
shooting_data<-nyc_shooting_incidents(limit=1000)

ggplot(shooting_data, aes(boro, fill = loc_of_occur_desc)) +
  geom_bar(position = "dodge") +
  geom_text(
    stat = "count",
    aes(label=after_stat(count)),
    position = position_dodge(width = 0.8),
    vjust=-0.2,
    size = 3) +
  labs(
    title = "Counts For Shooting Incidents",
    x="Borough",
    y="counts of shooting incidents"
  )+
  theme_minimal()

