#' @export
match_players <- function(fpl_data = collate_fpl_data(), understat_data = get_player_xX()) {
  fpl_data <- fpl_data %>%
    dplyr::filter(Minutes > 0)

  ussn <- understat_data[["standardised_name"]]

  fpl_data <- fpl_data %>%
    mutate(standardised_Name = standardise_name(Name),
           standardised_web_name = standardise_name(web_name),
           Position = forcats::fct_relevel(Position,
                                           c("Goalkeeper", "Defender", "Midfielder", "Forward")))

  joined_df <- fpl_data %>%
    nest_join(understat_data, by = c("standardised_Name" = "standardised_name"),
              keep = TRUE, name = "first_join_condition")  %>%
    nest_join(understat_data, by = c("standardised_web_name" = "standardised_name"),
              keep = TRUE, name = "second_join_condition") %>%
    mutate(ored_join_condition = purrr::map2(first_join_condition, second_join_condition,
                                      function(x, y) if(nrow(x) == 0) y else x)) %>%
    select(-first_join_condition, -second_join_condition) %>%
    tidyr::unnest(ored_join_condition) %>%
    full_join(fpl_data) %>%
    dplyr::select(Name = web_name,
                  Team,
                  Position,
                  Price,
                  Points,
                  PPG,
                  Bonus,
                  Form,
                  Season_value,
                  Form_value,
                  VAPM,
                  Selected_by,
                  In,
                  Out,
                  Minutes,
                  Goals = goals,
                  xG,
                  Assists = assists,
                  xA,
                  Shots = shots,
                  Key_passes = key_passes,
                  Yellows = yellow_cards,
                  Reds = red_cards,
                  NPG = npg,
                  NPxG = npxG,
                  xGChain,
                  xGBuildup)

    joined_df
}
