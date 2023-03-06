library(shiny)
library(tidyverse)
library(imola)
library(shinyWidgets)
library(highcharter)
library(stringr)
library(shinyjs)
library(reactable)
library(reactablefmtr)

source(file = 'R/module/module_treemap.R')
source(file = 'R/util/treemap_chart_function.R')
source(file = 'R/util/cards_tabsetpanels_function.R')

# https://br.pinterest.com/pin/756604806169299033/

ui <- fluidPage(

  useShinyjs(),

  includeCSS(path = 'www/css/style_treemap.css'),

  title = 'TREEMAP - Premiere League',

  div(
    class = 'main_header_div',

    h1(tags$img(class = "svg_icon",src = 'img/dashboard.svg'),
       class = 'dash_title',
       'TREEMAP - Nível Liga')
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
