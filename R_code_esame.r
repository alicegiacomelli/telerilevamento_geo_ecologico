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

# bande importate 
# banda 1 = blue
# banda 2 = green 
# banda 3 = red
# banda 4 = NIR

