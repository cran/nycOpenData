#' NYC Homeless Drop- In Centers
#'
#' Directory Of Homeless Drop- In Centers
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Directory Of Homeless Drop- In Centers data.
#'
#' @details
#' List of centers where homeless people are provided with hot meals, showers, medical help and a place to sleep
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Social-Services/Directory-Of-Homeless-Drop-In-Centers/bmxf-3rd4/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_homeless_drop_in_centers(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_homeless_drop_in_centers(limit = 5000)
#' nyc_homeless_drop_in_centers(filters = list(borough = "Bronx"))
#' }
#' @export
nyc_homeless_drop_in_centers <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/bmxf-3rd4.json"

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
