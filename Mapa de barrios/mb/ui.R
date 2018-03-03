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
    
      selectInput("tipoAccidente", "Tipo de Accidente:", 
                  choices=c("Atropello", "Caida ocupante",
                            "Choque", "Incendio", "Otro", "Volcamiento")),
      hr()
      ),
    
    # Create a spot for the barplot
    mainPanel(

      leafletOutput("mapb")  

    )
    
  )
))
