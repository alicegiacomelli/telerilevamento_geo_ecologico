library(raster)       # gestione immagini raster
library(ggplot2)      # visualizzazione dati in modo potente (grafici)
library(viridis)      # scale di colore
library(RStoolbox)    # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(patchwork)    # unire più plot di ggplot

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/vaia")

# importazione immagine RGB

vaia18 <- brick("T32TQS_20180926T101021_TCI_10m.jp2")
vaia18

vaia19 <- brick("T32TQS_20190723T101031_TCI_10m.jp2")
vaia19

vaia22 <- brick("T32TQS_20220612T100559_TCI_10m.jp2")
vaia22

##   B01= coastal aerosol                 0.443                           
##   B02= blue                            0.490                           
##   B03= green                           0.560                           
##   B04= red                             0.665                           
##   B05= vegetation red edge             0.705                           
##   B06= vegetation red edge             0.740                           
##   B07= vegetation red edge             0.783                           
##   B08= NIR                             0.842                           
##   B08A= vegetation red edge            0.865                           
##   B09= water vapour                    0.945                           
##   B11= SWIR                            1.610                           
##   B12= SWIR                            2.190                           

g1 <- ggRGB(vaia18, 1, 2, 3, stretch = "lin") + 
  ggtitle("2018")

g2 <- ggRGB(vaia19, 1, 2, 3, stretch = "lin") + 
  ggtitle("2019")
  
g3 <- ggRGB(vaia22, 1, 2, 3, stretch = "lin") +
  ggtitle("2022")
  
g1 + g2 + g3
  
# ritaglio 
plotRGB(vaia22, 1, 2, 3, stretch = "lin") 
drawExtent(show=TRUE, col="red") 

# class      : Extent 
# xmin       : 702233.2 
# xmax       : 755349.7 
# ymin       : 5093798 
# ymax       : 5132360

e <- extent(c(702233.2, 755349.7, 5093798, 5132360))

v18 <- crop(vaia18, e)
v19 <- crop(vaia19, e)
v22 <- crop(vaia22, e)

par(mfrow=c(1,3))
plotRGB(v18)
plotRGB(v19)
plotRGB(v22)













