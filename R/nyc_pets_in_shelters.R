#' NYC Pets in Shelter Report
#'
#' Local Law 97 of 2021 - Pets in Shelter Report from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Local Law 97 of 2021 - Pets in Shelter Report data.
#'
#' @details
#' This quarterly report provides survey response data about the types of pets whose owners enter homeless shelters.
#' Data is aggregated at the quarterly level (ie: 2024 Q3).
#' The unit of analysis is a fiscal year quarter: Quarter 1 (Q1): July - September; Quarter 2 (Q2): October - December; Quarter 3 (Q3): January - March; Quarter 4 (Q4): April - June.
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Social-Services/Local-Law-97-of-2021-Pets-in-Shelter-Report/5nux-zfmw/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_pets_in_shelters(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_pets_in_shelters(limit = 5000)
#' nyc_pets_in_shelters(filters = list(date_quarter = "Qtr 1"))
#' }
#' @export
nyc_pets_in_shelters <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/5nux-zfmw.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "date_year DESC"
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
