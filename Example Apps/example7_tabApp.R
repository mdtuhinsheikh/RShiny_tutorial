library(shiny)
library(ggplot2)
require(gridExtra)

ui <- fluidPage(
  titlePanel(title = "Shiny app with tabs"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "select data", 
                  choices = c("iris", "mtcars")),
      uiOutput("vx"),
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      radioButtons("color", "select color", 
                   choices = c("Green", "Red", "Yellow"), 
                   selected = "Green")      
    ),
    mainPanel(
      tabsetPanel(type = "tab",
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Structure", verbatimTextOutput("str")),
                  tabPanel("Data", tableOutput("data")),
                  tabPanel("Plot", plotOutput("Hist"))
      )
    )
  )
)




server <- function(input, output) {
  dat <- reactive({
    get(input$dataset)
  })

  output$vx <- renderUI({
    selectInput("variablex", "Select variable", choices = names(dat()))
  })
  
  output$str <- renderPrint({
    str(dat())
  })  
  
  output$summary <- renderPrint({
    summary(dat())
  })  

  output$data <- renderTable({
    head(dat())
  })  
    
  # 
  var <- reactive({
    dat()[, input$variablex]
  })

  output$Hist <- renderPlot({
    bins <- seq(min(var()), max(var()), length.out = input$bins + 1)
    hist(var(),
         breaks = bins,
         col = input$color,
         border = 'white',
         main = "", xlab = paste("Histogram of ", input$variablex),
         ylab="")
  })
  
}


shinyApp(ui = ui, server = server)
