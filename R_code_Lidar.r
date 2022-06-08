# R code per visualizzare dati Lidar 
# creare un chm

library(raster)
library(ggplot2)
library(viridis)
library(RStoolbox)

# settaggio working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/")

# caricamento dsm 2013 con raster 
# assegnazione
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013
# immagine dettagliata 

# caricamento dtm 2013 con raster 
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dtm_2013

# plot dtm
plot(dtm_2013)

# chm 2013
# differenza dsm e dtm 
# assegnazione 
chm_2013 <- dsm_2013 - dtm_2013
chm_2013

# ggplot 
# ggtitle() per dare titolo alla nuova immagine 
ggplot() + 
geom_raster(chm_2013, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2013 San Genesio/Jenesien")

# su qgis si possono vedere le altezze del singolo pixel 
