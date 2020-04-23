library(shiny)

ui <- fluidPage(
  titlePanel(title = "Select Input-Output app"),
  sidebarLayout(
    sidebarPanel(
                 textInput("name", "Type your name"),
                 selectInput("country", "Where do you from?",
                             choices = c("Bangladesh", "USA"),
                             selected = NULL)
    ),
    mainPanel(
              paste("My name is"),
              textOutput("nameout"),
              textOutput("country")
    )
  )
)


server <- function(input, output){
    output$nameout <- renderText({
      paste(input$name)
    })
    
    output$country <- renderText({
      paste("I am from ", input$country)
    })
}


shinyApp(ui = ui, server = server)
