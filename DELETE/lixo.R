
library(shiny)
library(highcharter)
library(tidyverse)
library(gapminder)

ui <- fluidPage(

  highchartOutput(outputId = 'hcontainer'),

htmlOutput('countries')

)

server <- function(input, output, session) {


  click_js <-
    JS("function(event) {Shiny.onInputChange('treemapclick', event.point.name);}")

  #https://stackoverflow.com/questions/49396134/reset-inputmytime-selected-value-back-to-null-in-timevis-when-a-different-filte

  rv <- reactiveValues()

  observe( {
    rv$country <- input$treemapclick
  })

  observe(

    rv$country <- 'Chile'
   )


  output$hcontainer <- renderHighchart({
    gapminder::gapminder %>%
      dplyr::filter(year  == 2007) %>%

      highcharter::data_to_hierarchical(group_vars = c(continent, country),

                                        size_var = pop) %>%
      hchart(type = "treemap") %>%
      hc_plotOptions(treemap = list(events = list(click = click_js)))
  })

  output$countries <- renderUI({
    h1(rv$country)
  })

}

shinyApp(ui, server)
