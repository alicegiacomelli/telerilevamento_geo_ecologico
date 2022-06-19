# R code for multivariate analysis

# compattare sistema multidimensionale in un numero minore di variabili
# una sola dimensione 
# valori pixel su sistema cartesiano, dove c'è maggior variabilità si fa passare PC1 (componente principale)
# secondo asse perpendicolare e spiega altra variabile 

# librerie
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)


# set working directory
("/Users/alicegiacomelli/Desktop/lab/") 

# immagine landsat con 7 bande 
# risoluzione 30m 

# Bande Landsat
# B1: blue
# B2: green
# B3: red
# B4: NIR
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# importazione tramite brick (più bande)
# assegnazione
p224r63_2011 <- brick("p224r63_2011_masked.grd")

# plotto immagine
plot(p224r63_2011)

# ricampionamento: resampling
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

g1 <- ggRGB(p224r63_2011, 4,3,2)
g2 <- ggRGB(p224r63_2011res, 4,3,2)

g1+g2

# aggressive resampling 
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)
# fact = 100 compatta 100 pixel insieme
# risoluzione 300m 

# confronto le immagini 
g1 <- ggRGB(p224r63_2011, 4,3,2)
g2 <- ggRGB(p224r63_2011res, 4,3,2)
g3 <- ggRGB(p224r63_2011res100, 4,3,2)

g1+g2+g3

# PCA principal component analisy
# funzione rasterPCA (r tiene conto delle maiuscole)
p224r63_2011respca <- rasterPCA(p224r63_2011res)

# $call = funzione che abbiamo utilizzato
# $model = modello, correlazione tra le bande
# $map = oggetto raster

summary(p224r63_2011respca$model)

# plot
plot(p224r63_2011respca$map)


# pacchetto viridis 
# ggplot

g1 <- ggplot() + 
geom_raster(p224r63_2011respca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g2 <- ggplot() + 
geom_raster(p224r63_2011respca$map, mapping=aes(x=x, y=y, fill=PC7)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC7")

# visualizzazione
g1+g2

g3 <- ggplot() + 
geom_raster(p224r63_2011res, mapping=aes(x=x, y=y, fill=B4_sre)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("NIR")

# visualizzazione 
g1+g3

g4 <- ggRGB(p224r63_2011, 2, 3, 4, stretch="hist")

g1+g4

plotRGB(p224r63_2011respca$map, 1, 2, 3, stretch="lin")
plotRGB(p224r63_2011respca$map, 5, 6, 7, stretch="lin")



