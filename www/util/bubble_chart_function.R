bubble_chart_function <- function(hc,y_var) {

  hc %>%

    hc_yAxis(plotLines = list(
      list(
        color = 'red',
        width = 2,
        dashStyle = "shortdash",
        label = list(
          text = var,
          verticalAlign = 'top',
          y = -120,
          x = -20,
          align = 'right'
        )
        # value = mean_line
      )
    ),
    title = list(text = y_var)) %>%

    hc_plotOptions(
      bubble = list(

        dataLabels= list(
          enabled = TRUE
        ))
    )


}

#
