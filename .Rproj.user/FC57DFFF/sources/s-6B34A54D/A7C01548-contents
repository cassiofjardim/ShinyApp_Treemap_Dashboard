left_column_UI <- function(id) {
  ns <- NS(id)
  tagList(

    div(
      class = 'treemap',

      selectInput(
        inputId = ns('custom_select'),
        width = '200px',
        label = 'Clubs',
        choices = unique(gapminder::gapminder$continent)
      ),

      highchartOutput(outputId = ns('chart_treemap')),

      div(class = 'forecasting_chart',
          style = '',
          # h5('Population Trend and Forecasting'),
          p('Modeling Time-Series Forecasting:'),
          htmlOutput(ns('countries')),
          tabsetPanel(
            tabPanel(
              title = 'Population - Forecasting',
              div(class = 'models_run_btn',
                  style = 'display: flex; justify-content: space-between;',

                  prettyRadioButtons(
                    inputId = ns("choose_models_pop"),
                    label = "Escolha seus Modelos:",
                    choices = c("XgBoost",
                                "Random Forest", "SVR", "ChatGPT"),
                    inline = TRUE
                  )),

              highchartOutput(outputId = ns('forecasting_pop'), height = 'fit-content')
            ),
            tabPanel(
              title = 'Life Expactancy - Forecasting',
              div(class = 'models_run_btn',
                  style = 'display: flex; justify-content: space-between;',

                  prettyRadioButtons(
                    inputId = ns("choose_models_life"),
                    label = "Escolha seus Modelos:",
                    choices = c("XgBoost",
                                "Random Forest", "SVR", "ChatGPT"),
                    inline = TRUE
                  )),

              highchartOutput(outputId = 'forecasting_life', height = 'fit-content')
            ),
            tabPanel(
              title = 'GDP Percapita - Forecasting',
              div(class = 'models_run_btn',
                  style = 'display: flex; justify-content: space-between;',

                  prettyRadioButtons(
                    inputId = ns("choose_models_gdp"),
                    label = "Escolha seus Modelos:",
                    choices = c("XgBoost",
                                "Random Forest", "SVR", "ChatGPT"),
                    inline = TRUE
                  )),

              highchartOutput(outputId = ns('forecasting_gdp'), height = 'fit-content')
            )
          )
      )
    )

  )
}

left_column_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      ns <- NS(id)

      click_js <-
        JS(
        glue::glue(
           "function(event) {{Shiny.setInputValue('{NS(id)('treemapclick')}', event.point.name);}}"
        )
      )


      rv <- reactiveValues(country = NULL)

      observe({
        rv$country <- ns(input$treemapclick)
      })

      observe(if (input$custom_select == 'Asia') {
        rv$country <- 'China'
      } else{
        if (input$custom_select == 'Europe') {
          rv$country <- 'Germany'
        } else{
          if (input$custom_select == 'Africa') {
            rv$country <- 'Egypt'


          } else{
            if (input$custom_select == 'Americas') {
              rv$country <- 'United States'

            } else{
              if (input$custom_select == 'Oceania') {
                rv$country <- 'Australia'

              }
            }

          }

        }

      })

      output$countries <- renderUI({
        h1("Machine Learning Forecasting for Population in ", str_remove_all(string = rv$country,
                                                                             pattern = 'left_column'))

      })

      output$chart_treemap <- renderHighchart({
        gapminder::gapminder %>%
          dplyr::filter(year  == 2007) %>%
          dplyr::filter(continent  == input$custom_select) %>%


          highcharter::data_to_hierarchical(group_vars = c(continent, country),

                                            size_var = pop) %>%
          hchart(type = "treemap", colorByPoint = TRUE) %>%
          hc_plotOptions(treemap = list(events = list(click = click_js)))
      })

#********************************************************************************
#********************************************************************************
#********************************************************************************

      gapminder_df <- reactive({
        gapminder::gapminder %>%
          dplyr::filter(continent == input$custom_select, country == rv$country) %>%
          dplyr::select(year, pop) %>%
          dplyr::bind_rows(data.frame(year = seq(2010, 2050, by = 5))) %>%
          dplyr::mutate(

            pop_model_1 = replace(pop, is.na(pop), sample(
              seq(pop[1], pop[12], 1000),
              size = sum(is.na(pop)),
              replace = TRUE
            )),

            pop_model_2 = replace(pop, is.na(pop), sample(
              seq(pop[1], pop[12], 1000),
              size = sum(is.na(pop)),
              replace = TRUE
            )),

            pop_model_3 = replace(pop, is.na(pop), sample(
              seq(pop[1], pop[12], 1000),
              size = sum(is.na(pop)),
              replace = TRUE
            )),

            pop_model_4 = replace(pop, is.na(pop), sample(
              seq(pop[1], pop[12], 1000),
              size = sum(is.na(pop)),
              replace = TRUE
            ))

          )
      })


      output$forecasting_pop <- renderHighchart({


        if (input$choose_models_pop == 'XgBoost') {

          hchart(
            gapminder_df(),
            "spline",
            hcaes(x = year, y = pop_model_1, size = pop_model_1),
            colorByPoint = TRUE,
          ) %>% chart_forecasting_function(data = gapminder_df(),
                                           model = input$choose_models_pop)

        } else{
          if (input$choose_models_pop == 'Random Forest') {

            hchart(
              gapminder_df(),
              "spline",
              hcaes(x = year, y = pop_model_2, size = pop_model_2),

              colorByPoint = TRUE
            ) %>% chart_forecasting_function(data = gapminder_df(),
                                             model = input$choose_models_pop)

          } else{
            if (input$choose_models_pop == 'SVR') {
              hchart(
                gapminder_df(),
                "spline",
                hcaes(
                  x = year,
                  y = pop_model_3,
                  size = pop_model_3
                ),
                colorByPoint = TRUE
              ) %>% chart_forecasting_function(data = gapminder_df(),
                                               model = input$choose_models_pop)

            } else{
              if (input$choose_models_pop == 'ChatGPT') {
                hchart(
                  gapminder_df(),
                  "spline",
                  hcaes(
                    x = year,
                    y = pop_model_4,
                    size = pop_model_4
                  ),
                  colorByPoint = TRUE
                ) %>% chart_forecasting_function(data = gapminder_df(),
                                                 model = input$choose_models_pop)

              } else{

              }
            }
          }
        }

      })

    }
  )
}
