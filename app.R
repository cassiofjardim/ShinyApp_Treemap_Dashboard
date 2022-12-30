library(shiny)
library(imola)
library(shinyWidgets)
library(highcharter)
library(stringr)
library(shinyjs)



# https://stackoverflow.com/questions/66228047/click-event-in-highcharter-treemap-r-shiny

ui <- navbarPage(
  useShinyjs(),

  title = 'TREEMAP - Population',
  div(
    class = 'select_input_div',
    h1(class = 'dash_title',
       'TREEMAP - Dashboard')
  ),
  includeCSS(path = 'www/css/style.css'),
  tabPanel(
    title = "Treemap Panel",
    id = 'main_div',

      # - - - - -- - - - - -- - - - - -- - - - - -- - - - - -- - - - - -- - - - - -- - - - -
    div(class  ='treemap_box_1box_2',

    div(
      class = 'treemap',
      # style = "grid-area: treemap;",
      htmlOutput(outputId = 'cards'),

      h1(
        "TREEMAP PLAYERS: Total Distance Team's Players",
        tags$img(
          src = 'img/exclamation.png',
          width = '18px',
          height = '18px'
        )
      ),
      selectInput(
        inputId = 'custom_select',
        width = '200px',
        label = 'Clubs',
        choices = unique(gapminder::gapminder$continent)
      ),


      highchartOutput(outputId = 'hcontainer'),

      htmlOutput(outputId = 'countries')


    ),

    div(
      class = 'box_1_box_2',
      div(
        # style = "grid-area: box_1;width: 100%;",
        class = 'box_1',
        h5("SHOOTING AND SHOOTS ON TARGET (SoT) - LAST 5 Games"),
        div(style = 'display:flex;',
            htmlOutput(outputId = 'player_name_1')),


        div(class = 'shoots', style = 'display: flex;'),

        tabsetPanel(
          tabPanel(title = 'Home Matches',

                   htmlOutput("clicked")),
          tabPanel(title = 'Away Matches',

                   htmlOutput("clicked_2")),

          tabPanel(title = 'First Round',

                   htmlOutput("clicked_3")),

          tabPanel(title = 'Second Round',

                   htmlOutput("clicked_4"))


        )

        # reactableOutput(ns('table_right'), width = 'auto')
        #  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      ),
      div(
        class = 'box_2',
        # style = "grid-area: box_2;width: 100%;",

        h1(
          h5("SHOOTING AND SHOOTS ON TARGET (SoT) - LAST 5 Games"),
          htmlOutput(outputId = 'player_name_2'),
          tags$img(
            src = 'img/exclamation.png',
            width = '18px',
            height = '18px'
          )
        ),

        tabsetPanel(
          tabPanel(title = 'Home Matches',

                   htmlOutput("each_match_1")),
          tabPanel(title = 'Away Matches',

                   htmlOutput("each_match_2")),

          tabPanel(title = 'First Round',

                   htmlOutput("each_match_3")),

          tabPanel(title = 'Second Round',

                   htmlOutput("each_match_4"))


        )

      )
    ))
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -




    )




)

server <- function(input, output, session) {
  # server_function()

  click_js <-
    JS("function(event) {Shiny.onInputChange('treemapclick', event.point.name);}")


  rv <- reactiveValues(country = NULL)

  observe( {
    rv$country <- input$treemapclick
  })

  observe(

    if(input$custom_select == 'Asia'){
      rv$country <- 'China'
    }else{
      if(input$custom_select == 'Europe'){
        rv$country <- 'Germany'
      }else{
        if(input$custom_select == 'Africa'){

          rv$country <- 'Egypt'


        }else{
          if(input$custom_select == 'Americas'){
            rv$country <- 'United States'

          }else{
            if(input$custom_select == 'Oceania'){
              rv$country <- 'Australia'

            }
          }

        }

      }

    }


  )


  output$hcontainer <- renderHighchart({
    gapminder::gapminder %>%
      dplyr::filter(year  == 2007) %>%
      dplyr::filter(continent  == input$custom_select) %>%


      highcharter::data_to_hierarchical(group_vars = c(continent, country),

                                        size_var = pop) %>%
      hchart(type = "treemap",colorByPoint = TRUE) %>%
      hc_plotOptions(treemap = list(events = list(click = click_js)))
  })


  output$player_name_1 <- renderUI({
    h1(style  = "display: flex; justify-content: space-around;",
       paste0(rv$country),
       tags$img(src = paste0('img/icons_flags/',rv$country,'.png'),
                height = '48px', width = '48px',
                style = 'class: inline-block'))

  })
  output$player_name_2 <- renderUI({
    h1(style  = "display: flex; justify-content: space-around;",
       paste0(rv$country),
       tags$img(src = paste0('img/icons_flags/',rv$country,'.png'),
                height = '48px', width = '48px',style = 'class: inline-block'))

  })

#
#   output$clicked <- renderUI({
#
#     reactable::reactable(width = 'auto',
#                          data = gapminder::gapminder %>%
#                            dplyr::filter(year  == 2007) %>%
#                            dplyr  ::filter(country  == players()) %>%
#                            dplyr::filter(continent == input$custom_select))
#
#   }) %>% bindCache(input$custom_select)



}

shinyApp(ui, server)
