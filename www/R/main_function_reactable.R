
table_style <-
  function(dataframe,
           height = NULL,
           fontsize = NULL,
           cellPadding = NULL) {


    dataframe %>%

      reactable::reactable(
        pagination = TRUE,
        height = height,
        striped = TRUE,
        highlight = TRUE,
        bordered = TRUE,
        defaultPageSize = 5,

        theme = reactable::reactableTheme(
          borderColor = "lightgray",
          borderWidth = 1.5,
          stripedColor = "#f6f8fa",
          highlightColor = "#f0f5f9",
          cellPadding = cellPadding,
          style = list(fontFamily = "Roboto Condensed",
                       fontSize = fontsize),
          searchInputStyle = list(width = "100%"),
          # tableStyle = list(border = '2px'),

          headerStyle = list(padding = '7.5px'),
          cellStyle = list(padding = '10px')

        ),

        defaultColDef = reactable::colDef(
          vAlign = "center",
          headerVAlign = "bottom",
          align = 'center',
          style  = list(fontWeight = "bold"),

          footerStyle = list(fontWeight = "bold")
        ),

        columns = list(
          Rk = reactable::colDef(
            name = "Position",
            style = list(
              fontSize = fontsize,

              background = "rgba(0, 0, 0, 0.05)"
            ),
            headerStyle = list(position = "sticky",
                               left = 0,
                               background = "#fff",
                               zIndex = 1)

          ),

          Season_End_Year = reactable::colDef(
            name = "Temporada",
            style = list(
              fontSize = fontsize,

              background = "rgba(0, 0, 0, 0.05)"
            ),
            headerStyle = list(position = "sticky",
                               left = 0,
                               background = "#fff",
                               zIndex = 1)

          ),

          Squad = reactable::colDef(
            name = "Equipes",
            minWidth = 140,
            style = list(
              fontSize = fontsize,
              position = "sticky",

              left = 0,
              background = "#fff",
              zIndex = 1,
              background = "rgba(0, 0, 0, 0.05)"
            ),
            headerStyle = list(position = "sticky",
                               left = 0,
                               background = "#fff",
                               zIndex = 1),

            cell = function(value){
              img_src <- knitr::image_uri(paste0('www/img/2021/',value,'.png'))
              tagList(
                div(
                  style  ='display: flex;',
                tags$img(src = img_src, width = '36px', height = '36px'),
                value))
            }

          )



          # Season_End_Year = reactable::colDef(
          #   name = "Temporada",
          #   style = list(
          #     fontSize = fontsize,
          #     position = "sticky",
          #     sticky = 'right',
          #     left = 0,
          #     background = "#fff",
          #     zIndex = 1,
          #     background = "rgba(0, 0, 0, 0.05)"
          #   ),
          #   headerStyle = list(position = "sticky",
          #                      left = 0,
          #                      background = "#fff",
          #                      zIndex = 1)
          #
          # )
        )


      )

  }

        #   continent = reactable::colDef(
        #     name = "Continent",
        #     style = list(
        #       fontSize = fontsize,
        #       fontWeight = "bold",
        #       background = "rgba(0, 0, 0, 0.05)"
        #     )
        #   ),
        #   lifeExp = reactable::colDef(
        #     name = "Life Expectancy (Years)",
        #     format = colFormat(digits = 0),
        #     style = list(
        #       fontSize = fontsize,
        #       fontWeight = "bold",
        #       background = "rgba(0, 0, 0, 0.05)"
        #     )
        #   ),
        #   pop = reactable::colDef(
        #     name = "Population",
        #     format = colFormat(separators = TRUE,digits = 0),
        #     style = list(
        #       fontSize = fontsize,
        #       fontWeight = "bold",
        #       background = "rgba(0, 0, 0, 0.05)"
        #     )
        #   ),
        #   gdpPercap = reactable::colDef(
        #     name = "GDP Percap. (US$)",
        #     format = colFormat(separators = TRUE,digits = 0),
        #     style = list(
        #       fontSize = fontsize,
        #       fontWeight = "bold",
        #       background = "rgba(0, 0, 0, 0.05)"
        #     )
        #   ),
        #
        #   year = reactable::colDef(
        #     name = "Years",
        #
        #     width = 100,
        #
        #     format = reactable::colFormat(separators = FALSE),
        #     style = list(
        #       fontSize = fontsize,
        #       fontWeight = "bold",
        #       background = "whitesmoke"
        #     )
        #
        #
        #   )



