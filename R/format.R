format_fpl <- function(x, ...) {
  .format_fpl(x)
}

.format_fpl <- function(x, ...) UseMethod(".format_fpl")

#' @export
.format_fpl.elements <- function(x, ...) {
  x[["data"]] %>%
    dplyr::mutate(Price = now_cost/10,
                  Name = stringr::str_c(first_name, second_name, sep = " "),
                  Name = fix_names(Name),
                  web_name = fix_names(web_name),
                  Form = as.numeric(form),
                  Selected_by = as.numeric(selected_by_percent),
                  PPG = as.numeric(points_per_game),
                  value_form = as.numeric(value_form),
                  value_season = as.numeric(value_season)) %>%
    dplyr::select(
                Name, element_type, Form, Price,
                Selected_by, team, total_points, transfers_in,
                transfers_out, value_form, value_season, web_name, minutes,
                bonus, PPG)
}

#' @export
.format_fpl.element_types <- function(x, ...) {
  x[["data"]] %>%
    dplyr::select(element_type = id,
                  Position = singular_name)
}

#' @export
.format_fpl.teams <- function(x, ...) {
  x[["data"]] %>%
    dplyr::select(team = id,
                  Team = name)
}

collate_fpl_data <- function(data = get_bootstrap()) {
  teams <- format_fpl(extract_table(data, table = "teams"))
  positions <- format_fpl(extract_table(data, table = "element_types"))
  players <- format_fpl(extract_table(data, table = "elements"))

    dplyr::left_join(players, teams, by = "team") %>%
      dplyr::left_join(positions, by = "element_type") %>%
      dplyr::select(Name, Team, Position, Price,
                    Points = total_points,
                    PPG,
                    Bonus = bonus,
                    Form,
                    Season_value = value_season,
                    Form_value = value_form,
                    Selected_by,
                    In = transfers_in,
                    Out = transfers_out,
                    web_name,
                    Minutes= minutes)
}
