# Librerias necesarias 

library(rgdal)
library(leaflet)
library(raster)
library(shiny)
library(leaflet.extras)


shinyServer(function(input, output) {
  Map <- reactive({
  BaseName <- paste("Accidentalidad_", input$Anio, ".shp", sep="")
  BaseFull <- shapefile(BaseName, encoding="UTF-8",use_iconv=TRUE)
  Base <- subset(BaseFull, BaseFull@data$CLASE==input$TipoAccidente) 

  
  #Paleta de colores
  unique(Base$CLASE)
  pal <-colorFactor(palette=rainbow(8),levels=unique(Base$GRAVEDAD),ordered=F)
  
  cbind(rainbow(8),unique(Base$GRAVEDAD))
  
  popup<-paste(sep="<br/>", Base$BARRIO, Base$COMUNA)
  
  
  m<-leaflet()
  m<-fitBounds(m, lng1=min(Base@coords[,1]), 
               lat1=min(Base@coords[,2]), 
               lng2=max(Base@coords[,1]),
               lat2=max(Base@coords[,2]))
  m<-addProviderTiles(m,provider="OpenStreetMap.Mapnik")
  m<-addCircleMarkers(m,
                      lng = Base@coords[,1],
                      lat = Base@coords[,2],
                      popup = popup, 
                      radius = 5, 
                      stroke = FALSE,
                      color=pal(Base$GRAVEDAD),
                      fillOpacity = 0.75
  )
  m <- addLegend(m, "bottomright", pal = pal, values = Base@data$GRAVEDAD,
                 title = "Gravedad",
                 labels = Base@data$GRAVEDAD, opacity = 1)
  
  })
  output$Mapa2017 <- renderLeaflet({
    Map()
  })
  
  
})
