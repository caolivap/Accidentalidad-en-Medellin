
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
                            sidebarLayout(
                              
                              # Sidebar panel for inputs ----
                              sidebarPanel(
                                
                                # Input: Select a dataset ----
                                selectInput("dataset", "Escoge el aÃ±o:",
                                            choices = c("2015", "2016", "2017")),
                                
                                # Input: Specify the number of observations to view ----
                                numericInput("obs", "NÃºmero de observaciones que quieres ver:", 10),
                                
                                # Include clarifying text ----
                                helpText("
                                         Nota: aunque la vista de datos mostrara solo el numero especificado de observaciones,
                                         el resumen seguira basandose en el conjunto de datos completo."),
                                
                                # Input: actionButton() to defer the rendering of output ----
                                # until the user explicitly clicks the button (rather than
                                # doing it immediately when inputs change). This is useful if
                                # the computations required to render output are inordinately
                                # time-consuming.
                                actionButton("update", "Actualizar")
                                
                              ),
                              # Main panel for displaying outputs ----
                              mainPanel(
                                
                                # Output: Header + summary of distribution ----
                                h4("Summary"),
                                verbatimTextOutput("summary"),
                                tags$video(HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/6F5_jbBmeJU" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>')),
                                # Output: Header + table of distribution ----
                                h4("Observaciones"),
                                tableOutput("view")
                              )
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
                   
                   tabPanel("Historial",
                            
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
                              #tags$video(src = "Datos/video.mp4", type = "video/mp4", width = "500px", height = "500px", autoplay = NA, controls = NA),
                              #knitr::include_graphics('img.jpg'), 
                              #tagList(tags$img(src = 'img.jpg', width = "500px", height = "500px")),#$img(src = 'img.jpg', width = "500px", height = "500px"),
                              #uiOutput("video")
                              #tags$video(HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/6F5_jbBmeJU" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>'))
                              tags$img(src = "img.jpg", width = "200px", height = "200px")
                            )
                   )
                   
)
)

