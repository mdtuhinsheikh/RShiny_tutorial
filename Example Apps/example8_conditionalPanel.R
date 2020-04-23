library(shiny)

ui <- fluidPage(
  headerPanel(title = "Conditional panel app"),
  sidebarPanel(
    selectInput("n", "Select Option", 
                choices = c("option1", "option2"),
                selected = "option1"),
    conditionalPanel(
      condition = "input.n == 'option1'",
      #titlePanel("1 Options"),
      selectInput("b", "Select Options within option1", 
                choices = c("A", "B")),
      conditionalPanel(
        condition = "input.b == 'A'",
        titlePanel("Options A")
      ),
      conditionalPanel(
        condition = "input.b == 'B'",
        titlePanel("Options B")
      )      
    ),
    conditionalPanel(
      condition = "input.n == 'option2'",
      #titlePanel("1 Options"),
      selectInput("d", "Select Options within option2", 
                choices = c("C", "D")),
      uiOutput("vx")
    # conditionalPanel(
    #   condition = "input.d == '1'"#,
    #   #titlePanel("1 Options")
    # ),
    # conditionalPanel(
    #   condition = "input.d == '2'"#,
    #   #titlePanel("2 Options")
    #)      
    )
  ),
  mainPanel(
    verbatimTextOutput("text")
  )
)

server <- function(input, output){
  output$text <- renderText({
    if(input$n == 'option1'){
      paste("1st Choice ", input$n, "choice within 1st ", 
            input$b, sep = "\n")
    } else {
      output$vx <- renderUI({
        selectInput("test", "Options within second choice", 
                    choices = c("choice Opt2 1", "choice Opt2 2"),
                    selected = "test1")
      })
      paste("1st Choice ", input$n, "choice within 1st ", input$d, 
            "third choice ", input$test, sep = "\n")
    }
  })
}

shinyApp(ui, server)


