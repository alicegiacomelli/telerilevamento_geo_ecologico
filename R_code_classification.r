# librerie 
library(raster)
library(RStoolbox)

# settaggio cartella 
setwd("/Users/alicegiacomelli/Desktop/lab/")

# importazione immagine RGB, tutti e 3 i livelli 
# funzione brick 
# assegnazione 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so

# plot RGB 
# r=1, g=2, b=3 le lettere possono essere omesse
# stretch lineare 
plotRGB(so, 1, 2, 3, stretch="lin")
# stretch istogramma (perde di definizione colori)
plotRGB(so, 1, 2, 3, stretch="hist")

#### MODELLO ###

# classificazione immagine solare 
# unsuperClass
# assegnazione 
soc <- unsuperClass(so, nClasses=3)
soc 
# mappa legata $ a soc 
# classi come etichette, no valori reali 

# palette colori
cl <- colorRampPalette(c('yellow','black','red'))(100)

# mappa con tre elementi energetici 
# plottaggio risultati 
plot(soc$map, col=cl)
# le classi sono etichette e quindi avremo tutti plot diversi
# plot diversi anche se proviamo più volte sullo stesso pc 
# funzione set.seed per avere sempre lo stesso esperimento 


#### GRAND CANYON ####

# importare immagine 
# funzione brick ""
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc 

# plot RGB 
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
# rosso=1
# verde=2
# blu=3

# cambiare lo stretch in Histogram 
# non tutti i valori sono riempiti e grazie allo strecht arrivo a 255, i valori si ridistribuiscono (questione solo di visualizzazione)
# aumentare la capacità di visualizzazione con histogram 
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

#### classificare immagine ####
# funzione unsuperClass

# 2 classi
# assegnazione
gcclass2 <- unsuperClass(gc, nClasses=2)
gcclass2
# map è l'unico output 
# plot legando classe e map 
plot(gcclass2$map)
# classe con 2 valori: 1 e 2. 
# classe 1: roccia 
# classe 2: acqua, ombre o altre tipologie di roccia 
# vebgono scelti pixel random
# per mantenere sempre la stessa classificazione 
# set.seed(17)

# classificazione con 4 classi 
gcclass4 <- unsuperClass(gc, nClasses=4)
gcclass4
plot(gcclass4$map)
# palette 
clc <- colorRampPalette(c('yellow','red','blue','black'))(100)
plot(gcclass4$map, col=clc)

# comparare mappe con classi e immagine originale 
par(mfrow=c(2,1))
plot(gcclass4$map, col=clc)
plotRGB(gc, r=1, g=2, b=3, stretch="hist")


