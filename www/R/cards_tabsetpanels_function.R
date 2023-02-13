function_cards_tabsetpanel <- function(title, card_number,
                                    panel_title_1,panel_title_2,panel_title_3,panel_title_4,
                                    chart_id_1,chart_id_2,chart_id_3,chart_id_4,
                                    first_description_id, footer_description_id){

  div(class = paste0('overview_card_',card_number),

      h5(tags$img(class = 'svg_icon', height  ='24px',width  ='24px',
                  src = paste0('img/icon_',card_number,'.svg')),
         title, style = 'display: flex; align-items: center;
             justify-content: space-between; border-radius: 2px;'),

      htmlOutput(outputId = first_description_id),

      style = 'grid-area: top1; height: fit-content;width: 45%;',
      tabsetPanel(
        id = 'tabset_main',
        tabPanel(
          title = panel_title_1,
          highchartOutput(chart_id_1, height = 'fit-content')
        ),

        tabPanel(
          title = panel_title_2,
          highchartOutput(chart_id_2, height = 'fit-content')
        ),

        tabPanel(
          title = panel_title_3,
          highchartOutput(chart_id_3, height = 'fit-content')
        ),

        tabPanel(
          title = panel_title_4,
          highchartOutput(chart_id_4, height = 'fit-content')
        )

      ),

      htmlOutput(outputId = footer_description_id)

  )

}
