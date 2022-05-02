# creazione mappe land cover 

# librerie 
library(raster)
library(RStoolbox) 

# install.packages("ggplot2")
library(ggplot2)

# install.packages("patchwork")
# info: https://patchwork.data-imaginist.com/
library(patchwork)

# install.packages("gridExtra")
library(gridExtra)

# set working directory 
# settaggio cartella 
setwd("/Users/alicegiacomelli/Desktop/lab/")

# importazione dati defor1_ 
# assegnazione l92
# plotRGB con NIR 1, r 2, g 3
l92 <- brick("defor1_.jpg")
plotRGB(l92, r=1, g=2, b=3, stretch="lin")

# importazione dati defor2_
# assegnazione l06
l06 <- brick("defor2_.jpg")

# plotRGB di l92 e l06
par(mfrow=c(2,1))
plotRGB(l92, r=1, g=2, b=3, stretch="lin")
plotRGB(l06, r=1, g=2, b=3, stretch="lin")

# library(ggplot2)
# library(patchwork)

# multiframe con ggplot2
# plot (raffigurazione grafica) con coordinate (in questo caso coordinate immagine)
# assegnazione
p1 <- ggRGB(l92, 1, 2, 3, stretch="lin")
p2 <- ggRGB(l06, 1, 2, 3, stretch="lin")

p1
p2

p1 + p2 # patchwork

# mettere plot uno sopra l'altro 
p1/p2

# classificazione l92 con 2 classi 
# unsuperClass
l92c <- unsuperClass(l92, nClasses=2)
l92c

dev.off()

# mappa calassificazione l92c 
plot(l92c$map)
# classe 1 = terreni agricoli (+ acqua) 
# classe 2 = foresta

# classificazione l06 con 2 classi
l06c <- unsuperClass(l06, nClasses=2)
l06c
# mappa classificazione l06c
plot(l06c$map)
# classe 1 = foresta
# classe 2 = terreni agricoli (+ acqua)

# frequenza di pixel appartenenti alla classe foresta 
# generare tabella di frequenza 

# l92c
freq(l92c$map)
# classe 1 = 36072 pixel
# classe 2 = 305220 pixel

# l06c
freq(l06c$map)
# classe 1 = 178730 pixel
# classe 2 = 163996 pixel
