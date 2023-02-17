library(shiny)
library(tidyverse)
library(imola)
library(shinyWidgets)
library(highcharter)
library(stringr)
library(shinyjs)
library(reactable)
library(reactablefmtr)

#
# league_table <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2022',
#                                                      tier = '1st',
#                                                      stat_type = 'league_table')
# write.csv(x =  league_table,file = 'www/sql_data_base/league_table.csv')

library(scales)
colors1 <- alpha(c("#6CADDF", "#C8102E", "#034694", "#132257", "#EF0107",
           "#E03A3E", "#7A263A", "#0053A0", "#0057B8", "#FDB913",
           "#241F20", "#1B458F", "#F5A3C7", "#95BFE5", "#D71920",
           "#274488", "#FFCD00", "#6C1D45", "#FBEE23", "#00A650"),.5)




league_table_df <- read.csv(file = 'www/sql_data_base/league_table.csv')%>%
  arrange(Rk) %>%
  mutate(Rk_sizing = 20:1) %>%mutate(colors = colors1)

# league_away_home <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2022',
#                                                      tier = '1st',
#                                                      stat_type = 'league_table_home_away')
# write.csv(x = league_away_home,file = 'www/sql_data_base/league_away_home.csv')
league_away_home_df <- read.csv(file = 'www/sql_data_base/league_away_home.csv')%>%
  arrange(Rk) %>%
  mutate(Rk_sizing = 20:1)

# standard <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2022',
#                                                      tier = '1st',
#                                                      stat_type = 'standard')
# write.csv(x = standard,file = 'www/sql_data_base/standard.csv')
standard_df <- read.csv(file = 'www/sql_data_base/standard.csv')

standard_df <- standard_df[1:20,]
#
# passing <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2022',
#                                                      tier = '1st',
#                                                      stat_type = 'passing')
#
# write.csv(x = passing,file = 'www/sql_data_base/passing.csv')
passing_df <- read.csv(file = 'www/sql_data_base/passing.csv')


passing_types <-worldfootballR::fb_season_team_stats(country = 'ENG',
                                                     gender = "M",
                                                     season_end_year = '2022',
                                                     tier = '1st',
                                                     stat_type = 'passing_types')
#
# write.csv(x = passing_types,file = 'www/sql_data_base/passing_types.csv')


passing_types <- read.csv(file = 'www/sql_data_base/passing_types.csv')
