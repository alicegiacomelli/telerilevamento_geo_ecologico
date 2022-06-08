# R code variability 2 - Using PC components

library(raster)
library(RStoolbox)
library(ggplot2) 
library(patchwork)
library(viridis)

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/")

# importazione immagine con brick 
# assegnazione
sen <- brick("sentinel.png")
sen

# plot immagine
# NIR = banda 1
# red = banda 2
# green = banda 3
 
# strecht automatico 
ggRGB(sen, 1, 2, 3)

# visualizzazione con vegetazione verde fluorescente e suolo nudo viola 
# NIR sulla componente g 
ggRGB(sen, 2, 1, 3)

# analisi multivariata 
# pca
# assegnazione 
# no ricampionamento perchè immagine leggera 
sen_pca <- rasterPCA(sen)
sen_pca

# $call - funzione che abbiamo ultilizzato 
# $model - modello da utilizzare, grafico con bande 
# $map - mappa finale 

# summery del modello
# variabilità, quante informazioni contiene il primo modello 
summary(sen_pca$model)
# Proportion of Variance: componente 1 tot %, componente 2 tot %
# componente 3 solo rumore 
# Cumulative Proportion: somma 1 + 2
# noi ci accontentiamo solo della prima componente cumulativa 

# plot mappa 
plot(sen_pca$map)

# ggplot vuoto + geometria raster (componente 1 = pc1)

# come scrivere componenti:
pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3

g1 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))
# aestetic : x corrisponde a x immagine, uguale y, fill è la componente 1
# assegnazione per patchwork

g2 <- ggplot() +
geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))

g3 <- ggplot() +
geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC3))
# g3 solo rumore 

#library(patchwork)
g1 + g2 + g3

# deviazione standard 
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
sd3
# matrice 3*3, quindi 1/9

# mappare con ggplot la deviazione standard della componente 1 
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) 
# names mappa: layer > fill=layer 

# colore viridis
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()

# cividis
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="cividis")

# inferno 
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

# plottare insieme 
# assegnazione 
im1 <- ggRGB(sen, 2, 1, 3)

im2 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

im3 <- ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

# patchwork
im1 + im2 + im3

# calcolo variabilità con finestra 5*5
# aumento finestra di calcolo = aumenta varibilità 
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd)
# matrice 5*5
# singolo pixel 1 su 25 

im4 <- ggplot() +
geom_raster(sd5, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

im3 + im4

# aumento finestra di calcolo = aumenta varibilità 


