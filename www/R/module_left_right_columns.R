

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

          function_cards_tabsetpanel(
            title = 'Number of Goals - Expected Goals: Goals - xG',
            first_description_id = ns('xg_first_description'),
            card_number = 1,
            panel_title_1 = 'xG',
            panel_title_2 = 'xGA',
            panel_title_3 = 'xGD',
            panel_title_4 = 'G_xG',
            chart_id_1 = ns('xg_chart_1'),
            chart_id_2 = ns('xg_chart_2'),
            chart_id_3 = ns('xg_chart_3'),
            chart_id_4 = ns('xg_chart_4'),
            footer_description_id = ns('xg_footer_description')
          ),

          function_cards_tabsetpanel(
            title = 'Home and Away Metrics - Externals',
            first_description_id = ns('home_away_first_description'),
            card_number = 2,
            panel_title_1 = 'xG Home',
            panel_title_2 = 'xG Away',
            panel_title_3 = 'G_xG Home',
            panel_title_4 = 'G_xG Away',
            chart_id_1 = ns('home_away_chart_1'),
            chart_id_2 = ns('home_away_chart_2'),
            chart_id_3 = ns('home_away_chart_3'),
            chart_id_4 = ns('home_away_chart_4'),
            footer_description_id = ns('home_away_footer_description')
          ),


          function_cards_tabsetpanel(
            title = 'Standard Metrics',
            first_description_id = ns('standard_first_description'),
            card_number = 2,
            panel_title_1 = 'Goals',
            panel_title_2 = 'Assistances',
            panel_title_3 = 'Goals + Assistances',
            panel_title_4 = 'XG + xAG per Min.',
            chart_id_1 = ns('standard_chart_1'),
            chart_id_2 = ns('standard_chart_2'),
            chart_id_3 = ns('standard_chart_3'),
            chart_id_4 = ns('standard_chart_4'),
            footer_description_id = ns('standard_footer_description')
          ),

          function_cards_tabsetpanel(
            title = 'Progressions - Passing and Carries',
            first_description_id = ns('progression_first_description'),
            card_number = 2,
            panel_title_1 = 'Passing Progression',
            panel_title_2 = 'Carries Progression',
            panel_title_3 = ' -- ',
            panel_title_4 = ' --',
            chart_id_1 = ns('progression_chart_1'),
            chart_id_2 = ns('progression_chart_2'),
            chart_id_3 = ns('progression_chart_3'),
            chart_id_4 = ns('progression_chart_4'),
            footer_description_id = ns('progression_footer_description')
          )
          #********************************************************************************



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

#*******************************************************************************
#**** PErformance Chart ********************************************************
#*******************************************************************************

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


#********************************************************************************

  output[[paste0('xg_chart_', 1)]] <-
    renderHighchart({
      hchart(
        abaixo_acima_average,
        'column',

        hcaes(x = Squad,
              y = abaixo_acima_average$xG),
        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'xG') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'xG',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = unique(abaixo_acima_average$xG)
          )
        ),
        title = list(text = 'xG'))
    })

  output[[paste0('xg_chart_', 2)]] <-
    renderHighchart({
      hchart(
        abaixo_acima_average,
        'column',

        hcaes(x = Squad,
              y = abaixo_acima_average$xGA),
        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'xGA') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'xG',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = unique(abaixo_acima_average$xGA)
          )
        ),
        title = list(text = 'xGA'))
    })

  output[[paste0('xg_chart_', 3)]] <-
    renderHighchart({
      hchart(
        abaixo_acima_average,
        'column',

        hcaes(x = Squad,
              y = abaixo_acima_average$xGD),
        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'xGD') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'xG',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = unique(abaixo_acima_average$xGD)
          )
        ),
        title = list(text = 'xGD'))
    })

  output[[paste0('xg_chart_', 4)]] <-
    renderHighchart({
      hchart(
        abaixo_acima_average,
        'column',

        hcaes(x = Squad,
              y = abaixo_acima_average$G_xG),
        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'G_xG') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'xG',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = unique(abaixo_acima_average$G_xG)
          )
        ),
        title = list(text = 'G_xG'))
    })



  output$xg_first_description <- renderUI({
    div(
      class = 'metric_description description_1',
      p(
        glue::glue(
          "The difference between a team's number of goals and their expected
          goals (xG) can help to identify which teams are creating the best
          chances and whether they are finishing their chances effectively or not."
        )
      )
    )
  })

  # output$xg_footer_description <- renderUI({
  #   div(
  #     class = 'metric_description description_1',
  #     p(
  #       glue::glue(
  #         "The difference between a team's number of goals and their
  #          expected goals (xG) can help to identify which teams are
  #          creating the best chances and whether they are finishing
  #          their chances effectively or not. If a team has scored more
  #          goals than their xG suggests, it could indicate that the team
  #          is taking advantage of their chances better than expected
  #          and is likely to continue to score goals at a higher rate.
  #          On the other hand, if a team has scored fewer goals than their
  #          xG suggests, it could indicate that the team is not finishing
  #          their chances effectively and could be at risk of not scoring
  #          as many goals in the future."
  #       )
  #     )
  #   )
  # })



  # charts_card_1_function <- function(x,z) {
  #
  #    output[[paste0('goals_expected_', x)]] <-
  #     renderHighchart({
  #       hchart(
  #         abaixo_acima_average,
  #         'column',
  #
  #         hcaes(x = Squad,
  #               y = abaixo_acima_average[[z]]),
  #         colorByPoint = TRUE
  #       ) %>%
  #         charts_card_function(metric_name = 'xG') %>%
  #
  #         hc_yAxis(plotLines = list(
  #           list(
  #             color = 'red',
  #             width = 2,
  #             dashStyle = "shortdash",
  #             label = list(
  #               text = 'xG',
  #               verticalAlign = 'top',
  #               y = -120,
  #               x = -20,
  #               align = 'right'
  #             ),
  #             value = unique(abaixo_acima_average[[z]])
  #           )
  #         ),
  #         title = list(text = z))
  #     })
  # }
  #
  #   pmap(1:4,c('xG','xGA','xGD.90','G_xG'),
  #        ~ charts_card_1_function(x = .x, z = .y))
  output[[paste0('standard_chart_', 1)]] <-
    renderHighchart({
      hchart(
        standard_df,
        'column',

        hcaes(x = Squad,y = Gls),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'Goals') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'Goals',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = mean(standard_df$Gls)
          )
        ),
        title = list(text = 'Goals'))
    })



  output[[paste0('standard_chart_', 2)]] <-
    renderHighchart({
      hchart(
        standard_df,
        'column',

        hcaes(x = Squad,y = Ast),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'Assistance') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'Goals',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = mean(standard_df$Ast)
          )
        ),
        title = list(text = 'Assistance'))
    })


  output[[paste0('standard_chart_', 3)]] <-
    renderHighchart({
      hchart(
        standard_df,
        'column',

        hcaes(x = Squad,y = G_plus_A),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'Goals + Assistance') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'Goals + Assistance',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = mean(standard_df$G_plus_A)
          )
        ),
        title = list(text = 'Goals + Assistance'))
    })


  output[[paste0('standard_chart_', 4)]] <-
    renderHighchart({
      hchart(
        standard_df,
        'column',

        hcaes(x = Squad,y = xG_plus_xAG_Per_Minutes),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'xG + xAG') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'xG + xAG',
              verticalAlign = 'top',
              y = -120,
              x = -20,
              align = 'right'
            ),
            value = mean(standard_df$xG_plus_xAG_Per_Minutes)
          )
        ),
        title = list(text = 'xG + xAG'))
    })





  output$standard_first_description <- renderUI({
    div(
      class = 'metric_description description_1',
      p(
        glue::glue(
          "The difference between a team's number of goals and their expected
          goals (xG) can help to identify which teams are creating the best
          chances and whether they are finishing their chances effectively or not."
        )
      )
    )
  })

  # output$standard_footer_description <- renderUI({
  #   div(
  #     class = 'metric_description description_1',
  #     p(
  #       glue::glue(
  #         "The difference between a team's number of goals and their
  #          expected goals (xG) can help to identify which teams are
  #          creating the best chances and whether they are finishing
  #          their chances effectively or not. If a team has scored more
  #          goals than their xG suggests, it could indicate that the team
  #          is taking advantage of their chances better than expected
  #          and is likely to continue to score goals at a higher rate.
  #          On the other hand, if a team has scored fewer goals than their
  #          xG suggests, it could indicate that the team is not finishing
  #          their chances effectively and could be at risk of not scoring
  #          as many goals in the future."
  #       )
  #     )
  #   )
  # })

  output$progression_first_description <- renderUI({
    div(
      class = 'metric_description description_1',
      p(
        glue::glue(
          "The difference between a team's number of goals and their expected
          goals (xG) can help to identify which teams are creating the best
          chances and whether they are finishing their chances effectively or not."
        )
      )
    )
  })


  output$home_away_first_description <- renderUI({
    div(
      class = 'metric_description description_1',
      p(
        glue::glue(
          "The difference between a team's number of goals and their expected
          goals (xG) can help to identify which teams are creating the best
          chances and whether they are finishing their chances effectively or not."
        )
      )
    )
  })

  output[[paste0('home_away_chart_', 1)]] <-
    renderHighchart({
      hchart(
        home_away_stats_df,
        'column',

        hcaes(x = Squad,y = xG_Home),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'xG Home') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'xG Home',
              verticalAlign = 'top',
              y = -100,
              x = -20,
              align = 'right'
            ),
            value = mean(home_away_stats_df$xG_Home)
          )
        ),
        title = list(text = 'xG Home'))
    })


  output[[paste0('home_away_chart_', 2)]] <-
    renderHighchart({
      hchart(
        home_away_stats_df,
        'column',

        hcaes(x = Squad,y = xG_Away),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'xG Away') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'xG Away',
              verticalAlign = 'top',
              y = -100,
              x = -20,
              align = 'right'
            ),
            value = mean(home_away_stats_df$xG_Away)
          )
        ),
        title = list(text = 'xG Away'))
    })


  output[[paste0('home_away_chart_', 3)]] <-
    renderHighchart({
      hchart(
        home_away_stats_df,
        'column',

        hcaes(x = Squad,y = G_xG_Home),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'G - xG Home') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'G - xG Home',
              verticalAlign = 'top',
              y = -100,
              x = -20,
              align = 'right'
            ),
            value = mean(home_away_stats_df$G_xG_Home)
          )
        ),
        title = list(text = 'G - xG Home'))
    })


  output[[paste0('home_away_chart_', 4)]] <-
    renderHighchart({
      hchart(
        home_away_stats_df,
        'column',

        hcaes(x = Squad,y = G_xG_Away),

        colorByPoint = TRUE
      ) %>%
        charts_card_function(metric_name = 'G - xG Away') %>%

        hc_yAxis(plotLines = list(
          list(
            color = 'red',
            width = 2,
            dashStyle = "shortdash",
            label = list(
              text = 'G - xG Away',
              verticalAlign = 'top',
              y = -100,
              x = -20,
              align = 'right'
            ),
            value = mean(home_away_stats_df$G_xG_Away)
          )
        ),
        title = list(text = 'G - xG Away'))
    })







     })
}
