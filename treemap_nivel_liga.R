library(shiny)
library(tidyverse)
library(imola)
library(shinyWidgets)
library(highcharter)
library(stringr)
library(shinyjs)
library(reactable)
library(reactablefmtr)

source(file = 'R/main_nivel_liga.R')

# source(file = 'www/R/module_left_right_columns.R')

source(file = 'www/util/treemap_chart_function.R')
source(file = 'www/util/spline_chart_function.R')
source(file = 'www/util/column_chart_function.R')
source(file = 'www/util/bubble_chart_function.R')
source(file = 'www/util/marquee_week_games.R')

source(file = 'www/util/cards_tabsetpanels_function.R')

source(file = 'www/util/reactable_treemap_function.R')


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
  div(class = "marquee-container",
      div(class = "marquee",
          marquee_df,marquee_df)
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
