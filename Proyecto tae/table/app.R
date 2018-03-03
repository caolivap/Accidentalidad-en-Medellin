data2015<- read.csv("Accidentalidad_2015.csv", encoding="UTF-8")
data2015 <- data2015[-c(1,2,3,4,5,8,10,11,12,13)]

data2016<- read.csv("Accidentalidad_2016.csv", encoding="UTF-8")
data2016 <- data2016[-c(1,2,3,4,5,8,10,11,12,13)]

data2017<- read.csv("Accidentalidad_2017.csv", encoding="UTF-8")
data2017 <- data2017[-c(1,2,3,4,5,8,10,11,12,13)]

library(shiny)
library(lubridate)

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Resumen Descriptivo"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a dataset ----
      selectInput("dataset", "Escoge el año:",
                  choices = c("2015", "2016", "2017")),
      
      # Input: Specify the number of observations to view ----
      numericInput("obs", "Nùmero de observaciones que quieres ver:", 10),
      
      # Include clarifying text ----
      helpText("
               Nota: aunque la vista de datos mostrará solo el número especificado de observaciones,
               el resumen seguirá basándose en el conjunto de datos completo."),
      
      # Input: actionButton() to defer the rendering of output ----
      # until the user explicitly clicks the button (rather than
      # doing it immediately when inputs change). This is useful if
      # the computations required to render output are inordinately
      # time-consuming.
      actionButton("update", "Actualizar")
      
      ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Header + summary of distribution ----
      h4("Summary"),
      verbatimTextOutput("summary"),
      
      # Output: Header + table of distribution ----
      h4("Observaciones"),
      tableOutput("view")
    )
    
    )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Return the requested dataset ----
  # Note that we use eventReactive() here, which depends on
  # input$update (the action button), so that the output is only
  # updated when the user clicks the button
  datasetInput <- eventReactive(input$update, {
    switch(input$dataset,
           "2015" = data2015,
           "2016" = data2016,
           "2017" = data2017)
  }, ignoreNULL = FALSE)
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- datasetInput()
    dataset<- dataset
    summary(dataset)
  })
  
  # Show the first "n" observations ----
  # The use of isolate() is necessary because we don't want the table
  # to update whenever input$obs changes (only when the user clicks
  # the action button)
  output$view <- renderTable({
    head(datasetInput(), n = isolate(input$obs))
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)