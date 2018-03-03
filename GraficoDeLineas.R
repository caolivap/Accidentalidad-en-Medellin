data2015 <- read.csv("Datos/Accidentalidad_2015_depurada.csv")
data2016 <- read.csv("Datos/Accidentalidad_2016_depurada.csv")
data2017 <- read.csv("Datos/Accidentalidad_2017_depurada.csv")


plot(cars$dist, main = "Distancias de...", 
     ylab = "distancia en pies")
lines(cars$dist)
grid()

library(lubridate)
horas2015 <- hour(hm(data2015$HORA))

Rango1 <- rep(0,23)
for (i in 1:length(horas2015)) if (hour(horas2015[i]) == 0){
                                Rango1[1] <- Rango1[1] + 1
                                }else if(hour(horas2015[i]) == 1){
                                  Rango1[2] <- Rango1[2] + 1
                                }else if(hour(horas2015[i]) == 2){
                                  Rango1[3] <- Rango1[3] + 1
                                }else if(hour(horas2015[i]) == 3){
                                  Rango1[4] <- Rango1[4] + 1
                                  }else if(hour(horas2015[i]) == 4){
                                  Rango1[5] <- Rango1[5] + 1
                                  }else if(hour(horas2015[i]) == 5){
                                  Rango1[6] <- Rango1[6] + 1
                                  }else if(hour(horas2015[i]) == 6){
                                  Rango1[7] <- Rango1[7] + 1
                                  }else if(hour(horas2015[i]) == 7){
                                  Rango1[8] <- Rango1[8] + 1
                                  }else if(hour(horas2015[i]) == 8){
                                  Rango1[9] <- Rango1[9] + 1
                                  }else if(hour(horas2015[i]) == 9){
                                  Rango1[10] <- Rango1[10] + 1
                                  }else if(hour(horas2015[i]) == 10){
                                  Rango1[11] <- Rango1[11] + 1
                                  }else if(hour(horas2015[i]) == 11){
                                  Rango1[12] <- Rango1[12] + 1
                                  }else if(hour(horas2015[i]) == 12){
                                  Rango1[13] <- Rango1[13] + 1
                                  }else if(hour(horas2015[i]) == 13){
                                  Rango1[14] <- Rango1[14] + 1
                                  }else if(hour(horas2015[i]) == 14){
                                  Rango1[15] <- Rango1[15] + 1
                                  }else if(hour(horas2015[i]) == 15){
                                  Rango1[16] <- Rango1[16] + 1
                                  }else if(hour(horas2015[i]) == 16){
                                  Rango1[17] <- Rango1[17] + 1
                                  }else if(hour(horas2015[i]) == 17){
                                  Rango1[18] <- Rango1[18] + 1
                                  }else if(hour(horas2015[i]) == 18){
                                  Rango1[19] <- Rango1[19] + 1
                                  }else if(hour(horas2015[i]) == 19){
                                  Rango1[20] <- Rango1[20] + 1
                                  }else if(hour(horas2015[i]) == 20){
                                  Rango1[21] <- Rango1[21] + 1
                                  }else if(hour(horas2015[i]) == 21){
                                  Rango1[22] <- Rango1[22] + 1
                                  }else if(hour(horas2015[i]) == 22){
                                  Rango1[23] <- Rango1[23] + 1
                                  }else if(hour(horas2015[i]) == 23){
                                  Rango1[3] <- Rango1[23] + 1
                                  }



hist(horas2015)
lines(hist(horas2015)$counts, type = "overplotted", pch=1, main = "Cantidad accidentes")
lines(hist(horas2015)$counts, type = "overplotted", pch=1, main = "Cantidad accidentes", col="red")
lines(hist(horas2015)$counts, type = "overplotted", pch=2, main = "Cantidad accidentes", col="red")

