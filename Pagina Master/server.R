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
  
  # generate bins based on input$bins from ui.R
  Base3 <- shapefile("Accidentalidad_2017.shp", encoding="UTF-8", use_iconv=TRUE) 
  
  unique(Base3@data$CLASE)
  pal <-colorFactor(palette=rainbow(8),levels=unique(Base3@data$CLASE),ordered=F)
  
  popup<-paste(Base3@data$CLASE,Base3@data$BARRIO,sep="<br/>")
  
  cbind(rainbow(8),unique(Base3@data$CLASE))
  
  popup<-paste(Base3@data$CLASE,Base3@data$BARRIO,sep="<br/>")
  
  m<-leaflet()
  m<-fitBounds(m, lng1=min(Base3@coords[,1]), 
               lat1=min(Base3@coords[,2]), 
               lng2=max(Base3@coords[,1]),
               lat2=max(Base3@coords[,2]))
  m<-addProviderTiles(m,provider="OpenStreetMap.Mapnik")
  m<-addCircleMarkers(m,
                      lng = Base3@coords[,1],
                      lat = Base3@coords[,2],
                      popup = popup, 
                      radius = 2, 
                      stroke = FALSE,
                      color=pal(Base3@data$CLASE),
                      fillOpacity = 0.75
  )
  m<-addLegend(m,"topright",pal=pal,values=Base3@data$CLASE, 
               title="Tipo de accidente",
               labels = Base3@data$CLASE,opacity = 1)
  m
  
  
  output$mapb <- renderLeaflet({
    m
  })
  
})
