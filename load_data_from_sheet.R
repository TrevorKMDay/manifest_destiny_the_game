library(tidyverse)
library(googlesheets4)

ss <- "1p_zYjtf95LX6VC2XflP6vOm8VUFS80eE53CN-OmdsMM"

players_alph <- c("Dan", "Eli", "John", "Rohin", "Tim", "Trevor")

col_names <- c("date", "map_yn", "log_yn", "id", "action", "success",
                "team", "state", "region", "area_sqmi", "locked_yn",
                "skip1", paste0("calc_", players_alph),
                "score_date",
                "skip2", "rank_Dan", "score_Dan", "rank_Eli", "score_Eli",
                "rank_John", "score_John", "rank_Rohin", "score_Rohin",
                "rank_Tim", "score_Tim", "rank_Trevor", "score_Trevor",
                "skip3", paste0("states_", players_alph), "states_total",
                "skip4", paste0("regions_", players_alph),
                "skip5", paste0("area_", players_alph),
                "skip6", paste0("arank_", players_alph), "arank_last",
                "skip7", paste0("b_", players_alph))

EL0 <- read_sheet(ss, sheet = "Event Log", skip = 3, col_names = col_names)
CL0 <- read_sheet(ss, sheet = "Challenge Log", range = "A3:M")

events <- EL0 %>%
    select(-ends_with("_yn"), -starts_with("skip"), -starts_with("calc"),
            -score_date) %>%
    filter(
        !is.na(date)
    )
