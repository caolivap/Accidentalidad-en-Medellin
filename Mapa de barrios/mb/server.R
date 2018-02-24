library(rgdal)
library(leaflet)
library(leaflet.extras)
library(raster)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$mapb <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    Base3 <- shapefile("Accidentalidad_2017.shp",encoding="UTF-8",use_iconv=TRUE) 
    Base3@data <- na.omit(Base3@data)
    
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
    
    # draw the histogram with the specified number of bins
    
    
  })
  
})
