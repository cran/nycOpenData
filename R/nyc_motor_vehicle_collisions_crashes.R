#' Motor Vehicle Collisions - Crashes
#'
#' Downloads Motor Vehicle Collisions - Crashes data from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Motor Vehicle Collisions - Crashes data.
#'
#' @details
#' The Motor Vehicle Collisions crash table contains details on the crash event.
#' Each row represents a crash event. The Motor Vehicle Collisions data tables contain information from all police reported motor vehicle collisions in NYC.
#' The police report (MV104-AN) is required to be filled out for collisions where someone is injured or killed, or where there is at least $1000 worth of damage (https://www.nhtsa.gov/sites/nhtsa.dot.gov/files/documents/ny_overlay_mv-104an_rev05_2004.pdf).
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_motor_vehicle_collisions_crashes(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_motor_vehicle_collisions_crashes(limit = 5000)
#' nyc_motor_vehicle_collisions_crashes(filters = list(borough = "BROOKLYN"))
#' }
#' @export
nyc_motor_vehicle_collisions_crashes <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/h9gi-nx95.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "crash_date DESC"
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
