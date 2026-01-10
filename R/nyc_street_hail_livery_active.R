#' Street Hail Livery (SHL) Drivers - Active
#'
#' Downloads Street Hail Livery (SHL) Drivers - Active data from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Street Hail Livery (SHL) Drivers - Active data.
#'
#' @details
#' NYC TLC licensed drivers that are currently active, in good standing and authorized to operate Street Hail Livery (SHL) vehicles.
#' This list is accurate to the date and time represented in the Last Date Updated and Last Time Updated fields
#'
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Transportation/Street-Hail-Livery-SHL-Drivers-Active/5tub-eh45/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_street_hail_livery_active(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_street_hail_livery_active(limit = 5000)
#' nyc_street_hail_livery_active(filters = list(status_description = "SHL UNRESTRICTED"))
#' }
#' @export
nyc_street_hail_livery_active <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/5tub-eh45.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "last_update_date DESC"
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
