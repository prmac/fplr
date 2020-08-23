palette_data <- readr::read_tsv("./data-raw/colours")
team_fills <- palette_data[["Fill"]]
team_colours <- palette_data[["Colour"]]
names(team_fills) <- names(team_colours) <- palette_data[["Team"]]
