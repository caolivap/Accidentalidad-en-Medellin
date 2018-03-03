library(shiny)
library(leaflet)
library(leaflet.extras)
library(rgdal)
library(raster)

Base3 <- shapefile("Accidentalidad_2017.shp",encoding="UTF-8",use_iconv=TRUE)
#Base <- subset(Base3, Base3@data$CLASE=="Choque")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  leafletOutput("Mapa2017"),
  absolutePanel(top = 10, right = 10,

        selectInput("TipoAccidente", "Tipo de Accidente",
          Base3$CLASE, Base3$CLASE[0]
                ),
        selectInput("Anio", "Anio",
                    c("2015", "2016", "2017"), "2017"
        )

  )
  
))
