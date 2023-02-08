left_right_columns_UI <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      class = 'left_column',

      div(
        class = 'select_title',
        style = 'display: flex; justify-content: space-between; background: black;
    color: whitesmoke;padding: 0.85em 0.85em 0em 0.85em',
        selectInput(
          inputId = ns('custom_select'),
          width = '100px',
          label = 'Clubs',
          choices = unique(gapminder::gapminder$continent)
        ),

        htmlOutput(outputId = ns('countries'))
      ),
      highchartOutput(outputId = ns('chart_treemap'), height = 550)
    ),
#************************************************************************************

    div(
      class = 'right_column',

      div(
        class = 'top_overview_card',
        style = ' width: 100%;height: 100px',
        htmlOutput(outputId = ns('pop_country_text')),
        htmlOutput(outputId = ns('other_module'))

      ),

      div(
        class = 'overview_cards',
        style = 'display: flex; flex-wrap: wrap;  gap: 2em; padding-top:1em;',

#********************************************************************************
        div(
          class = 'cards_row_1',
          style = 'width: 100%;display: flex; gap: 2em; height: fit-content;',


          function_cards_overview(
            title = 'Population: 1953 - 2009',
            subtitle = 'Population',
            card_number = 1,
            chart_id = ns('div_chart'),
            description_id = ns('card_description_1')
          ),


          function_cards_overview(
            title = 'Life Expectancy: 1953 - 2009',
            subtitle = 'Life Expectancy',
            card_number = 2,
            chart_id = ns('traffic_chart'),
            description_id = ns('card_description_2')
          )
        ),
        #********************************************************************************
        div(
          class = 'cards_row_2',
          style = 'width: 100%;display: flex; gap: 2em; height: fit-content;',

          function_cards_overview(
            title = 'Gdp Percapita: 1953 - 2009',
            subtitle = 'Gdp Percapita ($)',
            card_number = 3,
            chart_id = ns('operational_chart'),
            description_id = ns('card_description_3')
          ),

          function_cards_overview(
            title = 'Uptime',
            subtitle = 'Uptime',
            card_number = 4,
            chart_id = ns('uptime_chart'),
            description_id = ns('card_description_4')
          )
        )

      )
    )

  )
}

left_right_columns_Server <- function(id) {
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
        rv$country <- input$treemapclick
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
        h1("Population Size:", str_remove_all(string = rv$country,
                               pattern = 'left_column'))

      })

      data_continent_only <- reactive({

        gapminder::gapminder %>%
          dplyr::filter(year  == 2007) %>%
          dplyr::filter(continent  == input$custom_select)

      })

      output$chart_treemap <- renderHighchart({
        data_continent_only() %>%

          highcharter::data_to_hierarchical(group_vars = c(continent, country),
                                            size_var = pop) %>%
          hchart(type = "treemap", colorByPoint = TRUE) %>%
          hc_plotOptions(treemap = list(events = list(click = click_js)))%>%
          hc_size(height = 550)
      })

      data_continent_country <- reactive({
        gapminder::gapminder %>%

          dplyr::filter(continent == input$custom_select, country ==  rv$country) %>%
          dplyr::select(year, country, pop, continent, lifeExp, gdpPercap)
       })

      output$pop_country_text <- renderUI({
        tagList(

         div(
           style = 'display: flex; justify-content: space-around; gap:1em;',
          h1(rv$country),
          tags$ul(
            class = 'country_info',
            tags$li(class = 'countries_list',paste0('Last Population Data:',' ',round(data_continent_country()$pop[12],0))),
            tags$li(class = 'countries_list',paste0('Last life Expectancy Data :',' ',round(data_continent_country()$lifeExp[12]),' (Years)')),
            tags$li(class = 'countries_list',paste0('Last GDP Percapita Data:',' $',round(data_continent_country()$gdpPercap[12],2)))
          )
          )

         )
      })



      output$div_chart <- renderHighchart({

        hchart(data_continent_country(),
               "bubble",

               name = rv$country,
               hcaes(x = year, y = pop, size = pop),
               colorByPoint = TRUE) %>%
            chart_treemap_dash(data = data_continent_country(), var = 'Population: ')
      })

      output$traffic_chart <- renderHighchart({

        hchart(data_continent_country(),
               "spline",


               hcaes(x = year, y = lifeExp, size = lifeExp),
               colorByPoint = TRUE)%>%
          # hc_size(height = 200) %>%
          chart_treemap_dash(data = data_continent_country(), var = 'Life Expectancy: ')


      })


      output$operational_chart <- renderHighchart({

        hchart(data_continent_country(),
               "column",

               hcaes(x = year, y = gdpPercap, size = gdpPercap),
               colorByPoint = TRUE) %>%
          # hc_size(height = 200) %>%
          chart_treemap_dash(data = data_continent_country(), var = 'GDP Percapita: ')


      })
      output$uptime_chart <- renderHighchart({


        hchart(data_continent_country(),
               "areaspline",


            backgroundColor = 'red',
               hcaes(x = year, y = pop, size = pop),
               colorByPoint = TRUE) %>%
          # hc_size(height = 200) %>%
          chart_treemap_dash(data = data_continent_country(), var = 'Comparision: ')


      })

      output$card_description_1 <- renderUI({

        div(class = 'metric_description description_1',
            p('Population', style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
              tags$img(class = 'svg_icon',src = 'img/population.svg',
                       width = '24px', height = '24px',
                       style = 'float: right;')),
            p(glue::glue('Na {rv$country} a população cresceu, em média, a uma taxa de {round(((round(data_continent_country()$pop[12],0)/round(data_continent_country()$pop[1],0))-1)*100,2)}%, nos ultimos 60 anos.
              Atualmente o tamanho da população é de {round(data_continent_country()$pop[12],0)} pessoas')))
      })

      output$card_description_2 <- renderUI({

        div(class = 'metric_description description_2',
            p('Life Expectancy', style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
              tags$img(class = 'svg_icon',src = 'img/life.svg',
                       width = '24px', height = '24px',
                       style = 'float: right;')),
            p(glue::glue('Na {rv$country} a Life Expectancy cresceu, em média, a uma taxa de {round(((round(data_continent_country()$lifeExp[12],0)/round(data_continent_country()$lifeExp[1],0))-1)*100,2)}%, nos ultimos 60 anos.
              Atualmente a Life Expectancy é de {round(data_continent_country()$lifeExp[12],0)} anos')))
      })
      output$card_description_3 <- renderUI({

        div(class = 'metric_description description_3',
            p('GDP Percapita', style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
              tags$img(class = 'svg_icon',src = 'img/gdp_percapita.svg',
                       width = '24px', height = '24px',
                       style = 'float: right;')),
            p(glue::glue('Na {rv$country} a GDP Percapita  cresceu, em média, a uma taxa de {round(((round(data_continent_country()$gdpPercap[12],0)/round(data_continent_country()$gdpPercap[1],0))-1)*100,2)}%, nos ultimos 60 anos.
              Atualmente a GDP Percapita é de $ {round(data_continent_country()$gdpPercap[12],0)} dólares')))
      })
      output$card_description_4 <- renderUI({

        div(class = 'metric_description description_4',
            p('Population', style = 'font-weight:400; font-family: "Roboto Condensed";font-size: 1.15em;"',
              tags$img(class = 'svg_icon',src = 'img/population.svg',
                       width = '24px', height = '24px',
                       style = 'float: right;')),
            p(glue::glue('A {rv$country} a GDP Percapita  cresceu, em média, a uma taxa de {round(((round(data_continent_country()$gdpPercap[12],0)/round(data_continent_country()$gdpPercap[1],0))-1)*100,2)}%, nos ultimos 60 anos.
              Atualmente a GDP Percapita é de {round(data_continent_country()$gdpPercap[12],0)} ($) dólares')))
      })


    }
  )
}
