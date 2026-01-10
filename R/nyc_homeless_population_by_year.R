#' NYC Homeless Population By Year
#'
#' Directory Of Homeless Population By Year
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Directory Of Homeless Population By Year data.
#'
#' @details
#' Table of homeless population by Year (for years 2009 through 2012)
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Social-Services/Directory-Of-Homeless-Population-By-Year/5t4n-d72c/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_homeless_population_by_year(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_homeless_population_by_year(limit = 5000)
#' nyc_homeless_population_by_year(filters = list(area = "Subways"))
#' }
#' @export
nyc_homeless_population_by_year <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/5t4n-d72c.json"

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
