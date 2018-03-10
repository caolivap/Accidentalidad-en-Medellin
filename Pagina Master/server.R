#cargar base de datos
data2015 <- read.csv("Datos/Accidentalidad_2015_depurada.csv")
data2016 <- read.csv("Datos/Accidentalidad_2016_depurada.csv")
data2017 <- read.csv("Datos/Accidentalidad_2017_depurada.csv")


library(shiny)
library(utf8)
library(shinythemes)
library(leaflet)
library(leaflet.extras)
library(rgdal)
library(raster)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
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
    dataset<- dataset[,-c(1:5,8,10:13,15)]
    summary(dataset)
  })
  
  #######################################################################
  #Generacion del Mapa:
  
  Map <- reactive({
    BaseName <- paste("Accidentalidad_", input$Anio, ".shp", sep="")
    BaseFull <- shapefile(BaseName, encoding="UTF-8",use_iconv=TRUE)
    Base <- subset(BaseFull, BaseFull@data$GRAVEDAD==input$Gravedad) 
    
    
    #Paleta de colores
    #unique(Base$CLASE)
    #pal <-colorFactor(palette=rainbow(8),levels=unique(Base3$GRAVEDAD),ordered=F)
    
    #cbind(rainbow(8),unique(Base3$GRAVEDAD))
    
    popup<-paste(sep="<br/>", Base$BARRIO, Base$COMUNA)
    
    
    m<-leaflet()
    m<-fitBounds(m, lng1=min(Base@coords[,1]), 
                 lat1=min(Base@coords[,2]), 
                 lng2=max(Base@coords[,1]),
                 lat2=max(Base@coords[,2]))
    m<-addProviderTiles(m,provider="OpenStreetMap.Mapnik")
    m<- addMarkers(m,
                   lng = Base@coords[,1],
                   lat = Base@coords[,2],
                   popup = popup, 
                   clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = T))
    
  })
  output$Mapa <- renderLeaflet({
    Map()
  })
  
})
