############### ESAME TELERILEVAMENTO GEO-ECOLOGICO 2021/2022 ###############


# codice R per l'ANALISI MULTITEMPORALE DELLA RISERVA NATURALE DELL'INSTITUTO TERRA DAL 1996 AL 2011 


# librerie 
library(raster)       # gestione immagini raster
library(ggplot2)      # visualizzazione dati in modo potente (grafici)
library(viridis)      # scale di colore
library(RStoolbox)    # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(patchwork)    # unire più plot di ggplot

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/esame")



############### IMPORTAZIONE E VISUALIZZAZIONE IMMAGINI SATELLITARI ############### 

# dati ricavati dal satellite LANDSAT 5
# risoluzione 30 m 

# banda 1 = blue
# banda 2 = green 
# banda 3 = red
# banda 4 = NIR
# banda 5 = infrarosso medio SWIR 1
# banda 6 = infrarosso termico 
# banda 7 = infrarosso medio SWIR 2

# 1996

# importare bande scaricate separatamente in una unica immagine

# creo una lista con pattern in comune =  19961218
list96 <- list.files(pattern="19961218")
# importo con la funzione raster lapply
import96 <- lapply(list96, raster)
# unisco componenti della list96 in un unico blocco con la funzione raster stack
landsat96 <- stack(import96) 
landsat96
# plotto bande separate 
plot(landsat96)
# plotto immagine RGB per vedere più bande nella stessa immagine con ggplot
l96 <- ggRGB(landsat96, 4, 2, 1, stretch="hist")

# 2001

# importare bande scaricate separatamente in una unica immagine
# stesse operazioni importazione precedente

# pattern in comune =  20011029
list01 <- list.files(pattern="20011029")

import01 <- lapply(list01, raster)

landsat01 <- stack(import01) 
landsat01

plot(landsat01)

plotRGB(landsat01, r=4, g=1, b=2, stretch="lin") 
# l01 <- ggRGB(landsat01, 4, 2, 1, stretch="hist")

# 2006

# importare bande scaricate separatamente in una unica immagine
# stesse operazioni importazioni precedenti 

# pattern in comune = 20060824
list06 <- list.files(pattern="20060824")

import06 <- lapply(list06, raster)

landsat06 <- stack(import06) 
landsat06

plot(landsat06)

plotRGB(landsat06, r=4, g=1, b=2, stretch="lin") 
# l06 <- ggRGB(landsat06, 4, 2, 1, stretch="hist")

# 2011

# importare bande scaricate separatamente in una unica immagine
# stesse operazioni delle importazioni precedenti 

# pattern in comune = 20110907
list11 <- list.files(pattern="20110907")

import11 <- lapply(list11, raster)

landsat11 <- stack(import11) 
landsat11

plot(landsat11)

plotRGB(landsat11, r=4, g=1, b=2, stretch="lin") 
# l11 <- ggRGB(landsat96, 4, 2, 1, stretch="hist")

# tutte le immagini sono a 16 bit 
# hanno un numero di celle elevato, circa 60 milioni 

# RICAMPIONO le immagini per agevolare le analisi 
# attraverso la funzione aggregate 
# con fact=10 cioè compatta 10 pixel 

l96r <- aggregate(landsat96, fact=10)
l96r

l01r <- aggregate(landsat01, fact=10)
l01r

l06r <- aggregate(landsat06, fact=10)
l06r

l11r <- aggregate(landsat11, fact=10)
l11r

# risoluzione di tutte le immagini ricampionate = 300m 

# confronto immagine ricampionata e originale per controllo

g1_96 <- ggRGB(landsat96, 4, 3, 2)   # immagine originale 
g2_96 <- ggRGB(l96r, 4, 2, 1)        # immagine ricampionata 
g1_96 / g2_96                        # confronto

g1_01 <- ggRGB(landsat01, 4, 3, 2)   # immagine originale 
g2_01 <- ggRGB(l01r, 4, 2, 1)        # immagine ricampionata 
g1_01/ g2_01                         # confronto 

g1_06 <- ggRGB(landsat06, 4, 3, 2)   # immagine originale 
g2_06 <- ggRGB(l06r, 4, 2, 1)        # immagine ricampionata 
g1_06 / g2_06                        # confronto 

g1_11 <- ggRGB(landsat11, 4, 3, 2)   # immagine originale 
g2_11 <- ggRGB(l11r, 4, 2, 1)        # immagine ricampionata 
g1_11 / g2_11                        # confronto 

# CONFRONTO IMMAGINI RICAMPIONATE dei diversi anni 
g2_96 + g2_01 + g2_06 + g2_11


############### INDICI SPETTRALI ###############











    
