

left_right_columns_UI <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      class = 'left_column',

      div(
        class = 'select_title',
        selectInput(
          inputId = ns('custom_select'),
          width = '100px',
          label = 'Clubs',
          choices = unique(gapminder::gapminder$continent)
        ),


        htmlOutput(outputId = ns('countries')),

        tags$img(
          class = 'svg_icon clickable',
          src = 'img/click_event.svg',
          width = '20px',
          height = '20px'
        )

      ),
      highchartOutput(outputId = ns('chart_treemap'), height = 550),

      h1('Premiere League - Season 2021'),

      p('In publishing and graphic design, Lorem ipsum is a placeholder text commonly
      used to demonstrate the visual form of a document or a typeface without relying on meaningful content.
        Lorem ipsum may be used as a placeholder before final copy is available.'),

      reactableOutput(outputId = ns('downloadable_table')),
      csvDownloadButton(ns("downloadable_table"), filename = "continent_countries_table.csv")

    ),
#************************************************************************************
div(
  class = 'right_column',

  div(
    class = 'top_overview_card',
    style = ' width: 100%;',
    htmlOutput(outputId = ns('teams_introduction')),
    highchartOutput(outputId = ns('season_performance_chart'), height = 200)

  ),
  tabsetPanel(
    tabPanel(
      title = tags$img('Main Stats Panel',src = 'img/clubs.png',
                       width = '24px', height = '24px',
                       style = 'border-radius: 50%;'),
        div(
          class = 'overview_cards',
          #********************************************************************************

          function_cards_overview(
            title = 'Teams Main Stats',
            subtitle = 'Teams Most Importants Stats',
            card_number = 1,
            chart_id = ns('main_stats'),
            description_id = ns('card_description_1')
          ),


          function_cards_overview(
            title = 'Expected Goals - Above and Bellow Average',
            subtitle = 'Expected Goals',
            card_number = 2,
            chart_id = ns('expected_goals'),
            description_id = ns('card_description_2')
          ),
          # ),
          #********************************************************************************

          function_cards_overview(
            title = 'Number of Goals - Expected Goals: Goals - xG',
            subtitle = 'Gols',
            card_number = 3,
            chart_id = ns('goals_expected_goals'),
            description_id = ns('card_description_3')
          ),

          function_cards_overview(
            title = '90 Minutes Stistics',
            subtitle = 'Uptime',
            card_number = 4,
            chart_id = ns('passes_assistances'),
            description_id = ns('card_description_4')
          )

        )
      ),

      tabPanel(
        title = tags$img('Team Level',src = 'img/clubs.png',
                         width = '24px', height = '24px',
                         style = 'border-radius: 50%;')
      )
  )))






}

left_right_columns_Server <- function(id) {
  moduleServer(id,
               function(input, output, session) {
                 ns <- NS(id)

                 league_table <- reactive({ league_table_df })

                 standard_table <- reactive({ standard_stats_df})



                 click_js <-
                   JS(
                     glue::glue(
                       "function(event) {{Shiny.setInputValue('{NS(id)('treemapclick')}', event.point.name);}}"
                     )
                   )


                 rv <- reactiveValues(country = NULL)

                 observe({
                   rv$country <- input$treemapclick
                 })

                 observe(
                   rv$country <- 'Manchester City'
                 )

                 output$countries <- renderUI({
                   h1(
                     "Premiere League: ",
                     str_remove_all(string = rv$country,
                                    pattern = 'left_column')
                   )

                 })

                 output$chart_treemap <- renderHighchart({
                   league_table() %>%
                     highcharter::data_to_hierarchical(group_vars = c(Squad),
                                                       size_var = Rk_sizing) %>%
                     hchart(type = "treemap",

                            layoutStartingDirection = 'left',
                            colorByPoint = TRUE,

                            inverted = TRUE) %>%
                     hc_plotOptions(

                       treemap = list(

                         marker = list(
                           symbol = 'url(https://www.highcharts.com/samples/graphics/sun.png)'
                         ),

                         dataLabels= list(
                           enabled= TRUE,
                           align= 'center',
                           verticalAlign= 'top',
                           style= list(
                             fontSize= '15px',
                             fontWeight= 'bold'
                           )
                         ),
                        events = list(click = click_js)

                       )
                     ) %>%

                     hc_tooltip(
                       headerFormat = glue::glue('
                            <strong, style = "font-size: 20px;">
                              Ranking Position:
                            </strong>
                            <br/>
                            <img, src = "img/dashboard.svg">'),
                       pointFormat = paste0(" {point.y:,.0f}"))

                 })

                 output$downloadable_table <- renderReactable({

                   table_style(dataframe = league_table() %>%
                                 select(-Rk_sizing,-X,-Competition_Name,-Gender,
                                        -Country,-Attendance,-Top.Team.Scorer,
                                        -Goalkeeper,-Notes,-Team_or_Opponent)%>%
                                 relocate(Rk,Squad,.before = everything()),
                               height = 'auto',fontsize = '12px',
                               cellPadding = '0px')

                 })
              #
                 output$teams_introduction <- renderUI({
                   tagList(
                     div(
                       class = 'top_card',
                       style = 'display: flex;
                                justify-content: space-around;
                                gap:1em;',
                       h1(rv$country, style = 'font-weight: 900; font-size: 3em;'),
                       tags$img(
                         class = 'top_card_icon',
                         src = paste0('img/2021/', rv$country, '.png')
                       ),

                       tags$ul(
                         class = 'clubs_stats_info',
                         tags$li(class = 'teams_list',
                                 tags$span(
                                   class = 'stats',
                                   paste0(
                                     'Posição:',
                                     ' ',
                                     league_table() %>% filter(Squad == rv$country) %>% pull(Rk),
                                     'º'
                                   )
                                 )),
                         tags$li(class = 'teams_list',
                                 tags$span(
                                   class = 'stats',
                                   paste0(
                                     'Vitórias:',
                                     ' ',
                                     league_table() %>% filter(Squad == rv$country) %>% pull(W)
                                   )
                                 )),
                         tags$li(class = 'teams_list',
                                 tags$span(
                                   class = 'stats',
                                   paste0(
                                     'Pontos:',
                                     ' ',
                                     league_table() %>% filter(Squad == rv$country) %>% pull(Pts)
                                   )
                                 ))
                       )
                     )
                   )
                 })



                 output$season_performance_chart <- renderHighchart({
                   hchart(
                     stats_league_table_df %>% filter(Squad == rv$country),
                     'spline',
                     hcaes(
                       x = Metrics,
                       y = Metrics_Values
                     ),
                     colorByPoint = TRUE
                   ) %>%
                     charts_card_function(metric_name = 'xG') %>%
                     hc_yAxis(title = list(text = "Week Ranking",
                                           style = list(color = 'whitesmoke')),
                              labels = list(
                                style = list(color =  'whitesmoke',
                                             fontSize = '12px',
                                             fontWeight = 'bold',
                                             fontFamily = "Roboto Condensed")
                              ),
                              tickAmount = 6,
                              gridLineWidth = 0.5,
                              gridLineColor = 'gray',
                              gridLineDashStyle = "longdash")%>%
                     hc_xAxis(title = list(text = "",
                                           style = list(color = 'whitesmoke')),
                              labels = list(


                                style = list(color =  'whitesmoke',
                                             fontWeight = 'bold',
                                             fontSize = '12px',
                                             fontFamily = "Roboto Condensed")
                              )
                     )
                 })




#*********** CARDS: Adicionando Gráficos + Texto ******************************
#*********** CARDS: Adicionando Gráficos + Texto ******************************
#*********** CARDS: Adicionando Gráficos + Texto ******************************


                 output$main_stats <- renderHighchart({
                   hchart(
                     stats_league_table_df %>% filter(Squad == rv$country),
                     'column',
                     hcaes(
                       x = Metrics,
                       y = Metrics_Values
                     ),
                     colorByPoint = TRUE
                   ) %>%
                     charts_card_function(metric_name = 'xG') %>%
                     hc_yAxis(title = list(text = "Metrics"))
                 })



                 output$card_description_1 <- renderUI({
                   div(
                     class = 'metric_description description_1',
                     p(
                       paste0(rv$country, ' - Destaques'),
                       style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
                       tags$img(
                         class = 'svg_icon',
                         src = 'img/population.svg',
                         width = '24px',
                         height = '24px',
                         style = 'float: right;'
                       )
                     ),
                     p(
                       glue::glue(
                         'A Equipe {rv$country} na Temporada {unique(league_table()$Season_End_Year)}
                         ficando na posição {abaixo_acima_average %>% filter(Squad == rv$country) %>% pull(Rk)}
                         com o total de {abaixo_acima_average %>% filter(Squad == rv$country) %>% pull(Pts)} e
                         Gols Esperados (xG) de {abaixo_acima_average %>% filter(Squad == rv$country) %>% pull(xG)}.
                         Vale ressaltar que a Equipe {rv$country} obteve um valor
                         {abaixo_acima_average %>% filter(Squad == rv$country) %>% pull(xG_Acima_Abaixo)} da média
                         para a métrica Expected Goals do Campeonato.

                         '
                       )
                     )
                   )
                 })
#********************************************************************************
                 output$expected_goals <- renderHighchart({
                   hchart(
                     league_table() ,
                     'bubble',

                     hcaes(x = Squad,
                           y = xG,
                           size = xG),
                     colorByPoint = TRUE
                   ) %>%
                     charts_card_function(metric_name = 'Expected Goals: ') %>%

                     hc_yAxis(plotLines = list(
                       list(
                         color = 'red',
                         width = 2,
                         dashStyle = "shortdash",
                         label = list(text = 'Average(xG)'),
                         value = unique(abaixo_acima_average$xG_average)
                       )
                     ),
                     title = list(text = 'Expected Goals')
                     )
                 })

                 output$card_description_2 <- renderUI({
                   div(
                     class = 'metric_description description_2',
                     p(
                       'Expected Goals',
                       style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
                       tags$img(
                         class = 'svg_icon',
                         src = 'img/life.svg',
                         width = '24px',
                         height = '24px',
                         style = 'float: right;'
                       )
                     ),
                     p(
                       glue::glue(
                         "Expected goals (xG) is an analytical tool used to measure the
                         quality of a team's scoring chances. It is important because
                         it provides a more accurate measure of a team's attacking
                         performance than simply looking at the number of goals scored.
                         By looking at the xG of a team, analysts can better identify
                         which teams are creating the best chances and are likely to
                         score more goals in the future."
                       )
                     )
                   )
                 })
#********************************************************************************

                 output$goals_expected_goals <- renderHighchart({
                   hchart(
                     abaixo_acima_average ,
                     'column',

                     hcaes(x = Squad,
                           y = G_xG),
                     colorByPoint = TRUE
                   ) %>%
                     charts_card_function(metric_name = 'Goals - xG: ') %>%

                     hc_yAxis(plotLines = list(
                       list(
                         color = 'red',
                         width = 2,
                         dashStyle = "shortdash",
                         label = list(text = 'Average(Goals - xG)',
                                      # verticalAlign = 'top',
                                      align = 'right'),
                         value = unique(abaixo_acima_average$G_xG_average)
                       )
                     ),
                     title = list(text = 'Goals - xG'))
                 })


                 output$card_description_3 <- renderUI({
                   div(
                     class = 'metric_description description_3',
                     p(
                       'Nº Goals and Expected Goals: Goals - xG',
                       style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
                       tags$img(
                         class = 'svg_icon',
                         src = 'img/goal.png',
                         width = '24px',
                         height = '24px',
                         style = 'float: right;'
                       )
                     ),
                     p(
                       glue::glue(
                         "The difference between a team's number of goals and their
                         expected goals (xG) can help to identify which teams are
                         creating the best chances and whether they are finishing
                         their chances effectively or not. If a team has scored more
                         goals than their xG suggests, it could indicate that the team
                         is taking advantage of their chances better than expected
                         and is likely to continue to score goals at a higher rate.
                         On the other hand, if a team has scored fewer goals than their
                         xG suggests, it could indicate that the team is not finishing
                         their chances effectively and could be at risk of not scoring
                         as many goals in the future."
                       )
                     )
                   )
                 })

#*******************************************************************************
                 output$passes_assistances <- renderHighchart({
                   hchart(standard_stats_df %>% filter(Team_or_Opponent == 'team'),
                          'bubble',
                          name = '',

                          hcaes(x = Squad,
                                y = PrgC_Progression,
                                size = PrgC_Progression),
                          colorByPoint = TRUE) %>%
                     charts_card_function(metric_name = 'Prog. Carries')


                 })

                 output$card_description_4 <- renderUI({
                   div(
                     class = 'metric_description description_4',
                     p(
                       'Passes x Assistances:',
                       style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
                       tags$img(
                         class = 'svg_icon',
                         src = 'img/population.svg',
                         width = '24px',
                         height = '24px',
                         style = 'float: right;'
                       )
                     ),
                     p(
                       glue::glue(
                         "Considering statistics per 90 minutes for a team's performance
                         is important because it allows analysts to better compare a team's
                         performance over a given period of time. By looking at a team's
                         performance per 90 minutes, analysts can more accurately
                         compare a team's performance regardless of whether they have
                         played more or fewer games than their opponents.
                         This metric also allows analysts to adjust for any
                         external factors that may affect a team's performance,
                         such as injuries or suspensions, since the analysis is
                         based on the team's performance over a given period of time, not a single game.
                         "
                       )
                     )
                   )
                 })



               })
}
