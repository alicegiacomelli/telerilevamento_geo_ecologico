# R code per visualizzare dati Lidar 
# creare un chm

library(raster)
library(ggplot2)
library(viridis)
library(RStoolbox)
# install.packages("lidR")
library(lidR)

# settaggio working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/")

#### 2013 ####

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

#### 2004 ####

# caricamento dsm 2004
dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")
dsm_2004
# risoluzione più bassa 

# caricamento dtm 2004
dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")
dtm_2004

# ricavo chm 2004
chm_2004 <- dsm_2004 - dtm_2004

# ggplot
ggplot() + 
geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM 2004 San Genesio/Jenesien")

# confrontare chm 2013 e 2004 
# differenze chm 2013 e 2004
# errore perchè due risoluzioni diverse 
difference_chm <- chm_2013-chm_2004 # errore 

# cambiare risoluzione del dato 
# resemple 
# ricampionare immagine sull'altra 
# l'avevamo già fatto 
# passare da una risoluzione più accurata a una risoluzione meno accurata 
chm_2013r <- resample(chm_2013, chm_2004)

# differenza chm
difference_chm <- chm_2013r-chm_2004

# ggplot differenza chm
ggplot() + 
geom_raster(difference_chm, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis() +
ggtitle("CHM difference San Genesio/Jenesien")
# tenere in considerazione il ricampionamento > numeri non accurati

#### point cloud ####

# visualizzare point cloud (3d)
# library(lidR)
point_cloud <- readLAS("point_cloud.laz")

# plottaggio per visualizzazione 3d
plot(point_cloud)

