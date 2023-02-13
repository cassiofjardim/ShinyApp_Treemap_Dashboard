charts_card_function <- function(hc, metric_name){
  hc %>%

    hc_xAxis(title = list(text = "",
                          align = "high",
                          style = list(fontSize = "8px",
                                       color =  "black",
                                       fontWeight = "bold",
                                       fontFamily = "Roboto Condensed"))

    ) %>%
    hc_plotOptions(
      column = list(
        dataLabels= list(
          enabled = TRUE,
          verticalAlign = 'top'
        )),
      bubble = list(
        dataLabels= list(
          enabled = TRUE,
          verticalAlign = 'top'
        ))

      ) %>%

    hc_tooltip(
      # headerFormat = '<b>{point.x:,.0f}</b><br/>',
      pointFormat = paste0(metric_name,"{point.y:,.0f}"))
}
