library(lubridate)

base <- read.csv("Accidentalidad_2017.csv", encoding="UTF-8")
base <- base[-c(1,2,3,4,5,8,10,11,12,13,15,16,17)]


shinyUI(fluidPage(
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "TipoAccidente",
                  label = "Tipo de Accidente:",
                  choices = base$CLASE,
                  base$CLASE[0]),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "Dia",
                  label = "Dia:",
                  choices = levels(base$DIA),
                  levels(base$DIA)[0]),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "Gravedad",
                  label = "Gravedad:",
                  choices = levels(base$GRAVEDAD),
                  levels(base$GRAVEDAD)[0]
                  )
      

      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      plotOutput(outputId = "Histograma")
      
    )
  )
 
))
