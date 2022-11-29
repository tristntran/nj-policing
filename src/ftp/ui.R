#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

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
            checkboxGroupInput("icons", "Use of Force:",
                               choiceNames =
                                 list(h4("Compliance Hold",icon("gun")),
                                      h4("Hand/Fists",icon("pepper-hot")),
                                      h4("Pepper Spray", icon("bug")),
                                      h4("Baton",icon("bug"), icon("bug")),
                                      h4("Take Down",icon("bug"), icon("bug")),
                                      h4("Deadly Force", icon("hand-fist"))
                                      ),
                               choiceValues =
                                 list("compliance_hold", "hand_fists",
                                      "pepper_spray", "baton", "take_down",
                                      "deadly_force")
            ),
            selectInput("variable", "Department:",
                        final_dept_df$pd_dept)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          # Just the main plot. Gonna be a line graph
          # plotOutput("distPlot")
          # maybe have a couple of tabs for different views if i have time.
          # something like this
          # https://stackoverflow.com/questions/69287397/in-r-shiny-when-rendering-conditional-panels-in-main-panel-how-to-change-view-w
          tabsetPanel(
            tabPanel("Plot", plotOutput("improvePlotOuptut")),
            tabPanel("Summary", verbatimTextOutput("textSummaryOuptut")), # some analysis and description
            tabPanel("Officers", tableOutput("officerTableOuptut")) # render a table of officers and their statistics
          )
        )
    )
))
