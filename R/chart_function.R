
chart_treemap_dash<- function(hc,data, var){
  hc %>%

    hc_size(height = 200) %>%


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
                                                  ))) %>%

 hc_plotOptions(
      column = list(

        dataLabels= list(
          enabled = TRUE,

          verticalAlign =
            'top'
        )),

      bubble = list(

        dataLabels= list(
          enabled = TRUE,

          verticalAlign =
            'top'
        )),

      areaspline = list(

        dataLabels= list(
          enabled = TRUE,

          verticalAlign =
            'top'
        )),

      spline = list(

        dataLabels= list(
          enabled = TRUE,

          verticalAlign =
            'top'
        )))


}

