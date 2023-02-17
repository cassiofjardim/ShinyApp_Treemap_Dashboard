#
#
# man_city_2021_url <- "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats"
# man_city_2021_results <-worldfootballR::fb_team_match_results(man_city_2021_url)
# dplyr::glimpse(man_city_2021_results)
#
# man_city_2021_results %>% head()
#
#
# man_city_url <- "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats"
# man_city_logs <- worldfootballR::fb_team_match_log_stats(team_urls = man_city_url, stat_type = "passing")
# man_city_logs <- worldfootballR::fb_team_match_log_stats(team_urls = man_city_url, stat_type = "passing_types")
# man_city_logs <- worldfootballR::fb_team_match_log_stats(team_urls = man_city_url, stat_type = "defense")
# man_city_logs <- worldfootballR::fb_team_match_log_stats(team_urls = man_city_url, stat_type = "shooting")
#
# man_city_logs %>% filter(Comp == 'Premier League') %>% select(GF:last_col())
