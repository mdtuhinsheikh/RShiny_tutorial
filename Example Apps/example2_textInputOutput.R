library(shiny)

ui <- fluidPage(
  titlePanel(title = "Text Input-Output app"),
  sidebarLayout(
    sidebarPanel(
                 textInput("name", "Type your name")
    ),
    mainPanel(
              paste("My name is"),
              textOutput("nameout")
    )
  )
)


server <- function(input, output){
    output$nameout <- renderText({
      paste(input$name)
    })
}


shinyApp(ui = ui, server = server)
