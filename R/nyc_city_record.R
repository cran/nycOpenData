#' City Record Online
#'
#' Downloads City Record Online data from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing City Record Online data.
#'
#' @details
#' The City Record Online (CROL) is a fully searchable database of notices
#' published in the City Record newspaper, including, but not limited to:
#' public hearings and meetings, public auctions and sales, solicitations and
#' awards and official rules proposed and adopted by city agencies.
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/City-Government/City-Record-Online/dg92-zbpx/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_city_record(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_city_record(limit = 5000)
#' nyc_city_record(filters = list(short_title = "APPOINTED"))
#' }
#' @export
nyc_city_record <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/dg92-zbpx.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "start_date DESC"
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
