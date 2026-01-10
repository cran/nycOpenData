#' Medallion Vehicles - Authorized
#'
#' Downloads Medallion Vehicles - Authorized data from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Medallion Vehicles - Authorized data.
#'
#' @details
#' This dataset, which includes all TLC licensed medallion vehicles which are in good standing and able to drive, is updated every day in the evening between 4-7pm.
#' Please check the 'Last Update Date' field to make sure the list has updated successfully.
#' 'Last Update Date' should show either today or yesterday's date, depending on the time of day.
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Transportation/Medallion-Vehicles-Authorized/rhe8-mgbb/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_medallion_drivers_authorized(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_medallion_drivers_authorized(limit = 5000)
#' nyc_medallion_drivers_authorized(filters = list(current_status = "CUR"))
#' }
#' @export
nyc_medallion_drivers_authorized <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/rhe8-mgbb.json"

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
