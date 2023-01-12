mod_ex2_UI <- function(id) {
  ns <- NS(id)
  tagList(

    highchartOutput(ns("hcontainer")),
    htmlOutput(ns("clicked"))

  )
}

mod_ex2_Server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

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
                                 dplyr::filter(country == input$treemapclick))
        }
      })

    }
  )
}
