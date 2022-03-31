library(raster)

# install.packages("rgdal")
library(rgdal)

# settaggio cartella 
setwd("/Users/alicegiacomelli/desktop/lab")

# importazione immagine defor1_ e assegnazione
l1992 <- brick("defor1_.jpg")

# info 
l1992

# plot RGB 
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
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
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI Difference Vegetation Index 
# differenza NIR e red 

#1922
dvi1992 = l1992[[1]] - l1992[[2]]

# oppure
# dvi1992 = l1992$defor1_.1 - l1992$defor1_.2

# info 
dvi1992

# colorazione 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi1992, col=cl)

#2006
dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006

# colorazione 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi2006, col=cl)

# DVI differenza 1992 e 2006
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100)
# chiudere multiframe 
dev.off()
# plot differenza DVI
plot(dvi_dif, col=cld)

# day 2

# Range DVI (8 bit): -255 a 255
# Range NDVI normalizzato (8 bit): -1 a 1 

# Range DVI (16 bit): -65535 a 65535
# Range NDVI standardizzato (16 bit): -1 a 1

# NDVI può essere usato anche con immagini con risoluzione radiometrica differenti 
# risoluzione radiometrica differenti = quanti bit ci sono a disposizione all'interno di una immagine

