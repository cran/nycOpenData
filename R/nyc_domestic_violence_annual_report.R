#' Annual Report on Domestic Violence Initiatives, Indicators and Factors
#'
#' Downloads Annual Report on Domestic Violence Initiatives, Indicators and Factors data from NYC Open Data.
#'
#' @param limit Number of rows to retrieve (default = 10,000).
#' @param filters Optional list of field-value pairs to filter results.
#' @return A tibble containing Annual Report on Domestic Violence Initiatives, Indicators and Factors data.
#'
#' @details
#' The information in the report is required under Local Law 38 of 2019.
#'
#'
#' @source NYC Open Data: <https://data.cityofnewyork.us/Social-Services/Annual-Report-on-Domestic-Violence-Initiatives-Ind/7t9i-jsfp/about_data>
#'
#' @examples
#' # Quick example (fetch 10 rows)
#' small_sample <- nyc_domestic_violence_annual_report(limit = 10)
#' head(small_sample)
#'
#' \donttest{
#' nyc_domestic_violence_annual_report(limit = 5000)
#' nyc_domestic_violence_annual_report(filters = list(category = "FJC_Client_Visits"))
#' }
#' @export
nyc_domestic_violence_annual_report <- function(limit = 10000, filters = list()) {
  endpoint <- "https://data.cityofnewyork.us/resource/7t9i-jsfp.json"

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
