get_player_xX <- function(league = "EPL", year = "2020") {
  team_stats <- understatr::get_league_teams_stats(league_name = league, year = year)
  players_stats <- purrr::map_dfr(unique(team_stats[["team_name"]]),
                                  understatr::get_team_players_stats, year = year) %>%
    dplyr::mutate(clean_name = fix_names(player_name),
                  standardised_name = standardise_name(clean_name))

  players_stats
}
