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
#                                                      season_end_year = '2021',
#                                                      tier = '1st',
#                                                      stat_type = 'league_table')
# write.csv(x =  league_table,file = 'www/sql_data_base/league_table.csv')
league_table_df <- read.csv(file = 'www/sql_data_base/league_table.csv')%>%
  arrange(Rk) %>%
  mutate(Rk_sizing = 20:1)

# league_away_home <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2021',
#                                                      tier = '1st',
#                                                      stat_type = 'league_table_home_away')
# write.csv(x = league_away_home,file = 'www/sql_data_base/league_away_home.csv')
league_away_home_df <- read.csv(file = 'www/sql_data_base/league_away_home.csv')%>%
  arrange(Rk) %>%
  mutate(Rk_sizing = 20:1)

# standard <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2021',
#                                                      tier = '1st',
#                                                      stat_type = 'standard')
# write.csv(x = standard,file = 'www/sql_data_base/standard.csv')
standard_df <- read.csv(file = 'www/sql_data_base/standard.csv')

# overview_card <-worldfootballR::fb_season_team_stats(country = 'ENG',
#                                                      gender = "M",
#                                                      season_end_year = '2022',
#                                                      tier = '1st',
#                                                      stat_type = 'possession')






#   df_league_table %>%
#
#     highcharter::data_to_hierarchical(group_vars = c(Squad),
#                                       size_var = Rk_sizing) %>%
#     hchart(type = "treemap",
#            # layoutAlgorithm= 'stripes',
#            layoutStartingDirection = 'left',
#
#            colorByPoint = TRUE,
#
#            inverted = TRUE) %>%
#     hc_plotOptions(
#
#         treemap = list(
#
#          marker = list(
#             symbol = 'url(https://www.highcharts.com/samples/graphics/sun.png)'
#          ),
#
#         dataLabels= list(
#           enabled= TRUE,
#           align= 'center',
#           verticalAlign= 'top',
#           style= list(
#             fontSize= '15px',
#             fontWeight= 'bold'
#           )
#         )
#
#         )
#   ) %>%
#
#
#
# hc_tooltip(
#   headerFormat = glue::glue('
#                             <strong, style = "font-size: 20px;">
#                               Ranking Position:
#                             </strong>
#                             <br/>
#                             <img, src = "img/dashboard.svg">'),
#   pointFormat = paste0(" {point.y:,.0f}"))
