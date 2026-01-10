#' Medallion Drivers - Active
#'
#' Downloads Medallion Drivers - Active data from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Medallion Drivers - Active data.
#'
#' @details
#' This is a list of drivers with a current TLC Driver License, which authorizes drivers to operate NYC TLC licensed yellow and green taxicabs and for-hire vehicles (FHVs).
#' This list is accurate as of the date and time shown in the Last Date Updated and Last Time Updated fields.
#'
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Transportation/Medallion-Drivers-Active/jb3k-j3gp/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_medallion_drivers_active(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_medallion_drivers_active(limit = 5000)
#' nyc_medallion_drivers_active(filters = list(type = "MEDALLION TAXI DRIVER"))
#' }
#' @export
nyc_medallion_drivers_active <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/jb3k-j3gp.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "last_updated_date DESC"
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
