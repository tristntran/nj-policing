#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  dept_data <- reactive({
    final_dept_df %>% filter(pd_dept == input$departmentInput,
                             force_type %in% c(input$forceChoicesInput))
  })
  officer_data <- reactive({
    officer_df %>% filter(pd_dept == input$departmentInput)
  })
  output$improvePlotOutput <- renderPlot(
     ggplot(dept_data()) + 
      aes(x= period, y = percent,
          group = force_type, color = force_type) +
      geom_line()
  )
  output$deptTableOuput <- renderTable(x <- dept_data())
  output$officerTableOuput <- renderTable(x <- officer_data())
})
