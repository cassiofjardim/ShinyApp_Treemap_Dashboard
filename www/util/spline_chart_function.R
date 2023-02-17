spline_chart_function <- function(hc, add_ts_name,color) {
  hc %>%

    hc_yAxis(
      title = list(text = "Week Ranking",
                   style = list(color = 'white')),

      labels = list(
        style = list(
          color = 'white',
          fontSize = '12px',
          # fontWeight = 'bold',
          fontFamily = "Roboto Condensed"
        )
      ),
      tickAmount = 6,
      gridLineWidth = 0.5,
      gridLineColor = 'gray',
      gridLineDashStyle = "longdash"
    ) %>%

    hc_xAxis(
      title = list(
        text = "Rodadas",
        style = list(color = 'white',
                     fontSize = '12px')
      ),
      opposite = TRUE,
      tickInterval = 1,
      lineWidth = 0,
      tickLength = 3.5,

      offset = 0,
      plotLines = list(
        list(
          color = 'whitesmoke',
          width = 1,
          dashStyle = "shortdash",
          value = 18
        )
      ),
      labels = list(
        style = list(
          color =  'white',
          # fontWeight = 'bold',
          fontSize = '12px',
          fontFamily = "Roboto Condensed"
        )
      )
    ) %>%

    hc_plotOptions(
      # spline = list(
      #
      #   dataLabels= list(
      #     enabled = FALSE,
      #
      #     verticalAlign =
      #       'top'
      #   )),
      series = list(
        borderRadius = 3.5,
        marker = list(enabled = FALSE),
        lineWidth = 2,
        shadow = TRUE,
        fillOpacity = 0.25,
        fillColor = list(
          linearGradient = list(
            x1 = 0,
            x2 = 1,
            y1 = 0 ,
            y2 = 1
          ),
          stops = list(
            list(0.1, '#598ed9'),
            list(0.50, '#8eadda'),
            list(1, '#598ed9')
          )
        )
      )
    ) %>%

    hc_tooltip(
      headerFormat = '<b>Rodada nº: {point.x}</b><br/>',
      pointFormat = paste0('Posição: '," {point.y:,.0f}º")) %>%
    #
    hc_add_series(data = sort(df_weeks_perforance[[add_ts_name]]),
                  type = "spline",
                  color = color)
}
