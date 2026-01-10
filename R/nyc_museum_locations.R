#' MUSEUM
#'
#' Downloads Locations of New York City Museums from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Locations of New York City Museums data.
#'
#' @details
#' Locations of New York City Museums
#'
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Recreation/MUSEUM/fn6f-htvy/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_museum_locations(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_museum_locations(limit = 5000)
#' nyc_museum_locations(filters = list(city = "New York"))
#' }
#' @export
nyc_museum_locations <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/fn6f-htvy.json"

  query_list <- list(
    "$limit" = limit
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
