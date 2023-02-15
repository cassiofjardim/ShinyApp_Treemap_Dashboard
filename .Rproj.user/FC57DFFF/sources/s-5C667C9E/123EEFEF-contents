

source(file = 'www/R/sql_nivel_liga.R')



abaixo_acima_average <- league_table_df %>%
  mutate(G_xG = round(GF-xG,2),.after = 'xGD.90') %>%
  select(Season_End_Year,Squad:G_xG,colors)%>%

  mutate(GF_average = mean(GF),
         GA_average = mean(GA),
         xG_average = mean(xG),
         xGA_average = mean(xGA),
         xGD.90_average = round(mean(xGD.90),4),
         G_xG_average = mean(G_xG)) %>%

  mutate(GF_Acima_Abaixo = case_when(GF >= mean(GF) ~ 'Acima', TRUE ~'Abaixo'),
         GA_Acima_Abaixo = case_when(GA >= mean(GA) ~ 'Acima', TRUE ~'Abaixo'),
         xG_Acima_Abaixo = case_when(xG >= mean(xG) ~ 'Acima', TRUE ~'Abaixo'),
         xGA_Acima_Abaixo = case_when(xGA >= mean(xGA) ~ 'Acima', TRUE ~'Abaixo'),
         xGD.90_Acima_Abaixo = case_when(xGD.90 >= mean(xGD.90) ~ 'Acima', TRUE ~'Abaixo'),
         G_xG_Acima_Abaixo = case_when(G_xG >= mean(G_xG) ~ 'Acima', TRUE ~'Abaixo')
  )



standard_stats_df <- standard_df %>%
                    select(Squad:Poss,Gls:G_plus_A,PrgC_Progression:last_col()) %>%
  mutate(colors = colors1)


home_away_stats_df <- league_away_home_df %>% select(Competition_Name,Season_End_Year,Squad,Rk,
                               xG_Home,GF_Home,
                               xG_Away,GF_Away) %>% mutate(
                                 G_xG_Home = GF_Home - xG_Home,
                                 G_xG_Away = GF_Away - xG_Away) %>%
  mutate(colors = colors1)

