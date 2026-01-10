#' New York City Leading Causes of Death
#'
#' Downloads New York City Leading Causes of Death data from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing New York City Leading Causes of Death data.
#'
#' @details
#' The leading causes of death by sex and ethnicity in New York City in since 2007.
#' Cause of death is derived from the NYC death certificate which is issued for every death that occurs in New York City.
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Health/New-York-City-Leading-Causes-of-Death/jb7j-dtam/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_cause_of_death(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_cause_of_death(limit = 5000)
#' nyc_cause_of_death(filters = list(sex = "M"))
#' }
#' @export
nyc_cause_of_death <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/jb7j-dtam.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "year DESC"
  )

  if (length(filters) > 0) {
    where_clauses <- paste0(names(filters), " = '", filters, "'")
    query_list[["$where"]] <- paste(where_clauses, collapse = " AND ")
  }

  resp <- httr::GET(endpoint, query = query_list)
  httr::stop_for_status(resp)
  data <- jsonlite::fromJSON(httr::content(resp, as = "text"), flatten = TRUE)
  tibble::as_tibble(data)
}
