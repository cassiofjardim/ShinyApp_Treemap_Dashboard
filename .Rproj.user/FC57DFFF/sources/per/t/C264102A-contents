source('R/metrics_to_choose.R')

main_league_df <- main_league_df %>% mutate(Cores = colors)


csvDownloadButton <- function(id, filename = "data.csv", label = "Download as CSV") {
  tags$button(
    tagList(icon("download"), label),
    onclick = sprintf("Reactable.downloadDataCSV('%s', '%s')", id, filename)
  )
}



left_right_columns_UI <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      class = 'left_column',

      div(
        class = 'select_title',
        selectInput(
          inputId = ns('choice_season'),
          width = '100px',
          label = 'Seasons',
          choices = c('2019', '2020', '2021')
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

      p(
        'In publishing and graphic design, Lorem ipsum is a placeholder text commonly
      used to demonstrate the visual form of a document or a typeface without relying on meaningful content.
        Lorem ipsum may be used as a placeholder before final copy is available.'
      ),

      reactableOutput(outputId = ns('downloadable_table')),
      csvDownloadButton(ns("downloadable_table"), filename = "continent_countries_table.csv")

    ),
    #************************************************************************************
    div(
      class = 'right_column',

      div(
        class = 'top_overview_card',
        style = ' width: 100%;height: 150px;',
        htmlOutput(outputId = ns('teams_introduction')),
        highchartOutput(
          outputId = ns('season_performance_chart')
        ),
        htmlOutput(outputId = ns('performance_description')),

      ),
      tabsetPanel(id = 'right_panels',

        tabPanel(
          title = tags$img(
            'Main Stats Panel',
            src = 'img/clubs.png',
            width = '24px',
            height = '24px',
            style = 'border-radius: 50%;'
          ),
          div(class = 'overview_cards',
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
            card_number = 3,
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
            card_number = 4,
            panel_title_1 = 'Passing Progression',
            panel_title_2 = 'Carries Progression',
            panel_title_3 = ' -- ',
            panel_title_4 = ' --',
            chart_id_1 = ns('progression_chart_1'),
            chart_id_2 = ns('progression_chart_2'),
            chart_id_3 = ns('progression_chart_3'),
            chart_id_4 = ns('progression_chart_4'),
            footer_description_id = ns('progression_footer_description')
          ),

          function_cards_tabsetpanel(
            title = 'Metrics 5- Type of Metrics',
            first_description_id = ns('five_first_description'),
            card_number = 5,
            panel_title_1 = 'Metrics 5 - M1',
            panel_title_2 = 'Metrics 5 - M2',
            panel_title_3 = 'Metrics 5 - M3',
            panel_title_4 = 'Metrics 5 - M4',
            chart_id_1 = ns('chart_5_chart_1'),
            chart_id_2 = ns('chart_5_chart_2'),
            chart_id_3 = ns('chart_5_chart_3'),
            chart_id_4 = ns('chart_5_chart_4'),
            footer_description_id = ns('five_footer_description')
          ),

          function_cards_tabsetpanel(
            title = 'Metrics 6 - Type of Metrics',
            first_description_id = ns('six_first_description'),
            card_number = 6,
            panel_title_1 = 'Metrics 6 - M1',
            panel_title_2 = 'Metrics 6 - M2',
            panel_title_3 = 'Metrics 6 - M3',
            panel_title_4 = 'Metrics 6 - M4',
            chart_id_1 = ns('chart_6_chart_1'),
            chart_id_2 = ns('chart_6_chart_2'),
            chart_id_3 = ns('chart_6_chart_3'),
            chart_id_4 = ns('chart_6_chart_4'),
            footer_description_id = ns('six_footer_description')
          )
          #********************************************************************************



        )
      ))
    )
  )






}

left_right_columns_Server <- function(id) {
  moduleServer(id,
               function(input, output, session) {
                 ns <- NS(id)

                 league_table <- reactive({
                   main_league_df %>% select(Rk,Squad,Cores) %>% mutate(Rk_sizing = Rk) %>%
                     mutate(Squad_Tooltip = paste0(Squad,' - ',Rk))
                 })

                 standard_table <- reactive({
                   # standard_stats_df
                 })

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

                 observe(rv$country <- 'Manchester City')

                 output$countries <- renderUI({
                   h1(
                     "Premiere League: ",
                     str_remove_all(string = rv$country,
                                    pattern = 'left_column')
                   )

                 })

                 output$chart_treemap <- renderHighchart({
                   league_table()%>%
                     highcharter::data_to_hierarchical(group_vars = c(Rk, Squad),
                                                       size_var = Rk_sizing /
                                                         2) %>%

                     treemap_chart_function(slices_colors = league_table()$Cores,
                                            click_event = click_js)

                 })

                 output$downloadable_table <- renderReactable({


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
                         src = paste0('img/2020/', rv$country, '.png')
                       )
                     )
                   )
                 })

#*******************************************************************************
#**** Performance Chart ********************************************************
#*******************************************************************************
                 output$season_performance_chart <-
                   renderHighchart({

                   })





               })
}
