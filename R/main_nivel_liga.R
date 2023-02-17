source(file = 'R/sql_nivel_liga.R')
colors <- alpha(c("#6CADDF", "#C8102E", "#034694", "#132257", "#EF0107",
                  "#E03A3E", "#7A263A", "#0053A0", "#0057B8", "#FDB913",
                  "#241F20", "#1B458F", "#F5A3C7", "#95BFE5", "#D71920",
                  "#274488", "#FFCD00", "#6C1D45", "#FBEE23", "#00A650"),.5)

metrics <- c('xG', 'xGA', 'xGD', 'G_xG','Gls', 'Ast',
             'G_plus_A', 'xG_plus_xAG_Per_Minutes','xG_Home',
             'xG_Away', 'G_xG_Home', 'G_xG_Away')


teams <- league_table_db$Squad %>% as.list()
teams_positions <- sample(trunc(runif(n = 38,1,20),0))



teams_list <- list()
for(i in 1:20){

  teams_list[[i]] <- sample(trunc(runif(n = 38,1,20),0))

}


df_weeks_perforance <- teams_list %>%
  set_names(teams) %>%
  as.data.frame() %>%
  mutate(weeks = 1:38, .before = everything())%>% set_names('weeks',teams)

#********************************************************************************
league_table_df<- league_table_db %>% mutate(colors = colors) %>% mutate(G_xG = GF - xG)


#********************************************************************************
standard_stats_df<- standard_db%>%
                    select(Squad:Poss,Gls:G_plus_A,PrgC_Progression:last_col()) %>%
  mutate(colors = colors)

#********************************************************************************
home_away_stats_df<- league_away_home_db%>% select(Competition_Name,Season_End_Year,Squad,Rk,
                                                   xG_Home,GF_Home,xG_Away,GF_Away) %>% mutate(
                                                     G_xG_Home = GF_Home - xG_Home,
                                                     G_xG_Away = GF_Away - xG_Away) %>%  mutate(colors = colors)




#********************************************************************************

passing_df <- passing_db
passing_types_df <- passing_types_db


