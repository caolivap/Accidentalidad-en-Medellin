# Librerias necesarias 
library(lubridate)
library(ggplot2)
library(plotly)


#base$HORA <- hour(hm(base$HORA))

shinyServer(function(input, output) {
  
  base <- read.csv("Accidentalidad_161718.csv", encoding="UTF-8")
  
  
  output$Histograma <- renderPlotly({
    
    var1 <- reactive({input$TipoAccidente})
    var2 <- reactive({input$Dia})
    var3 <- reactive({input$Gravedad})
    
    subsetBase1 <- reactive({
      if(var1() == "Todos")
      {
        base
      }
      else
      {
        subset(base, base$CLASE==var1())
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
    
    Cantidad_accidentes<- hist(subsetBase3()$HORA)$counts
    Hora_de_accidente<-levels(subsetBase3()$HORA)
    
    validate(
      need(subsetBase3()$HORA, 'No hay datos registrados para las entradas seleccionadas.')
    )

    
    plot_ly(data= subsetBase3(), 
            #x = ~Hora_de_accidente,
            x = Hora_de_accidente, 
            y = Cantidad_accidentes,
            type = 'scatter', symbols=~42,
            mode = 'lines', color = I("red"), alpha = 0.7,
            symbol=5) %>% 
      layout(title = "Accidentes en Ciudad de Medellín",
             autosize = T,
             showlegend = FALSE)

  })
  
})
