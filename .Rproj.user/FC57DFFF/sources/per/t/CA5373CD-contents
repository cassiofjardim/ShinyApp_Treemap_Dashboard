main_league_df <- read.csv(file = 'www/database_sql/main_league_df.csv')

data_csv_file <- read.csv(file = 'www/database_sql/main_league_df.csv')


standard_metrics <- c("xG" , "xGA", "xGD" , "xGD.90")
passing_metrics <- c("xAG","xA","A_minus_xAG","KP","Final_Third","PPA", "CrsPA",  "PrgP")
possession_metrics <- c("Touches_Touches","Def.Pen_Touches","Def.3rd_Touches",
                        "Mid.3rd_Touches","Att.3rd_Touches","Att.Pen_Touches","Live_Touches")
misc_metrics <- c("Mis_Carries", "Dis_Carries","Rec_Receiving","PrgR_Receiving")


metrics <- c('MP','Pts', 'W', 'L', 'Age','Gls', 'xG', 'xGA', 'Poss', 'Ast', 'xA',
             'KP','Cmp_percent_Total','Cmp_percent_Short', 'Cmp_percent_Medium',
             'Cmp_percent_Long', 'PPA',   'Top.Team.Scorer')

definition <- c('Games','Pts', 'Win', 'Lost', 'Average Age','Goals', 'Exp. Goals(xG)', 'Exp. Goals Against(xGA)',
                'Ball Poss.', 'Assists', 'Exp. Assist.(xA)', 'Key Passings','Completed Passes (%)',
                'Short Passings (%)', 'Medium Passings (%)', 'Long Passings (%)', 'Passings - Pen. Area','Top Team Scorer')


variables_vec <- c('xG_std','xGA_std', 'xGD.90_std', 'xG_Home_std', 'xG_Away_std',
                   'xG_Per_Minutes_std', 'Won_percent_Aerial_Duels')

vector_titles <- c('xG - Standardized', 'xGA - Standardized', 'xGD.90 - Standardized', 'xG_Home - Standardized',
                   'xG_Away - Standardized', 'xG Per. Minutes - Standardized', 'Aerials Duels Won (%)')

colors <- scales::alpha(c("#6CADDF", "#C8102E", "#034694", "#132257", "#EF0107",
                  "#E03A3E", "#7A263A", "#0053A0", "#0057B8", "#FDB913",
                  "#241F20", "#1B458F", "#F5A3C7", "#95BFE5", "#D71920",
                  "#274488", "#FFCD00", "#6C1D45", "#FBEE23", "#00A650"),.5)


