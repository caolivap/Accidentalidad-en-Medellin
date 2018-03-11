library(lubridate)
library(ggplot2)
library(plotly)

base <- read.csv("Accidentalidad_161718.csv", encoding="UTF-8")


shinyUI(fluidPage(
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "TipoAccidente",
                  label = "Tipo de Accidente:",
                  choices = c(levels(base$CLASE), "Todos"),
                  selected = "Todos"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "Dia",
                  label = "Dia:",
                  choices = c(levels(base$DIA), "Todos"),
                  selected = "Todos"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "Gravedad",
                  label = "Gravedad:",
                  choices = c(levels(base$GRAVEDAD), "Todos"),
                  selected = "Todos"
                  )
      

      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      plotlyOutput("Histograma")
      
    )
  )
 
))
