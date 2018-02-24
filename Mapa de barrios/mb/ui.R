library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Give the page a title
  titlePanel("Accidentes por barrio"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("tipoAccidente", "Tipo de Accidente:", 
                  choices=c("Atropello", "Otro")),
      hr()
      ),
    
    # Create a spot for the barplot
    mainPanel(
      leafletOutput("mapb")  
    )
    
  )
))
