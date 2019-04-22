## code to prepare `DATASET` dataset goes here

usethis::use_data("DATASET")

roxygen2::roxygenize()

usethis::use_pipe()

devtools::document()

# Prepare the "renert" data set
library("tidyverse")
library("tidytext")
library("janitor")

renert_link <- "https://download.data.public.lu/resources/the-works-in-luxembourguish-of-michel-rodange/20190414-150411/renert.txt"

renert_raw <- read_lines(renert_link)

(indices <- grepl("Gesank", renert_raw) %>% which(isTRUE(.)))

(indices2 <- c(indices[-1] - 1, length(renert_raw)))

song_lines <- map2(indices, indices2,  ~seq(.x,.y))

renert_songs <- map(song_lines, ~`[`(renert_raw, .))

is_empty_character <- function(char){
    if(char == "") TRUE else FALSE
}

renert <- renert_songs %>%
    map(., ~discard(., is_empty_character)) %>%
    map(tibble) %>%
    map(., ~rename(., line = `<chr>`)) %>%
    map(., ~mutate(., gesank = pull(.[1, 1]))) %>%
    map(., ~mutate(., gesank = str_remove_all(gesank, " Gesank."))) %>%
    map(., ~mutate(., gesank = tolower(gesank))) %>%
    bind_rows()


nb_lines <- nrow(renert)

nrow_id <- seq(1, nb_lines)

renert$nb_line <- nrow_id

renert <- renert %>%
    mutate(line = stringi::stri_escape_unicode(line),
           gesank = stringi::stri_escape_unicode(gesank))


usethis::use_data(renert, overwrite = TRUE)


sigfrid_link <- "https://download.data.public.lu/resources/the-works-in-luxembourguish-of-michel-rodange/20190414-150720/sigfrid.txt"

sigfrid_raw <- read_lines(sigfrid_link)

(indices_act <- grepl("ACT", sigfrid_raw) %>% which(isTRUE(.)))

(indices2_act <- c(indices_act[-1] - 1, length(sigfrid_raw)))

song_lines <- map2(indices_act, indices2_act,  ~seq(.x,.y))

sigfrid_songs <- map(song_lines, ~`[`(sigfrid_raw, .))


sigfrid <- sigfrid_songs %>%
    map(., ~discard(., is_empty_character)) %>%
    map(tibble) %>%
    map(., ~rename(., line = `<chr>`)) %>%
    map(., ~mutate(., act = pull(.[1, 1]))) %>%
    map(., ~mutate(., act = str_remove_all(act, " ACT"))) %>%
    map(., ~mutate(., act = str_remove_all(act, "\\."))) %>%
    map(., ~mutate(., act = tolower(act))) %>%
    bind_rows()

sigfrid_intro <- sigfrid_raw[1:16] %>%
    enframe(name = NULL) %>%
    rename(line = value) %>%
    mutate(act = "intro")

sigfrid <- bind_rows(sigfrid_intro, sigfrid)

nb_lines <- nrow(sigfrid)

nrow_id <- seq(1, nb_lines)

sigfrid$nb_line <- nrow_id

sigfrid <- sigfrid %>%
    mutate(line = stringi::stri_escape_unicode(line))

usethis::use_data(sigfrid, overwrite = TRUE)




dleierchen_link <- "https://download.data.public.lu/resources/the-works-in-luxembourguish-of-michel-rodange/20190414-194136/dleierchen.txt"

dleierchen_raw <- read_lines(dleierchen_link)

dleierchen <- dleierchen_raw %>% enframe(name = NULL) %>%
    rename(line = value)

nb_lines <- nrow(dleierchen)

nrow_id <- seq(1, nb_lines)

dleierchen$nb_line <- nrow_id

dleierchen <- dleierchen %>%
    mutate(line = stringi::stri_escape_unicode(line))


usethis::use_data(dleierchen, overwrite = TRUE)
