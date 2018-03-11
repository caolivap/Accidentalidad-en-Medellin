datost<- read.csv("C:/Users/Eliana/Desktop/TAE/Prueba/Scripts R/datost.csv")



library(ggplot2)
library(plotly)

datost <- subset(datost, datost$CLASE=="Atropello")
datost <- subset(datost, datost$DIA=="DOMINGO")
datost <- subset(datost, datost$GRAVEDAD=="Muerto")

Cantidad_accidentes<- hist(datost$HORA)$counts
Hora_de_accidente<-c(1:23)

plot_ly(data= datost, 
        x = ~Hora_de_accidente,
        y = ~Cantidad_accidentes,
        xlab= "Hora de accidente",
        ylab= "Cantidad de accidente",
        type = 'scatter', main= "Histograma **", symbols=~42,
        mode = 'lines', color = I("red"), alpha = 0.7, 
        symbol=5) %>% 
        layout(title = "Accidentes en Ciudad de Medellín",
                          autosize = T,
                          showlegend = FALSE)

