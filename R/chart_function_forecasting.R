
chart_treemap_dash<- function(hc,data, var){
  hc %>%

    hc_size(height = 200) %>%
    # hc_xAxis(plotBands = list(
    #   list(
    #     from = 1950,
    #     to = max(data$year),
    #     color = "transparent"
    #     # gradient = '{"linearGradient":{"x1":0,"y1":0,"x2":0,"y2":1},"stops":[[0,"#d2f8d2"],[1,"#76ef76"]]}'
    #   ),
    #   list(
    #     from = c(1950,1960),
    #     to = max(data$year),
    #     label = list(text = paste0('Forecasting: '),
    #                  align = 'top',
    #                  verticalAlign = 'left',
    #                  style = list(
    #                    fontSize = '12px',
    #                    fontWeight = 'bold'
    #                  ))
    #   )
    # ),plotLines = list(list(value = 2005,
    #                         width = 3,
    #                         color = '#FF0000',
    #                         dashStyle = 'Dot')),tickInterval = 7
    # )%>%



    hc_xAxis(title = list(text = "",
                         align = "high",
                         style = list(fontSize = "12px",
                                      color =  "black",
                                      fontWeight = "bold",
                                      fontFamily = "Roboto Condensed")),

            labels = list(style = list(color =  'black',
                                       fontWeight = "bold",
                                       fontFamily = "Roboto Condensed",
                                       format = '{value:%b %d}')),
            tickInterval= 5

    ) %>%

    hc_yAxis(

      title = list(text = "",
                   align = "high",
                   style = list(fontSize = "12px",
                                color =  "black",
                                fontWeight = "bold",
                                fontFamily = "Roboto Condensed")),

      labels = list(style = list(color =  'black',
                                 fontWeight = "bold",
                                 fontFamily = "Roboto Condensed",
                                 format = '{value:%b %d}')),
      tickAmount = 6,
      gridLineWidth = 0.5,
      gridLineColor = 'gray',
      gridLineDashStyle = "longdash") %>%


    hc_tooltip(pointFormat = paste0(var," {point.y:,.0f}")) %>%

    hc_add_theme(hc_theme_elementary(chart = list(
                                                  backgroundColor = 'whitesmoke'
                                                  # marginLeft = 30
                                                  )))

    # hc_plotOptions(series = list(dataLabels = list(
    #   enabled = TRUE,
    #   align = 'top',
    #   verticalAlign = 'top',
    #
    #   formatter = htmlwidgets::JS("function() {
    #             if (this.x === 2050) {
    #              return 'Last Value: ' + this.y;
    #             }
    #           }")
    # )))

}

