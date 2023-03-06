treemap_chart_function <- function(data,click_event, slices_colors){

  data %>%

  hchart(type = "treemap",

         layoutStartingDirection = 'left',
         colorByPoint = TRUE,

         inverted = TRUE) %>%

    hc_colors(colors = slices_colors)  %>%

    hc_plotOptions(

      treemap = list(

        # marker = list(
        #   symbol = 'url(https://www.highcharts.com/samples/graphics/sun.png)'
        # ),

        dataLabels= list(
          enabled= TRUE,
          align= 'center',
          verticalAlign= 'top',
          style= list(
            fontSize= '12px'
          )
        ),
        events = list(click = click_event))) %>%


          hc_tooltip(
            headerFormat = glue::glue('
                            <strong, style = "font-size: 20px;">
                                      {data$Squad_Tooltip[1]}
                            </strong>
                            <br/>
                            <img, src = "img/dashboard.svg">'),
            pointFormat = paste0(" {point.y:,.0f}"))

}


# chart_treemap_dash<- function(hc,data, var){
#   hc %>%
#
#     hc_size(height = 200) %>%
#
#
#     hc_xAxis(title = list(text = "",
#                          align = "high",
#                          style = list(fontSize = "12px",
#                                       color =  "black",
#                                       fontWeight = "bold",
#                                       fontFamily = "Roboto Condensed")),
#
#             labels = list(style = list(color =  'black',
#                                        fontWeight = "bold",
#                                        fontFamily = "Roboto Condensed",
#                                        format = '{value:%b %d}')),
#             tickInterval= 5
#
#     ) %>%
#
#     hc_yAxis(
#
#       title = list(text = "",
#                    align = "high",
#                    style = list(fontSize = "12px",
#                                 color =  "black",
#                                 fontWeight = "bold",
#                                 fontFamily = "Roboto Condensed")),
#
#       labels = list(style = list(color =  'black',
#                                  fontWeight = "bold",
#                                  fontFamily = "Roboto Condensed",
#                                  format = '{value:%b %d}')),
#       tickAmount = 6,
#       gridLineWidth = 0.5,
#       gridLineColor = 'gray',
#       gridLineDashStyle = "longdash") %>%
#
#
#     # hc_tooltip(pointFormat = paste0(var," {point.x:,.0f}")) %>%
#
#     hc_add_theme(hc_theme_elementary(chart = list(
#                                                   backgroundColor = 'whitesmoke'
#                                                   # marginLeft = 30
#                                                   ))) %>%
#
#  hc_plotOptions(
#       column = list(
#
#         dataLabels= list(
#           enabled = TRUE,
#
#           verticalAlign =
#             'top'
#         )),
#
#       bubble = list(
#
#         dataLabels= list(
#           enabled = TRUE,
#
#           verticalAlign =
#             'top'
#         )),
#
#       areaspline = list(
#
#         dataLabels= list(
#           enabled = TRUE,
#
#           verticalAlign =
#             'top'
#         )),
#
#       spline = list(
#
#         dataLabels= list(
#           enabled = TRUE,
#
#           verticalAlign =
#             'top'
#         )))
#
#
# }
#
