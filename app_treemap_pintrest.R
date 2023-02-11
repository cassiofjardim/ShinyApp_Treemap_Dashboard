library(shiny)
library(imola)
library(shinyWidgets)
library(highcharter)
library(stringr)
library(shinyjs)
library(reactable)
library(reactablefmtr)


ui <- fluidPage(

  useShinyjs(),

  includeCSS(path = 'www/css/style_treemap.css'),

  title = 'TREEMAP - GAPMINDER',

  div(
    class = 'select_input_div',

    h1(tags$img(class = "svg_icon",src = 'img/dashboard.svg'),
       class = 'dash_title',
       'TREEMAP - Dashboard')
  ),
# - - - - -- - - - - -- - - - - -- - - - - -- - - - - -- - - - - -- - - - - -- - - - -
    div(class  ='treemap_left_right',

        left_right_columns_UI('left_right_column')
       )
 )


server <- function(input, output, session) {

  left_right_columns_Server('left_right_column')
}

shinyApp(ui, server)
