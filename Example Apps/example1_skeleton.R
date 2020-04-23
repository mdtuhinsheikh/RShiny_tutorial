library(shiny)

ui <- fluidPage(
  titlePanel(title = "This is my first shiny app, hello shiny!"),
  sidebarLayout(
    sidebarPanel(h3("this is a side bar"), h4("widget4"), h5("widget5")),
    mainPanel(h4("this is the main panel text"),
              h5("this is the output"))
  )
)


server <- function(input, output){
    
}


shinyApp(ui = ui, server = server)
