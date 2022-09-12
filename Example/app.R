#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(reactable)

# Define UI for application that draws a histogram
ui <- fluidPage(

  
    # IMPORTANT NOTE: you need to have access to a font awesome access kit. Create one via fontawesome.com in your
    # account settings and copy the link that it gives you in the kitname. It will look something like:
    # <script src="https://kit.fontawesome.com/9999a9a999.js" crossorigin="anonymous"></script> - this link is just 
    # an example of the format.
    
  # This adds the script tag to the head of the Shiny document. It injects Font Awesome into the Shiny app.
    tags$head(HTML('<script src="https://kit.fontawesome.com/*kitname*.js" crossorigin="anonymous"></script>')),
    
    # Append a style tag to the .tippy class. The tippy package adds tooltips to the columns. This appends a style to
    # those tooltips.
    tags$style(HTML('.tippy:after {
         font-family: "Font Awesome 5 Free";     
         content: "\\f059";
    }')),
    
    # Application title
    titlePanel("Shiny Help Table Icon - Gas Mileage Example"),


    # Show a plot of the generated distribution
    mainPanel(
         reactableOutput("tablePlot")
    )
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    # Render the Reactable table
    output$tablePlot <- renderReactable({

        # Get example data from Stackoverflow question
        output_data <- as_tibble(mtcars[1:6, ], rownames = "car") %>%
          select(car:hp)
      
        reactable(
          data,
          columns = list(
            mpg = colDef(header = with_tooltip("mpg", "Miles per US gallon")),
            cyl = colDef(header = with_tooltip("cyl", "Number of cylinders"))
          )
        )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
