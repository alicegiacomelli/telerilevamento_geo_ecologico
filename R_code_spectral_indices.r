library(raster)

# install.packages("rgdal")
library(rgdal)

# settaggio cartella 
setwd("/Users/alicegiacomelli/desktop/lab")

# importazione immagine defor1_ e assegnazione
l1922 <- brick("defor1_.jpg")

# info 
l1922

# plot RGB 
plotRGB(l1922, r=1, g=2, b=3, stretch="lin")
# layer 1 = NIR
# layer 2 = red
# layer 3 = green 

# importazione immagine defor2_ e assegnazione 
l2006 <- brick("defor2_.jpg")

# info 
l2006

# plot RGB
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# multiframe l1992 e l2006
par(mfrow=c(2,1))
plotRGB(l1922, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI Difference Vegetation Index 
# differenza NIR e red 
dvi1992 = l1922[[1]] - l1922[[2]]
