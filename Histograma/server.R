# Librerias necesarias 
library(lubridate)



shinyServer(function(input, output) {
  
  base <- read.csv("Accidentalidad_2015.csv", encoding="UTF-8")
  base <- base[-c(1,2,3,4,5,8,10,11,12,13,15,16,17)]
  base$HORA <- hour(hm(base$HORA))
  
  output$Histograma <- renderPlot({

    base <- subset(base, base$CLASE==input$TipoAccidente)
    base <- subset(base, base$DIA==input$Dia)
    base <- subset(base, base$GRAVEDAD==input$Gravedad)
    
    validate(
      need(base$HORA, 'No hay datos registrados para las entradas seleccionadas.')
    )
    
    hist(base$HORA)

  })
  
})
