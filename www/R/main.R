


stats_league_table_df <- league_table_df %>%   mutate(G_xG = round(GF-xG,2))%>%
  dplyr::select(Competition_Name,Season_End_Year,Squad,
                Rk,-Rk_sizing,W,Pts,GF,xG,xGA,xGD,xGD.90,G_xG) %>%
  mutate(across(Rk:last_col(), ~ as.character(.x))) %>%
  pivot_longer(cols = Rk:last_col(),
               names_to = 'Metrics',
               values_to = 'Metrics_Values') %>%
  mutate(Metrics_Values = round(as.integer(Metrics_Values),4))


abaixo_acima_average <- league_table_df %>%
  mutate(G_xG = round(GF-xG,2),.after = 'xGD.90') %>%
  select(Season_End_Year,Squad:G_xG)%>%

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



standard_stats_df <- standard_df %>% select(Squad:Poss,Gls:G_plus_A,PrgC_Progression:last_col())
