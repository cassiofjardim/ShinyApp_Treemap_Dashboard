library(shiny)
library(highcharter)
library(gapminder)
library(shinyjs)


ui <- fluidPage(
  column(12, highchartOutput("hcontainer",height = "300px")),
  column(12, htmlOutput("clicked")))

server <- function(input, output){

  click_js <- JS("function(event) {Shiny.onInputChange('treemapclick', event.point.name);}")

  output$hcontainer <- renderHighchart({

    gapminder::gapminder %>%
      dplyr::filter(year  == 2007) %>%
      highcharter::data_to_hierarchical(group_vars = c(continent, country), size_var = pop) %>%
      hchart(type = "treemap") %>%
      hc_plotOptions(treemap = list(events = list(click = click_js)))

  })


 output$clicked <- renderUI({
    if(is.null(input$treemapclick)){
      reactable::reactable(data =gapminder::gapminder %>%
                             dplyr::filter(year  == 2007) %>%
                             dplyr::filter(country == 'China'))
    }else{


      reactable::reactable(data =gapminder::gapminder %>%
                             dplyr::filter(year  == 2007) %>%
                             dplyr::filter(country == paste0(input$treemapclick)))
    }
 })
}

shinyApp(ui, server)



