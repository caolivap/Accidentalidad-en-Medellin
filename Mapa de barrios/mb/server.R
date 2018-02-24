library(rgdal)
library(leaflet)
library(leaflet.extras)
library(raster)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$mapb <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    base1 <- shapefile("Accidentalidad_2017.shp",encoding="UTF-8",use_iconv=TRUE) 
    
    
    # draw the histogram with the specified number of bins
    
    
  })
  
})
