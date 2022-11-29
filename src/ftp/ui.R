#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("New Jersey Policing"),
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      # Dropdown list for department
      
      # Checkbox input to display options
      
        sidebarPanel(
            # Change icons to pictures of the different 
          # officer_df$compliance_hold <- TRUE
          # officer_df$hand_fists <- TRUE
          # officer_df$pepper_spray <- TRUE
          # officer_df$baton <- TRUE
          # officer_df$take_down <- TRUE
          # officer_df$deadly_force <- TRUE
            checkboxGroupInput("forceChoicesInput", "Use of Force:",
                               choiceNames =
                                 list(h4("Compliance Hold",icon("gun")),
                                      h4("Hand/Fists",icon("hand-fist")),
                                      h4("Pepper Spray", icon("pepper-hot")),
                                      h4("Baton",icon("grip-lines")),
                                      h4("Take Down",icon("angle-down")),
                                      h4("Leg Strikes",icon("shoe-prints")),
                                      h4("Deadly Force", icon("skull"))
                                      ),
                               choiceValues =
                                 list("pct_complaince_hold", "pct_hands_fists",
                                      "pct_pepper_spray", "pct_baton",
                                      "pct_take_down", "pct_leg_strikes",
                                      "pct_deadly_force")
            ),
            selectInput("departmentInput", "Department:",
                        final_dept_df$pd_dept %>% unique())
        ),

        # Show a plot of the generated distribution
        mainPanel(
          # Just the main plot. Gonna be a line graph
          # plotOutput("distPlot")
          # maybe have a couple of tabs for different views if i have time.
          # something like this
          # https://stackoverflow.com/questions/69287397/in-r-shiny-when-rendering-conditional-panels-in-main-panel-how-to-change-view-w
          tabsetPanel(
            tabPanel("Plot", plotOutput("improvePlotOutput")),
            tabPanel("DepartmentSummary", tableOutput("deptTableOuput")), # some analysis and description
            tabPanel("Officers", tableOutput("officerTableOuput")) # render a table of officers and their statistics
          ),
          verbatimTextOutput("verb")
        )
    )
))
