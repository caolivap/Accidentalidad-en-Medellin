
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
library(utf8)

#Base de datos para el MAPA ##################
BaseFull <- shapefile("Accidentalidad_2017.shp",encoding="UTF-8",use_iconv=TRUE)

#Base de datos para el Historial
BaseHist <- read.csv("Accidentalidad_161718.csv", encoding="UTF-8")


# Define UI for application that draws a histogram
shinyUI(navbarPage(theme = shinytheme("superhero"), title =  "ACCIDENTALIDAD EN MEDELLIN",
                   tabPanel("Inicio",
                            # App title ----
                            #titlePanel("Resumen Descriptivo"),
                            
                            # Sidebar layout with input and output definitions ----
                            titlePanel(p(em("Bienvenidos a nuestra aplicacion"))),
                            sidebarLayout(position="left",
                                          sidebarPanel(h4("Universidad Nacional de Colombia",br(),
                                                          "Sede Medellin"),br(),
                                                       img(src="unal.png",height = 150, width = 150),br(),br(),
                                                       em("Desarrollado por:"),br(),
                                                       "Caicedo Chamorro Edwin Alexander",br(),
                                                       "Lopez Velez Eliana Maria",br(),
                                                       "Oliva Paredes Carlos Armando",br(),
                                                       "Ramirez Echeverri Juan Pablo",br(),
                                                       "Toro Zuluaga Santiago"),
                                          mainPanel(h2("Enfoque de la Aplicacion"),br(),"Medellín es una de las ciudades
                                                    donde la mayoría de personas tienen transporte particular, ya sea moto o carro, pero son muy 
                                                    pocas las personas que acatan todas las normas y son responsables a la hora de hacer uso de este.
                                                    Con esta aplicación se busca dar una guía para hacer más eficiente la distribución actual de 
                                                    servicios de primeros auxilios prestados por la Secretaria de Salud a las personas afectadas 
                                                    gravemente en accidentes en la ciudad")
                                          
                                          )
                   ),
                   tabPanel("Mapa",
                            
                            column(2,
                                   wellPanel(
                                     selectInput("GravedadMapa", "Gravedad del accidente",
                                                 c("HERIDO","MUERTO", "SOLO DAÑOS"), BaseFull$GRAVEDAD[0]
                                     ),
                                     selectInput("AnioMapa", "Anio",
                                                 c("2015", "2016", "2017"), "2017"
                                     )
                                   )       
                            ),
                            
                            column(10,
                                   withSpinner(leafletOutput("Mapa"))
                            )
                            
                   ),
                   
                   tabPanel("Histograma",
                            
                            column(2,
                                   # Input: Selector for choosing dataset ----
                                   selectInput(inputId = "TipoAccidenteHist",
                                               label = "Tipo de Accidente:",
                                               choices = c(levels(BaseHist$CLASE), "Todos"),
                                               selected = "Todos"),
                                   
                                   # Input: Selector for choosing dataset ----
                                   selectInput(inputId = "DiaHist",
                                               label = "Dia:",
                                               choices = c(levels(BaseHist$DIA), "Todos"),
                                               selected = "Todos"),
                                   
                                   # Input: Selector for choosing dataset ----
                                   selectInput(inputId = "GravedadHist",
                                               label = "Gravedad:",
                                               choices = c(levels(BaseHist$GRAVEDAD), "Todos"),
                                               selected = "Todos"
                                   )    
                            ),
                            
                            column(10,
                                   plotlyOutput("Histograma")
                            )
                            
                   ),
                   
                   
                   tabPanel("Video",
                            mainPanel(
                              #tags$video(src = "video.mp4", controls = "controls")
                              tags$video(src = "www/video.mp4", type = "video/mp4", width = "500px", height = "500px", autoplay = NA, controls = NA),
                              #knitr::include_graphics('img.jpg'), 
                              #tagList(tags$img(src = 'img.jpg', width = "500px", height = "500px")),#$img(src = 'img.jpg', width = "500px", height = "500px"),
                              #uiOutput("video")
                              #tags$video(HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/6F5_jbBmeJU" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>')),
                              #tags$video(HTML('<iframe frameborder="0" width="560" height="315" src="https://biteable.com/watch/embed/accidentalidad-1791081" allowfullscreen="true"></iframe><p><a href="https://biteable.com/watch/accidentalidad-1791081">Accidentalidad</a> on <a href="https://biteable.com">Biteable</a>.</p>')),
                              tags$img(src = "img.jpg", width = "200px", height = "200px")
                            )
                   )
                   
)
)

