############### ESAME TELERILEVAMENTO GEO-ECOLOGICO 2021/2022 ###############


# codice R per l'ANALISI MULTITEMPORALE DELLA RISERVA NATURALE DELL'INSTITUTO TERRA DAL 1996 AL 2011 


# librerie 
library(raster)       # gestione immagini raster
library(ggplot2)      # visualizzazione dati in modo potente (grafici)
library(viridis)      # scale di colore
library(RStoolbox)    # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(patchwork)    # unire più plot di ggplot

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/exam")



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

# 1997

# importare bande scaricate separatamente in una unica immagine

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

# 2004

# importare bande scaricate separatamente in una unica immagine
# stesse operazioni importazioni precedenti 

# pattern in comune = 2004
list04 <- list.files(pattern="2004")

import04 <- lapply(list04, raster)

landsat04 <- stack(import04) 
landsat04

plot(landsat04)
 
l04 <- ggRGB(landsat04, 4, 3, 2, stretch="hist")
l04

# 2008

# importare bande scaricate separatamente in una unica immagine
# stesse operazioni delle importazioni precedenti 

# pattern in comune = 2008
list08 <- list.files(pattern="2008")

import08 <- lapply(list08, raster)

landsat08 <- stack(import08) 
landsat08

plot(landsat08)

l08 <- ggRGB(landsat08, 4, 3, 2, stretch="hist")
l08

l97 + l01 + l04 + l08
# tutte le immagini sono a 16 bit 
# hanno un numero di celle elevato, circa 60 milioni 

# RICAMPIONO le immagini per agevolare le analisi 
# attraverso la funzione aggregate 
# con fact=10 cioè compatta 10 pixel 

l97r <- aggregate(landsat97, fact=10)
l97r

l01r <- aggregate(landsat01, fact=10)
l01r

l04r <- aggregate(landsat04, fact=10)
l04r

l08r <- aggregate(landsat08, fact=10)
l08r

# risoluzione di tutte le immagini ricampionate = 300m 

# confronto immagine ricampionata e originale per controllo

g1_97 <- ggRGB(landsat97, 4, 3, 2, stretch = "hist")   # immagine originale 
g2_97 <- ggRGB(l97r, 4, 3, 2, stretch = "hist")        # immagine ricampionata 
g1_97 / g2_97                                          # confronto

g1_01 <- ggRGB(landsat01, 4, 3, 2, stretch = "hist")   # immagine originale 
g2_01 <- ggRGB(l01r, 4, 3, 2, stretch = "hist")        # immagine ricampionata 
g1_01 / g2_01                                          # confronto 

g1_04 <- ggRGB(landsat04, 4, 3, 2, stretch = "hist")   # immagine originale 
g2_04 <- ggRGB(l04r, 4, 3, 2, stretch = "hist")        # immagine ricampionata 
g1_04 / g2_04                                          # confronto 
   
g1_08 <- ggRGB(landsat08, 4, 3, 2, stretch = "hist")   # immagine originale 
g2_08 <- ggRGB(l08r, 4, 3, 2, stretch = "hist")        # immagine ricampionata 
g1_08 / g2_08                                          # confronto 

# r = NIR
# g = red
# b = green 

# le immagini sono state ricampionate correttamente perchè sono simili 

# CONFRONTO IMMAGINI RICAMPIONATE dei diversi anni 
g2_97 + g2_01 + g2_04 + g2_08

# da una prima analisi si può già vedere come la distribuzione dei colori azzurro e rosso cambi da un'immagine all'altra 

######################### INDICI SPETTRALI ########################################

# foglie assorbono il rosso e riflettono il NIR (lunghezze d'onda)
# utilizzare le bande per visualizzare le immagini satellitari 
# DVI - Difference Vegetation Index 
# differenza NIR e red 

# palette per DVI 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 

# 1997
dvi97 <- l97r[[4]] - l97r[[3]]
plot(dvi97)

# 2001
dvi01 <- l01r[[4]] - l01r[[3]]
plot(dvi01, col=cl)

# 2004
dvi04 <- l04r[[4]] - l04r[[3]]
plot(dvi04, col=cl)

# 2008
dvi08 <- l08r[[4]] - l08r[[3]]
plot(dvi08, col=cl)

par(mfrow=c(2,2))
plot(dvi97, col=cl)
plot(dvi01, col=cl)
plot(dvi04, col=cl)
plot(dvi08, col=cl)









    
