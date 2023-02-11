
table_style <-
  function(dataframe,
           height = NULL,
           fontsize = NULL,
           cellPadding = NULL) {


    dataframe %>%

      reactable::reactable(
        # style = list(fontFamily = 'Roboto Condensed'),

        pagination = TRUE,
        height = height,


        striped = TRUE,
        highlight = TRUE,
        bordered = TRUE,

        theme = reactable::reactableTheme(
          borderColor = "lightgray",
          borderWidth = 1.5,
          stripedColor = "#f6f8fa",
          highlightColor = "#f0f5f9",
          cellPadding = cellPadding,
          style = list(fontFamily = "Roboto Condensed"),
          searchInputStyle = list(width = "100%")
        ),

        defaultColDef = reactable::colDef(
          vAlign = "center",
          headerVAlign = "bottom",
          align = 'center',
          style  = list(fontWeight = "bold"),

          footerStyle = list(fontWeight = "bold")
        ),

        columns = list(
          country = reactable::colDef(
            name = "Country",
            style = list(
              fontSize = fontsize,
              fontWeight = "bold",
              background = "rgba(0, 0, 0, 0.05)"
            )

          ),

          continent = reactable::colDef(
            name = "Continent",
            style = list(
              fontSize = fontsize,
              fontWeight = "bold",
              background = "rgba(0, 0, 0, 0.05)"
            )
          ),
          lifeExp = reactable::colDef(
            name = "Life Expectancy (Years)",
            format = colFormat(digits = 0),
            style = list(
              fontSize = fontsize,
              fontWeight = "bold",
              background = "rgba(0, 0, 0, 0.05)"
            )
          ),
          pop = reactable::colDef(
            name = "Population",
            format = colFormat(separators = TRUE,digits = 0),
            style = list(
              fontSize = fontsize,
              fontWeight = "bold",
              background = "rgba(0, 0, 0, 0.05)"
            )
          ),
          gdpPercap = reactable::colDef(
            name = "GDP Percap. (US$)",
            format = colFormat(separators = TRUE,digits = 0),
            style = list(
              fontSize = fontsize,
              fontWeight = "bold",
              background = "rgba(0, 0, 0, 0.05)"
            )
          ),

          year = reactable::colDef(
            name = "Years",

            width = 100,

            format = reactable::colFormat(separators = FALSE),
            style = list(
              fontSize = fontsize,
              fontWeight = "bold",
              background = "whitesmoke"
            )


          )

        )
      )
  }
