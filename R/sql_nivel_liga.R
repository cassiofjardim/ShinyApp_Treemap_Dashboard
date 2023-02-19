library(shiny)
library(tidyverse)
library(imola)
library(shinyWidgets)
library(highcharter)
library(stringr)
library(shinyjs)
library(reactable)
library(reactablefmtr)
library(scales)
#
# league_table <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2020',
#                                                      tier = '1st',
#                                                      stat_type = 'league_table')
# write.csv(x =  league_table,file = 'www/database_sql/league_table.csv')





league_table_db <- read.csv(file = 'www/database_sql/league_table.csv',)%>%
  arrange(Rk) %>%
  mutate(Rk_sizing = 20:1)
# league_away_home <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2020',
#                                                      tier = '1st',
#                                                      stat_type = 'league_table_home_away')
# write.csv(x = league_away_home,file = 'www/database_sql/league_away_home.csv')
league_away_home_db <- read.csv(file = 'www/database_sql/league_away_home.csv')%>%
  arrange(Rk) %>%
  mutate(Rk_sizing = 20:1)

# standard <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2020',
#                                                      tier = '1st',
#                                                      stat_type = 'standard')
# write.csv(x = standard,file = 'www/database_sql/standard.csv')
standard_db <- read.csv(file = 'www/database_sql/standard.csv')

standard_db <- standard_db[1:20,]
#
# passing <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2020',
#                                                      tier = '1st',
#                                                      stat_type = 'passing')
#
# write.csv(x = passing,file = 'www/database_sql/passing.csv')
passing_db <- read.csv(file = 'www/database_sql/passing.csv')


# passing_types <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2020',
#                                                      tier = '1st',
#                                                      stat_type = 'passing_types')
#
# write.csv(x = passing_types,file = 'www/database_sql/passing_types.csv')


passing_types_db <- read.csv(file = 'www/database_sql/passing_types.csv')



# possession <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2022',
#                                                      tier = '1st',
#                                                      stat_type = 'possession')
#
# write.csv(x = possession,file = 'www/database_sql/possession.csv')


possession_db <- read.csv(file = 'www/database_sql/possession.csv')






# defense <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2020',
#                                                      tier = '1st',
#                                                      stat_type = 'defense')
#
# write.csv(x = defense,file = 'www/database_sql/defense.csv')


defense_db <- read.csv(file = 'www/database_sql/defense.csv')






