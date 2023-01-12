library(shiny)
library(highcharter)

ui <- fluidPage(
  column(3,
         highchartOutput("hcontainer",height = "800px", width = '900px')
  ),
  column(3,
         textOutput("clicked")
  )
)

server <- function(input, output){

  click_js <- JS("function(event) {Shiny.onInputChange('pieclick',event.point.name);}")

  output$hcontainer <- renderHighchart({
    highchart() %>%
      hc_chart(type = "pie") %>%
      hc_add_series(data = list(
        list(y = 3, name = "cat 1"),
        list(y = 4, name = "dog 11"),
        list(y = 6, name = "cow 55"))) %>%

      #  selection visualization
      hc_plotOptions(
        series = list(
          stacking = FALSE, allowPointSelect = TRUE ,events = list(click = click_js))
      ) %>% hc_size(width = 500, height = 500)
  })

  output$clicked <- renderText({
    input$pieclick
  })

}

shinyApp(ui, server)
