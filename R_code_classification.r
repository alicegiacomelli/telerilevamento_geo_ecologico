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

