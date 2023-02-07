right_column_UI <- function(id) {
  ns <- NS(id)
  tagList(



  )
}

right_column_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {



      output$div_chart <- renderHighchart({

        gapminder <- gapminder::gapminder %>%
          dplyr::filter(continent == 'Europe', country == 'Portugal') %>%
          dplyr::select(year, country, pop, continent, lifeExp)

        hchart(gapminder,
               "bubble",
               hcaes(x = year, y = lifeExp, size = pop),
               colorByPoint = TRUE) %>%
          hc_size(height = 200) %>%
          hc_xAxis(title = list(text = '')) %>%
          hc_yAxis(title = list(text = '')) %>%
          hc_chart(borderWidth = 0)


      })

      output$traffic_chart <- renderHighchart({

        gapminder <- gapminder::gapminder %>%
          dplyr::filter(continent == 'Europe', country == 'Portugal') %>%
          dplyr::select(year, country, pop, continent, lifeExp)

        hchart(gapminder,
               "bubble",
               hcaes(x = year, y = lifeExp, size = pop),
               colorByPoint = TRUE) %>%
          hc_size(height = 200) %>%
          hc_xAxis(title = list(text = '')) %>%
          hc_yAxis(title = list(text = '')) %>%
          hc_chart(borderWidth = 0)


      })







    }
  )
}
