# creazione mappe land cover 

# librerie 
library(raster)
library(RStoolbox) # per classificazione 

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
# campione di pixel!
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
# quanta foresta è stata persa quantitativamente 

# l92c
freq(l92c$map)
# classe 1 = 36072 pixel (agricoltura)
# classe 2 = 305220 pixel (foresta)

# numero totale di pixel 
l92
tot92 <- 341292

# proporzione foresta l92
prop_forest_92 <- 305220 / tot92
prop_forest_92
# 0.8943075 

# percentuale foresta l92
perc_forest_92 <- 305220 * 100/ tot92
perc_forest_92
# 89.43075

# percentuale agricoltura l92c
# metodo 1
perc_agr_92 <- 100 - perc_forest_92
# metodo 2
perc_agr_92 <-  36079 * 100 / tot92
perc_agr_92

# perc_forest_92 = 89.43075
# perc_agr_92 = 10.56925

# l06c
freq(l06c$map)
# classe 1 = 178730 pixel (foresta)
# classe 2 = 163996 pixel (agricoltura)

# percentuali l06
tot_06 <- 342726 
percent_forest_06 <- 177941 * 100 / tot_06
percent_forest_06
percent_agr_06 <- 100 - percent_forest_06
percent_agr_06

# perc_forest_06 = 51.91932
# perc_agr_06 = 48.08068

# DATI FINALI
# perc_forest_92 = 89.43075
# perc_agr_92 = 10.56925
# perc_forest_06 = 51.91932
# perc_agr_06 = 48.08068

# DATAFRAME
# tabella (con 3 colonne)

# colonne (fields)
# quando si fa un elenco, elementi dello stesso gruppo, c perchè un vettore
# " perchè sono testi 
class <- c("Foresta", "Agricoltura")
percent_1992 <- c(89.43075, 10.56925)
percent_2006 <- c(51.91932, 48.08068)

# dataframe
multitemporal <- data.frame(class, percent_1992, percent_2006)
multitemporal

# formato tabella 
# install XQuartz
# View(multitemporal)

# 1992
# aes: aestetic
# + unire due funzioni 
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) +
geom_bar(stat="identity", fill="white")

# 2006
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) +
geom_bar(stat="identity", fill="white")

# pdf percentages_1992
pdf("percentages_1992.pdf")
ggplot(multitemporal, aes(x=class, y=percent_1992, color=class)) +
geom_bar(stat="identity", fill="white")
dev.off()

# pdf percentages_2006
pdf("percentages_2006.pdf")
ggplot(multitemporal, aes(x=class, y=percent_2006, color=class)) +
geom_bar(stat="identity", fill="white")
dev.off()



