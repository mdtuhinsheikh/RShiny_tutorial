library(shiny)
library(ggplot2)
require(gridExtra)
ui <- fluidPage(
  sidebarPanel(
    selectInput("var", "Dependent Variable",choices = names(mtcars)),
    sliderInput("bins",
                "Number of bins:",
                min = 1,
                max = 50,
                value = 30)
  ),
  mainPanel(
    plotOutput('Hist')    
  )

)
server <- function(input, output, session) {
  
  # xvar <- reactive({
  #   input$var
  # })


  output$Hist <- renderPlot({
    #req(xvar())
    # hist(mtcars[[xvar()]])
    x <- mtcars[, input$var]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(mtcars[, input$var],
         breaks = bins, 
         col = 'darkgray', 
         border = 'white',
         main = "", xlab = paste("Histogram of ", input$var),
         ylab="")
    
  }) 
  
}

shinyApp(ui, server)


shinyApp(ui = ui, server = server)
