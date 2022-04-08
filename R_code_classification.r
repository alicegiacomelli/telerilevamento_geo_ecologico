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
