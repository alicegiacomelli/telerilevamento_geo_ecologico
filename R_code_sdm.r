# R code per modello delle distribuzione delle specie 

# librerie 
library(raster)
library(sdm)
library(rgdal) # specie 

# caricare file da un pacchetto
# assegnazione 
file <- system.file("external/species.shp", package="sdm")
# shapefile 
file 

# leggere shapefile 
species <- shapefile(file)
species
# punti nello spazio, non è un raster 

# plot della specie
# carattere punti pch=19
plot(species, pch=19)

# su R dove sono o non sono stati registrati i punti 
species$Occurrence

# plot con selezione
# mappo solo le presenze 
# selezione tra [] == e , finale 
# colore ""
# stile punti 
plot(species[species$Occurrence == 1,],col='blue',pch=16)

# assegnazione per semplificare 
occ <- species$Occurrence

# plot punti presenti 
plot(species[occ == 1,], col="blue", pch=19)

# punti dove non c'è il dato 
# no plot se no si sovrascrive 
points(species[occ == 0,], col="red", pch=19)
