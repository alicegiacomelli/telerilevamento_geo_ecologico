library(raster)

# install.packages("rgdal")
library("rgdal")

# settaggio cartella 
setwd("/Users/alicegiacomelli/desktop/lab")

# importazione immagine defor1_ e assegnazione
l1922 <- brick("defor1_.jpg")
