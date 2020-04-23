library(shiny)
library(ggplot2)
require(gridExtra)

ui <- fluidPage(
  titlePanel(title = "Dynamic user interface"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "select data", 
                  choices = c("iris", "mtcars")),
      uiOutput("vx"),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
       textOutput("dataName"),
       verbatimTextOutput("structure"),
       textOutput("varName"),
       verbatimTextOutput("summary"),
       plotOutput("Hist")
    )
  )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  dat <- reactive({
    get(input$dataset)
  })
  
  output$dataName <- renderText({
    paste("Structure of dataset: ", input$dataset)
  })
  
  output$structure <- renderPrint({
    str(dat())
  })
  # var <- reactive({switch(input$dataset,
  #                         "iris"=names(iris),
  #                         "mtcars"=names(mtcars)
  # )
  # })
  output$vx <- renderUI({
    selectInput("variablex", "Select variable", choices = names(dat()))
  })

  var <- reactive({
    dat()[, input$variablex]
  })
  
  output$varName <- renderText({
    paste("Summary of variable: ", input$variablex)
  })
  
  output$summary <- renderPrint({
    summary(var())
  })

  output$Hist <- renderPlot({
    bins <- seq(min(var()), max(var()), length.out = input$bins + 1)
    hist(var(),
         breaks = bins, 
         col = 'darkgray', 
         border = 'white',
         main = "", xlab = paste("Histogram of ", input$variablex),
         ylab="")
  })   
  
}


shinyApp(ui = ui, server = server)
