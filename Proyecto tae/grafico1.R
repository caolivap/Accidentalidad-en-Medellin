library(lubridate)
base <- read.csv("Accidentalidad_2015.csv", encoding="UTF-8")
base <- base[-c(1,2,3,4,5,8,10,11,12,13,15,16,17)]
base$HORA <- hour(hm(base$HORA))

library(lubridate)

baseclase <- subset(base, base$CLASE=="Choque")
basedia <- subset(base, base$DIA=="MIERCOLES")
basegravedad <- subset(base, base$GRAVEDAD=="HERIDO")


hist(horas2015)
lines(hist(horas2015)$counts, type = "overplotted", pch=1, main = "Cantidad accidentes")
lines(hist(horas2015)$counts, type = "overplotted", pch=1, main = "Cantidad accidentes", col="red")
lines(hist(horas2015)$counts, type = "overplotted", pch=2, main = "Cantidad accidentes", col="red")