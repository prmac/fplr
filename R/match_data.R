match_players <- function(fpl_data = collate_fpl_data(), understat_data = get_player_xX()) {
  x <- fpl_data %>%
    dplyr::filter(Minutes > 0)

  ussn <- understat_data[["standardised_name"]]

  x[standardise_name(x[["Name"]]) %in% ussn, "standardised_name"] <- standardise_name(x[["Name"]])
  x[standardise_name(x[["web_name"]]) %in% ussn, "standardised_name"] <- standardise_name(x[["web_name"]])
  x
}

match_players(understat_data = xX_data)
