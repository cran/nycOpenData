#' NYC Department of Homeless Services (DHS) Daily Report
#'
#'Department of Homeless Services (DHS) Daily Report
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Department of Homeless Services (DHS) Daily Report data.
#'
#' @details
#' This dataset includes the daily number of families and individuals residing in the Department of Homeless Services (DHS) shelter system and the daily number of families applying to the DHS shelter system.
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Social-Services/DHS-Daily-Report/k46n-sa2m/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_dhs_daily_report(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_dhs_daily_report(limit = 5000)
#' nyc_dhs_daily_report(filters = list(total_adults_in_shelter = 55694))
#' }
#' @export
nyc_dhs_daily_report <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/k46n-sa2m.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "date_of_census DESC"
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
