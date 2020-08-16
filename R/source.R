#' Get data from bootstrap
#'
#' @param url Address of FPL API
#' @return a list of data frames
#'
#' @export
get_bootstrap <- function(url = "https://fantasy.premierleague.com/api/bootstrap-static/") {
  data <- curl(url)
  fromJSON(data, simplifyVector = TRUE)
}

#' Return requested table from the bootstrap data
#'
#' @param bootstrap Data from FPL API
#' @param table Name of table to return
#' @return a tibble
#'
#' @export
extract_table <- function(bootstrap = get_bootstrap(), table = "elements") {
  x <- bootstrap[[table]] %>%
    as_tibble()
  structure(list(data = x),
            class = table)
}
