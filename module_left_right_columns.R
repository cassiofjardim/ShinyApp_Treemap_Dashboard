left_right_columns_UI <- function(id) {
  ns <- NS(id)
  tagList(

    div(
      class = 'left_column',

      div(
        class = 'select_title',
        style = 'display: flex; justify-content: space-between; background: black;
    color: whitesmoke; padding: 0.85em;',
        selectInput(
          inputId = ns('custom_select'),
          width = '200px',
          label = 'Clubs',
          choices = unique(gapminder::gapminder$continent)
        ),

        htmlOutput(outputId = ns('countries'))
      ),
      highchartOutput(outputId = ns('chart_treemap'), height = 550)
    ),

#************************************************************************************
#************************************************************************************
#************************************************************************************
#************************************************************************************

div(
  class = 'right_column',

  div(class = 'top_overview_card',
      style = ' width: 100%;height: 100px',
      htmlOutput(outputId = ns('pop_country_text')),
      htmlOutput(outputId = ns('other_module'))

  ),

  div(class = 'overview_cards',
      style = 'display: flex; flex-wrap: wrap;  gap: 2em; padding-top:1em;',

      #********************************************************************************
      div(class = 'cards_row_1',
          style = 'width: 100%;display: flex; gap: 2em; height: fit-content;',

          div(class = 'overview_card_1',
              style = 'grid-area: top1; height: fit-content;width: 300px;',
              div(class = 'title_toggle_1',
                  style = 'display: flex; flex-direction: column',
                  h5('Daily Visitor Trend'),
                  h6('Network Traffic - Last 24 Hours', style = 'font-weight: 700;padding: 0 .25em;')
                  # materialSwitch(inputId = ns("checkbox_1"))
                  ),

              highchartOutput(ns('div_chart'), height = 'fit-content', width = 300)
          ),

          div(class = 'overview_card_2',
              style = 'grid-area: top2; height: fit-content;width: 300px; ',
              div(class = 'title_toggle_2',
                  style = 'display: flex; flex-direction: column',
                  h5('Daily Traffic Trend'),
                  h6('Network Traffic - Last 24 Hours', style = 'font-weight: 700;padding: 0 .25em;')
                  # materialSwitch(inputId = ns("checkbox_2"))
                  ),


              highchartOutput(outputId = ns('traffic_chart'),
                              height = 'fit-content', width = 300))
      ),
      #********************************************************************************
      div(class = 'cards_row_2',
          style = 'width: 100%;display: flex; gap: 2em; height: fit-content;',

          div(class = 'overview_card_3',
              style = 'grid-area: top3; height: fit-content; width: 300px;',
              div(class = 'title_toggle_3',
                  style = 'display: flex; flex-direction: column',
                  h5('Operational Impact'),
                  h6('Effect of Accidents - Last 90 Days', style = 'font-weight: 700;padding: 0 .25em;')
                  # materialSwitch(inputId = ns("checkbox_3"))
                  ),


              highchartOutput(outputId = ns('operational_chart'),
                              height = 'fit-content', width = 300)),

          div(class = 'overview_card_4',
              style = 'grid-area: top4; height: fit-content;width: 300px;',
              div(class = 'title_toggle_4',
                  style = 'display: flex; flex-direction: column',
                  h5('Uptime'),
                  h6('Active User - Last 90 Days', style = 'font-weight: 700;padding: 0 .25em;')
                  # materialSwitch(inputId = ns("checkbox_4"))
                  ),

              highchartOutput(outputId = ns('uptime_chart'), height = 'fit-content', width = 300))
      )
      #********************************************************************************
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

      output$chart_treemap <- renderHighchart({
        gapminder::gapminder %>%
          dplyr::filter(year  == 2007) %>%
          dplyr::filter(continent  == input$custom_select) %>%


          highcharter::data_to_hierarchical(group_vars = c(continent, country),
                                            size_var = pop) %>%
          hchart(type = "treemap", colorByPoint = TRUE) %>%
          hc_plotOptions(treemap = list(events = list(click = click_js)))%>%
          hc_size(height = 550)
      })

      data <- reactive({
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
            tags$li(class = 'countries_list',paste0('Last Population Data:',' ',round(data()$pop[12],0))),
            tags$li(class = 'countries_list',paste0('Last life Expectancy Data :',' ',round(data()$lifeExp[12]),' (Years)')),
            tags$li(class = 'countries_list',paste0('Last GDP Percapita Data:',' $',round(data()$gdpPercap[12],2)))
          )
          )

         )
      })



      output$div_chart <- renderHighchart({

        hchart(data(),
               "bubble",
               name = rv$country,
               hcaes(x = year, y = lifeExp, size = pop),
               colorByPoint = TRUE) %>%

          # hc_size(height = 200) %>%
          chart_treemap_dash(data = data())
      })

      output$traffic_chart <- renderHighchart({

        hchart(data(),
               "spline",

               hcaes(x = year, y = lifeExp, size = pop),
               colorByPoint = TRUE)%>%
          # hc_size(height = 200) %>%
          chart_treemap_dash(data = data())


      })


      output$operational_chart <- renderHighchart({

        hchart(data(),
               "column",

               hcaes(x = year, y = lifeExp, size = pop),
               colorByPoint = TRUE) %>%
          # hc_size(height = 200) %>%
          chart_treemap_dash(data = data())


      })
      output$uptime_chart <- renderHighchart({


        hchart(data(),
               "areaspline",
               backgroundColor = 'red',
               hcaes(x = year, y = lifeExp, size = pop),
               colorByPoint = TRUE) %>%
          # hc_size(height = 200) %>%
          chart_treemap_dash(data = data())


      })


    }
  )
}
