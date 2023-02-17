column_chart_function <- function(hc,y_var, mean_line,color) {
  hc %>%

    hc_yAxis(

      title = list(text = y_var),

      tickAmount = 6,
      gridLineWidth = 0.5,
      gridLineColor = 'gray',
      gridLineDashStyle = "longdash",

      labels = list(
        style = list(
          color = 'black',
          fontSize = '12px',
          # fontWeight = 'bold',
          fontFamily = "Roboto Condensed"
        )),

      plotLines = list(
        list(
          color =color,
          width = 2,
          dashStyle = "shortdash",
          value = mean_line))
      ) %>%

  hc_plotOptions(
    column = list(

      dataLabels= list(
        enabled = TRUE,

        verticalAlign =
          'top'
      ))
  )

}

