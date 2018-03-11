#cargar base de datos
data2015 <- read.csv("Datos/Accidentalidad_2015_depurada.csv", encoding="UTF-8")
data2016 <- read.csv("Datos/Accidentalidad_2016_depurada.csv", encoding="UTF-8")
data2017 <- read.csv("Datos/Accidentalidad_2017_depurada.csv")
data2017 <-data2017[,-c(1)]

library(shiny)
library(utf8)
library(shinythemes)
library(leaflet)
library(leaflet.extras)
library(rgdal)
library(raster)
library(shinycssloaders)
library(ggplot2)
library(plotly)

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
    BaseName <- paste("Accidentalidad_", input$AnioMapa, ".shp", sep="")
    BaseFull <- shapefile(BaseName, encoding="UTF-8",use_iconv=TRUE)
    Base <- subset(BaseFull, BaseFull@data$GRAVEDAD==input$GravedadMapa) 
    
    
    #Paleta de colores
    #unique(Base$CLASE)
    #pal <-colorFactor(palette=rainbow(8),levels=unique(Base3$GRAVEDAD),ordered=F)
    
    #cbind(rainbow(8),unique(Base3$GRAVEDAD))
    
    popup<-paste(sep="<br/>","<font color='black'>",Base$BARRIO,"</font>",
                 "<font color='black'>",Base$COMUNA,"</font>")
    
    
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
  
  
  #######################################################################
  #Generacion del HISTOGRAMA:
  

  
  output$Histograma <- renderPlotly({
    
    BaseHist <- read.csv("Accidentalidad_161718.csv", encoding="UTF-8")
    
    var1 <- reactive({input$TipoAccidenteHist})
    var2 <- reactive({input$DiaHist})
    var3 <- reactive({input$GravedadHist})
    
    subsetBase1 <- reactive({
      if(var1() == "Todos")
      {
        BaseHist
      }
      else
      {
        subset(BaseHist, BaseHist$CLASE==var1())
      }
      
    })
    
    subsetBase2 <- reactive({
      
      if(var2() == "Todos")
      {
        subsetBase1()
      }
      else
      {
        subset(subsetBase1(), subsetBase1()$DIA==var2())
      }
      
    })
    
    subsetBase3 <- reactive({
      
      if(var3() == "Todos")
      {
        subsetBase2()
      }
      else
      {
        subset(subsetBase2(), subsetBase2()$GRAVEDAD==var3())
      }
      
    })
    
    validate(
      need(subsetBase3()$HORA, 'No hay datos registrados para las entradas seleccionadas.')
    )
    
    y<- hist(subsetBase3()$HORA)$counts
    x<-levels(subsetBase3()$HORA)
    

    
    
    plot_ly(data= subsetBase3(), 
            x = x, 
            y = y,
            type = 'scatter', main= "Histograma **", symbols=~42,
            mode = 'lines', color = I("red"), alpha = 0.7, 
            symbol=5)%>%layout(title = "Hora vs Cantidad, Accidentes en Ciudad de Medellín",
                               autosize = T,
                               showlegend = F)%>%layout(xaxis = list(title="Hora de Accidente"),
                                                        yaxis= list(title="Cantidad de Accidente")) %>%layout(xaxis = list(
                                                          autotick = F,
                                                          ticks = "outside",
                                                          tick0 = 0,
                                                          dtick = 1,
                                                          ticklen = 1,
                                                          tickwidth = 1,
                                                          tickcolor = toRGB("black")))
    
  })
  
})
