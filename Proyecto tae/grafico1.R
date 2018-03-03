library(lubridate)
library(plotly)
library(lubridate)
library()

base <- read.csv("Accidentalidad_2015.csv", encoding="UTF-8")
base <- base[-c(1,2,3,4,5,8,10,11,12,13,15,16,17)]
base$HORA <- hour(hm(base$HORA))



baseclase <- subset(base, base$CLASE=="Choque")
basedia <- subset(base, base$DIA=="MIERCOLES")
basegravedad <- subset(base, base$GRAVEDAD=="HERIDO")


plot_ly(base, x = ~base$HORA) %>% add_histogram(name = "plotly.js")

hist(base$HORA)
lines(hist(horas2015)$counts, type = "overplotted", pch=1, main = "Cantidad accidentes")
lines(hist(horas2015)$counts, type = "overplotted", pch=1, main = "Cantidad accidentes", col="red")
lines(hist(horas2015)$counts, type = "overplotted", pch=2, main = "Cantidad accidentes", col="red")

