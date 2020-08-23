palette_data <- readr::read_tsv("./data-raw/colours.tsv")
team_fills <- palette_data[["Fill"]]
team_colours <- palette_data[["Colour"]]
names(team_fills) <- names(team_colours) <- palette_data[["Team"]]

# usethis::use_data(team_fills)
# usethis::use_data(team_colours)
