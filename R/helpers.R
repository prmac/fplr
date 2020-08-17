fix_names <- function(x) {
  x %>%
    stringi::stri_trans_general("Latin-ASCII") %>%
    stringr::str_replace("&#039;", "'")
}

standardise_name <- function(x) {
  stringr::str_replace_all(x, " ", "") %>%
    tolower()
}
