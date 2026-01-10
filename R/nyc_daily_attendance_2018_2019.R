#' 2018-2019 Daily Attendance
#'
#' Downloads 2018-2019 Daily Student Attendance from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing 2018–2019 NYC Daily Student Attendance data.
#'
#' @details
#' Daily listing (counts) of students registered, present, absent and released by School DBN.
#'
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Education/2018-2019-Daily-Attendance/x3bb-kg5j/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_daily_attendance_2018_2019(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_daily_attendance_2018_2019(limit = 5000)
#' nyc_daily_attendance_2018_2019(filters = list(school_dbn = "01M015"))
#' }
#' @export
nyc_daily_attendance_2018_2019 <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/x3bb-kg5j.json"

  query_list <- list(
    "$limit" = limit,
    "$order" = "date DESC"
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
