

chart_forecasting_function <- function(hc,data,model){
  hc %>%

    hc_size(height = 200) %>%
    hc_xAxis(plotBands = list(
      list(
        from = 2005,
        to = max(data$year),
        color = "lightgreen",
        gradient = '{"linearGradient":{"x1":0,"y1":0,"x2":0,"y2":1},"stops":[[0,"#d2f8d2"],[1,"#76ef76"]]}'
      ),
      list(
        from = 2005,
        to = max(data$year),
        label = list(text = paste0('Forecasting: ',model),
                     align = 'top',
                     verticalAlign = 'left',
                     style = list(
                       fontSize = '12px',
                       fontWeight = 'bold'
                     ))
      )
    ),plotLines = list(list(value = 2005,
                            width = 3,
                            color = '#FF0000',
                            dashStyle = 'Dot')),tickInterval = 7
    )%>%
    hc_tooltip(pointFormat = "Population: {point.y:,.0f}") %>%
    hc_add_theme(hc_theme_elementary()) %>%
    hc_plotOptions(series = list(dataLabels = list(
      enabled = TRUE,
      align = 'top',
      verticalAlign = 'top',

      formatter = htmlwidgets::JS("function() {
                if (this.x === 2050) {
                 return 'Last Value: ' + this.y;
                }
              }")
    )))

}

