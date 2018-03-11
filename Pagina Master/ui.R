
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

shinyUI(navbarPage(theme = shinytheme("superhero"), title =  "ACCIDENTALIDAD EN MEDELLIN",
                   tabPanel("Inicio",
                            
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
                                                    gravemente en accidentes en la ciudad", br(), br(), br(),
                                                    h4("Visita nuestro video tutorial y aprende el manejo de la página, haciendo ", a(href="https://biteable.com/watch/accidentalidad-1791081/", "Click aquí!"))
                                                )
                                          )
                   ),
                   tabPanel("Mapa",
                            
                            column(2,
                                   wellPanel(
                                     selectInput("GravedadMapa", "Gravedad del accidente",
                                                 c("HERIDO","MUERTO", "SOLO DAÃOS"), BaseFull$GRAVEDAD[0]
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
                            
                   )
                   
)
)

