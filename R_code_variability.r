library(raster)
library(RStoolbox) 
library(ggplot2) 
library(patchwork)

# set working directory
setwd("/Users/alicegiacomelli/Desktop/lab/")

# importare immagine multispettrale 
# assegnazione
# sentinel: satellite con risoluzione 10m
sen <- brick("sentinel.png")
sen

# plot con ggRGB 
ggRGB(sen, 1, 2, 3, stretch="lin")
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

##### variabilità = deviazione standard #####

# variabilità in NIR 
nir <- sen[[1]]
nir 

