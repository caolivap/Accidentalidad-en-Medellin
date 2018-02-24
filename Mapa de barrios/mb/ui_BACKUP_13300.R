library(shiny)
library(leaflet)
library(leaflet.extras)
library(rgdal)
library(raster)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Give the page a title
  titlePanel("Accidentes por barrio"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
<<<<<<< HEAD
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
=======
      selectInput("tipoAccidente", "Tipo de Accidente:", 
                  choices=c("Atropello", "Otro")),
      hr()
      ),
>>>>>>> c071e4f84dcc3bd2edecbe94b0ba90f9bd1b45b4
    
    # Create a spot for the barplot
    mainPanel(
<<<<<<< HEAD
      plotOutput("mapd")
=======
      leafletOutput("mapb")  
>>>>>>> c071e4f84dcc3bd2edecbe94b0ba90f9bd1b45b4
    )
    
  )
))
