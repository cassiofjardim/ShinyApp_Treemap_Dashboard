
library(tidyverse)

first_var <- c("1","2","3","2","2","0","1","1","1","5")
second_var <- c("4","5","5","1","1","0","3","1","1","1")
#
# all_vars <- c(first_var,second_var)
#
# stock_market <- c("New York Stock Exchange","Nasdaq","Shanghai Stock Exchange",
#                   "Euronext","Shenzhen Stock Exchange","Japan Exchange Group",
#                   "Hong Kong Stock Exchange","Bombay Stock Exchange","National Stock Exchange",
#                   "London Stock Exchange","Saudi Stock Exchange (Tadawul)","Toronto Stock Exchange",
#                   "SIX Swiss Exchange","Deutsche Börse AG","Korea Exchange",
#                   "B3 Brasil Bolsa Balcão",
#                   "New York Stock Exchange","Nasdaq","Shanghai Stock Exchange",
#                   "Euronext","Shenzhen Stock Exchange","Japan Exchange Group",
#                   "Hong Kong Stock Exchange","Bombay Stock Exchange","National Stock Exchange",
#                   "London Stock Exchange")

teams <- league_table_db$Squad

away_teams <- sample(league_table_db$Squad)

df <-as.data.frame(teams,away_teams) %>%
        mutate(home = c(first_var,second_var), away =  c(second_var,first_var))%>%
        mutate(color = case_when(home > away ~ 'green', TRUE ~'red'))

marquee_df <- df %>% mutate(games = paste0(' - ',teams,' ',home,' x ',away,' ',away_teams)) %>% pull(games) %>% as.list()


# marquee_df <- tibble(names = matches_df, values = all_vars) %>% mutate(names = matches_df)
#
# marquee_df <- marquee_df %>%
#   mutate(cor_var = case_when(values < 0 ~ "#fe3c30", values >= 0 ~ "#30c759"))

# lista_marquee <- list()
#
# for (i in 1:nrow(marquee_df)) {
#
#   lista_marquee[[i]]  <- p(
#
#                            p(class = 'bolsa_name',
#
#                              str_to_upper(paste0(marquee_df[i]))),
#
#                            style = "color: white; display: flex;"
#
#                            # span(str_to_upper(paste0(' - ',marquee_df$values[i])),
#                            #      style = glue::glue("color: {marquee_df$cor_var[i]};
#                            #                      font-size: 2.25em;font-weight: 900;
#                            #                      margin: 0 1em !important;"))
#
#                            )
# }
#
# # div(class = "marquee-container",
# #     div(class = "marquee",
# #         lista_marquee,lista_marquee)
# # )
