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
    officer_df %>% filter(pd_dept == input$departmentInput) %>%
      group_by(Officer_Name2) %>% 
      summarise(
        count_incedents = n_distinct(INCIDENTID),
        count_compliance_hold = sum(label =="compliance_hold"),
        count_hand_fists = sum(label =="hands_fists"),
        count_pepper_spray = sum(label == "pepper_spray"),
        count_baton = sum(label == "baton"),
        count_take_down = sum(label == "take_down"),
        count_leg_strikes = sum(label == "leg_strikes"),
        count_deadly_force = sum(label == "deadly_force")
      )
  })
  output$improvePlotOutput <- renderPlot(
     ggplot(dept_data()) + 
      aes(x= period, y = percent,
          group = force_type, color = force_type) +
      geom_line() + ggtitle("Use of Force by Category") + theme_bw() +
      labs(y= "Percent of Incidents", x = "Year Group")
  )
  output$deptTableOuput <- renderTable(x <- dept_data())
  output$officerTableOuput <- renderTable(x <- officer_data())
})
