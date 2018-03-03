# Librerias necesarias 



shinyServer(function(input, output) {
  
  library(rgdal)
  library(leaflet)
  library(leaflet.extras)
  library(raster)
  library(shiny)
  
    # generate bins based on input$bins from ui.R
    Base1 <- shapefile("Accidentalidad_2015.shp",encoding="UTF-8",use_iconv=TRUE) 
    Base <- subset(Base1, Base1@data$CLASE=="tipoAccidente")
    unique(Base@data$CLASE)
    pal <-colorFactor(palette=rainbow(8),levels=unique(Base@data$CLASE),ordered=F)
    
    popup<-paste(Base@data$CLASE,Base@data$BARRIO,sep="<br/>")
    
    cbind(rainbow(8),unique(Base@data$CLASE))
    
    popup<-paste(Base@data$CLASE,Base@data$BARRIO,sep="<br/>")
    
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
                        radius = 2, 
                        stroke = FALSE,
                        color=pal(Base@data$CLASE),
                        fillOpacity = 0.75
    )
    m<-addLegend(m,"topright",pal=pal,values=Base@data$CLASE, 
                 title="Tipo de accidente",
                 labels = Base@data$CLASE,opacity = 1)
    m
    
    
    output$mapb <- renderLeaflet({
      m
    })
  
})
