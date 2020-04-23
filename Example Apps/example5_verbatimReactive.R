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
    textOutput("text"),
    verbatimTextOutput("summary"),
    plotOutput('Hist')    
  )
  
)
server <- function(input, output, session) {
  
  xvar <- reactive({
     mtcars[, input$var]
  })
  
  output$text <- renderText({
    paste("Summary of ", input$var)
  })
  
  output$summary <- renderPrint({
    summary(xvar())
  })
  
  output$Hist <- renderPlot({
    bins <- seq(min(xvar()), max(xvar()), length.out = input$bins + 1)
    hist(xvar(),
         breaks = bins, 
         col = 'darkgray', 
         border = 'white',
         main = "", xlab = paste("Histogram of ", input$var),
         ylab="")
  }) 
  
}

shinyApp(ui = ui, server = server)
