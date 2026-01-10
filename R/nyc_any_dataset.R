#' Load Any NYC Open Data Dataset
#'
#' Downloads any NYC Open Data dataset given its Socrata JSON endpoint.
#'
#' @param json_link A Socrata dataset JSON endpoint URL (e.g., "https://data.cityofnewyork.us/resource/abcd-1234.json").
#' @param limit Number of rows to retrieve (default = 10,000).
#' @return A tibble containing the requested dataset.
#'
#' @examples
#' \dontrun{
#' endpoint <- "https://data.cityofnewyork.us/resource/erm2-nwe9.json"
#' small_sample <- nyc_any_dataset(endpoint, limit = 10)
#' head(small_sample)
#' }
#' @export
nyc_any_dataset <- function(json_link, limit = 10000) {
  if (!is.character(json_link) || length(json_link) != 1 || is.na(json_link)) {
    stop("`json_link` must be a single, non-missing character URL.", call. = FALSE)
  }
  if (!grepl("\\.json($|\\?)", json_link)) {
    stop("`json_link` must be a Socrata JSON endpoint ending in .json.", call. = FALSE)
  }

  query_list <- list("$limit" = as.integer(limit))

  resp <- httr::GET(json_link, query = query_list)
  httr::stop_for_status(resp)
  data <- jsonlite::fromJSON(httr::content(resp, as = "text"), flatten = TRUE)
  tibble::as_tibble(data)
}
