library(raster)       # gestione immagini raster
library(ggplot2)      # visualizzazione dati in modo potente (grafici)
library(viridis)      # scale di colore
library(RStoolbox)    # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(patchwork)    # unire più plot di ggplot

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/ex")

# creo una lista con pattern in comune =  1997
list97 <- list.files(pattern="1997")
# importo con la funzione raster lapply
import97 <- lapply(list97, raster)
# unisco componenti della list96 in un unico blocco con la funzione raster stack
landsat97 <- stack(import97) 
landsat97
# plotto bande separate 
plot(landsat97)
# plotto immagine RGB per vedere più bande nella stessa immagine con ggplot
l97 <- ggRGB(landsat97, 4, 3, 2, stretch="hist")
l97

# 2001

# importare bande scaricate separatamente in una unica immagine
# stesse operazioni importazione precedente

# pattern in comune =  2001
list01 <- list.files(pattern="2001")

import01 <- lapply(list01, raster)

landsat01 <- stack(import01) 
landsat01

plot(landsat01)

l01 <- ggRGB(landsat01, 4, 3, 2, stretch="hist")
l01

# confronto 
l97 / l01

# dvi 

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 

dvi97 <- l97[[4]] - l97[[3]]
plot(dvi97)

# 2001
dvi01 <- l01[[4]] - l01[[3]]
plot(dvi01, col=cl)

























l97
drawExtent(show=TRUE, col="red")

# class      : Extent 
xmin       : 0.4648097 
xmax       : 0.5953265 
ymin       : 0.7265851 
ymax       : 0.8426979 

land_ext <- extent(c(0.4648097, 0.5953265, 0.7265851, 0.8426979))

land97 <- crop(landsat97, land_ext)


