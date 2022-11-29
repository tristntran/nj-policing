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
            checkboxGroupInput("icons", "Use of Force:",
                               choiceNames =
                                 list(icon("gun"), icon("hand-fist"),
                                      icon("pepper-hot"), icon("bug")),
                               choiceValues =
                                 list("gun", "bed", "cog", "bug")
            ),
            selectInput("variable", "Department:",
                        c("Cylinders" = "cyl",
                          "Transmission" = "am",
                          "Gears" = "gear"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
          # Just the main plot. Gonna be a line graph
          # plotOutput("distPlot")
          # maybe have a couple of tabs for different views if i have time.
          # something like this
          # https://stackoverflow.com/questions/69287397/in-r-shiny-when-rendering-conditional-panels-in-main-panel-how-to-change-view-w
          tabsetPanel(
            tabPanel("Plot", plotOutput("plot")),
            tabPanel("Summary", verbatimTextOutput("summary")), # some analysis and description
            tabPanel("Officers", tableOutput("table")) # render a table of officers and their statistics
          )
        )
    )
))
