#' Statistical Summary Period Attendance Reporting (PAR)
#'
#' Downloads Statistical Summary Period Attendance Reporting (PAR) from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Period Attendance data.
#'
#' @details
#' Statistical report on attendance by borough, grade.
#' Alternate views of same data by grade level and enrollment (register).
#' All students including YABC, adults, LYFE babies and charters, home instruction, home/hospital, CBO UPK.
#'
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Education/Statistical-Summary-Period-Attendance-Reporting-PA/hrsu-3w2q/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_period_attendance_reporting(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_period_attendance_reporting(limit = 5000)
#' nyc_period_attendance_reporting(filters = list(boro = "X"))
#' }
#' @export
nyc_period_attendance_reporting <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/hrsu-3w2q.json"

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
