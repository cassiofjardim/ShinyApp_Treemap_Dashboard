library(shiny)
library(tidyverse)
library(imola)
library(shinyWidgets)
library(highcharter)
library(stringr)
library(shinyjs)
library(reactable)
library(reactablefmtr)

source(file = 'www/R/sql_nivel_liga.R')
source(file = 'www/R/main.R')

source(file = 'www/R/module_left_right_columns.R')

source(file = 'www/R/donwload_table_button.R')
source(file = 'www/R/cards_chart_function.R')

source(file = 'www/R/cards_tabsetpanels_function.R')
# source(file = 'www/R/cards_functions.R')

source(file = 'www/R/main_function_reactable_treemap_dash.R')


ui <- fluidPage(

  useShinyjs(),

  includeCSS(path = 'www/css/style_treemap.css'),

  title = 'TREEMAP - Premiere League',

  div(
    class = 'select_input_div',

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
