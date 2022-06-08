library(raster) # gestione immagini 
library(RStoolbox) # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(ggplot2) # visualizzazione dati in modo potente 
library(patchwork) # unire più plot di ggplot 
library(viridis) # scale di colore 

# set working directory
setwd("/Users/alicegiacomelli/Desktop/lab/")

# importare immagine multispettrale 
# assegnazione
# sentinel: satellite con risoluzione 10m
sen <- brick("sentinel.png")
sen

# plot con ggRGB 
# banda 1 = NIR
# banda 2 = red
# banda 3 = green 
ggRGB(sen, r=1, g=2, b=3, stretch="lin")
# oppure 
ggRGB(sen, 1, 2, 3)
# stretch viene messo automaticamente 

# plot con bande diversificate
# NIR on g component
ggRGB(sen, 2, 1, 3)

# unire 2 plot, uno di fianco all'altro
g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)

# patchwork
g1 + g2

# unire 2 plot, uno sopra l'altro
g1/g2

# 4 plot
(g1+g2)/(g1+g2)

##### variabilità = deviazione standard #####

# variabilità in NIR 
nir <- sen[[1]]
nir 

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd
# nir : immagine
# matrice formata da 3*3 pixel, matrice : 1/9
# colonne : 3
# righe : 3
# funzione : deviazione standard sd      

# palette 
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)

# plot della variabilità con palette 
plot(sd3, col=clsd)
             
# plot ggplot
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))
# immagine : sd3
# colore : fill, strato che abbiamo calcolato quindi layer 

# viridis
# library(viridis)
# scale () senza argomento, legenda di default viridis             
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# cividis 
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")
             
# magma
# lavora anche su colorazioni intermedie 
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# inferno
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")
             
# stesso calcolo con finestra 7*7
# matrice 7             
sd7 <- focal(nir, w=matrix(1/49, 7, 7), fun=sd)
