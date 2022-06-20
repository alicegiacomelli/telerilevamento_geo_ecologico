########## TELERILEVAMENTO GEO-ECOLOGICO 2021-2022 ##########

# indice:
# 1. 
# 2.
# 3.
# 4. 


#############################################################################################################

########## ARGOMENTO 1: REMOTE SENSING first code #########

# questo è il primo script che useremo a lezione 

# install.packages("raster")
library(raster)

# settaggio cartella di lavoro, file nella cartella zip scaricata, importare cartella   
setwd("/Users/alicegiacomelli/desktop/lab")

# importazione immagine e assegnazione, parto dall'ultima immagine cronologica 
l2011 <- brick("p224r63_2011.grd")

# vedere info immagine
l2011

# vedere plot 
plot(l2011)

# colorazione e assegnazione, 100 variazioni massime di colore 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

# vedere plot con nuova colorazione 
plot (l2011, col=cl)

# dev.off() per problemi con la grafica 

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicini NIR 

# plot banda del blu - B1_sre
plot(l2011$B1_sre)
# oppure
plot(l2011[[1]])

# plot con colorazione cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col=cl)

# plot b1 da dark blue a blue a light blue 
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)

# esportare plot in pdf nella cartella lab - dare nome, plot, chiudere finestra virtuale 
pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb)
dev.off()

# oppure in png 
png("banda1.png")
plot(l2011$B1_sre, col=clb)
dev.off()

# plot b2 da dark green a green a light green 
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)

# multiframe - foglio vuoto (1 riga e 2 colonne), plot 1, plot 2, chiudere finestra
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# esportare pdf multiframe - foglio vuoto, plot 1, plot 2, chiudere finestra
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
dev.off()

# multiframe con plot 1 sopra e plot 2 sotto (2 righe, 1 colonna)
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# multiframe con 4 plot (4 bande)
par(mfrow=c(2,2))
# blue
plot(l2011$B1_sre, col=clb)
# green
plot(l2011$B2_sre, col=clg)
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# plot l2011 nella banda NIR 
plot(l2011$B4_sre)
# colore 
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)

# plot RGB 
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")

# plot RGB con NIR - la banda del blu viene sostituita e tutto slitta di 1 
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")
# plot RGB - verde
plotRGB(l2011, r=3, g=4, b=2, stretch="lin")
# plot RGB - blu (giallo zone senza vegetazione, suolo nudo dovuto a agricoltura) 
plotRGB(l2011, r=3, g=2, b=4, stretch="lin")

# plot RGB - stretch="hist" - aumento della gamma di colori forte 
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# multiframe con visualizzazione RGB 
# linear stretch - RGB visibile 
# histogram stretch 
par(mfrow=c(2,1))
plotRGB(l2011, r=3, g=2, b=1, stretch="lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="hist")

# immagine del 1988
l1988 <- brick("p224r63_1988.grd")

# info immagine 
l1988

# multiframe 1988 e 2011
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="lin")

###########################################################################################################

# ARGOMENT0 2: INDICI SPETTRALI 

#### day 1

library(raster)

# install.packages("rgdal")
library(rgdal)

# install.packages("RStoolbox")
library(RStoolbox)

# install.packages("rasterdiv")
library(rasterdiv)

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

# NDVI 

# 1992
dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
# oppure 
ndvi1992 = (l1992[[1]] -  l1992[[2]]) / (l1992[[1]] + l1992[[2]])

# info 
ndvi1992

# colorazione 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(ndvi1992, col=cl)

# multiframe con il polt RGB sopra e plot NDVI sotto 
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)

# 2006 
dvi2006 = l2006[[1]] - l2006[[2]]
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])

# multiframe con NDVI 1992 sopra e NDVI 2006 sotto
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# spectral indices

# install.packages("RStoolbox")
# library(RStoolbox)

# spectralIndices automatico con library(RStoolbox)
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)

# plot spectralIndices - tutti gli indici che si possono calcolre per una immagine 
plot(si1992, col=cl)

# copNDVI

# install.packages("rasterdiv")
# library(rasterdiv)

# plot copNDVI
plot(copNDVI)

###########################################################################################################

########## ARGOMENTO 3: TIMES SERIES GREENLAND ##########

library(raster)

#settaggio cartella 
setwd("/Users/alicegiacomelli/Desktop/lab/greenland") 

# importazione singolo layer tramite funzione raster 
raster("lst_2000.tif")
# immagine a 16 bit 

# assegnazione immagine
lst2000 <- raster("lst_2000.tif")
lst2000

# plot immagine
plot(lst2000)

# importazione dei singoli layer e assegnazioe 
lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")

# palette colori 
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)

# multiframe con 4 dati 
par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)

# importazione unica per 4 layer 

# al posto di fare il multiframe

# creare lista dei file
# pattern in comune 
# assegnazione 
rlist <- list.files(pattern="lst")
rlist

# funzione raster all'intera lista di file 
# assegnazione 
import <- lapply(rlist, raster)
import

# blocco comune di tutti i dati 
# stack 
# assegnazione 
tgr <- stack(import)
tgr 

# plot 
plot(tgr, col=cl)

# plot 1 banda 
plot(tgr[[1]], col=cl)

# plot RGB 
# vedere più bande insieme nella stessa immagine 
# red = 2000
# green = 2005
# blue = 2010
# stretch perchè ci sono 16 bit 
plotRGB(tgr, r=1, g=2, b=3, stretch="lin")

########## ARGOMENTO 4: TIMES SERIES LOCKDOWN ##########

# Esempio 2: diminuzione NO2 durante il lockdown 

library(raster)

# settaggio cartella 
setwd("/Users/alicegiacomelli/Desktop/lab/en")

# importare 1 dato con raster layer (importa solo il primo layer)
# si potrebbe importare 1 dato anche con brick (importo tutti i layer RGB)
en01 <- raster("EN_0001.png")

# info immagine 
en01

# colorazione palette 
cl <- colorRampPalette(c('red','orange','yellow'))(100)

# plot con colorazione cl 
plot(en01, col=cl)

# importiamo 2° set - en13
en13 <- raster("EN_0013.png")

# info immagine 
en13

# plot con colorazione cl 
plot(en13, col=cl)


# importare tutto il dataset insieme 
# list.files
# lapply
# stack 

# lista - list.files  
# pattern in comune 
rlist <- list.files(pattern="EN")
rlist

# importazione - lapply(X, FUN) (applicare funzione raster)
rimp <- lapply(rlist, raster)
rimp

# stack 
en <- stack(rimp)
en 

# plot 
plot(en, col=cl)


# plot EN01 e EN13 

# metodo 1 - multiframe 
par(mfrow=c(1,2))
plot(en01, col=cl)
plot(en13, col=cl)

dev.off()

# metodo 2 - stack 
en113 <- stack(en[[1]], en[[13]])
plot(en113, col=cl)

# differenza 
# palette
# plot
difen <- en[[1]] - en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(difen, col=cldif)


# plot RGB di 3 file 
# stretch lin
plotRGB(en, r=1, g=7, b=13, stretch="lin")

###########################################################################################################

########## ARGOMENTO 5: CLASSIFICATION ##########

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


#### GRAND CANYON ####

# importare immagine 
# funzione brick ""
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc 

# plot RGB 
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
# rosso=1
# verde=2
# blu=3

# cambiare lo stretch in Histogram 
# non tutti i valori sono riempiti e grazie allo strecht arrivo a 255, i valori si ridistribuiscono (questione solo di visualizzazione)
# aumentare la capacità di visualizzazione con histogram 
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

#### classificare immagine ####
# funzione unsuperClass

# 2 classi
# assegnazione
gcclass2 <- unsuperClass(gc, nClasses=2)
gcclass2
# map è l'unico output 
# plot legando classe e map 
plot(gcclass2$map)
# classe con 2 valori: 1 e 2. 
# classe 1: roccia 
# classe 2: acqua, ombre o altre tipologie di roccia 
# vebgono scelti pixel random
# per mantenere sempre la stessa classificazione 
# set.seed(17)

# classificazione con 4 classi 
gcclass4 <- unsuperClass(gc, nClasses=4)
gcclass4
plot(gcclass4$map)
# palette 
clc <- colorRampPalette(c('yellow','red','blue','black'))(100)
plot(gcclass4$map, col=clc)

# comparare mappe con classi e immagine originale 
par(mfrow=c(2,1))
plot(gcclass4$map, col=clc)
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# stack per visualizzazione (avere immagini della stessa dimensione)
st <- stack(gc, gcclass4$map)
plot(st) 


###########################################################################################################

########## ARGOMENTO 6: LANDCOVER ##########

# creazione mappe land cover 

# librerie 
library(raster)
library(RStoolbox) # per classificazione 

# install.packages("ggplot2")
library(ggplot2)

# install.packages("patchwork")
# info: https://patchwork.data-imaginist.com/
library(patchwork)

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


###########################################################################################################

########## ARGOMENTO 7: VARIABILITY 1 ##########

library(raster) # gestione immagini 
library(RStoolbox) # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(ggplot2) # visualizzazione dati in modo potente 
library(patchwork) # unire più plot di ggplot 
library(viridis) # scale di colore 

# set working directory
setwd("/Users/alicegiacomelli/Desktop/lab/")

# importare immagine multispettrale 
# assegnazione
# sentinel: satellite con risoluzione 10m
sen <- brick("sentinel.png")
sen

# plot con ggRGB 
# banda 1 = NIR
# banda 2 = red
# banda 3 = green 
ggRGB(sen, r=1, g=2, b=3, stretch="lin")
# oppure 
ggRGB(sen, 1, 2, 3)
# stretch viene messo automaticamente 

# plot con bande diversificate
# NIR on g component
ggRGB(sen, 2, 1, 3)

# unire 2 plot, uno di fianco all'altro
g1 <- ggRGB(sen, 1, 2, 3)
g2 <- ggRGB(sen, 2, 1, 3)

# patchwork
g1 + g2

# unire 2 plot, uno sopra l'altro
g1/g2

# 4 plot
(g1+g2)/(g1+g2)

##### variabilità = deviazione standard #####

# variabilità in NIR 
nir <- sen[[1]]
nir 

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd
# nir : immagine
# matrice formata da 3*3 pixel, matrice : 1/9
# colonne : 3
# righe : 3
# funzione : deviazione standard sd      

# palette 
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)

# plot della variabilità con palette 
plot(sd3, col=clsd)
             
# plot ggplot
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))
# immagine : sd3
# colore : fill, strato che abbiamo calcolato quindi layer 

# viridis
# library(viridis)
# scale () senza argomento, legenda di default viridis             
ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# cividis 
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")
             
# magma
# lavora anche su colorazioni intermedie 
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# inferno
ggplot() + 
geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")
             
# stesso calcolo con finestra 7*7
# matrice 7             
sd7 <- focal(nir, w=matrix(1/49, 7, 7), fun=sd)
             
             
###########################################################################################################

########## ARGOMENTO 8: MULTIVARIATE ANALYSIS ##########

# R code for multivariate analysis

# compattare sistema multidimensionale in un numero minore di variabili
# una sola dimensione 
# valori pixel su sistema cartesiano, dove c'è maggior variabilità si fa passare PC1 (componente principale)
# secondo asse perpendicolare e spiega altra variabile 

# librerie
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)


# set working directory
("/Users/alicegiacomelli/Desktop/lab/") 

# immagine landsat con 7 bande 
# risoluzione 30m 

# Bande Landsat
# B1: blue
# B2: green
# B3: red
# B4: NIR
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# importazione tramite brick (più bande)
# assegnazione
p224r63_2011 <- brick("p224r63_2011_masked.grd")

# plotto immagine
plot(p224r63_2011)

# ricampionamento: resampling
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

g1 <- ggRGB(p224r63_2011, 4,3,2)
g2 <- ggRGB(p224r63_2011res, 4,3,2)

g1+g2

# aggressive resampling 
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)
# fact = 100 compatta 100 pixel insieme
# risoluzione 300m 

# confronto le immagini 
g1 <- ggRGB(p224r63_2011, 4,3,2)
g2 <- ggRGB(p224r63_2011res, 4,3,2)
g3 <- ggRGB(p224r63_2011res100, 4,3,2)

g1+g2+g3

# PCA principal component analisy
# funzione rasterPCA (r tiene conto delle maiuscole)
p224r63_2011respca <- rasterPCA(p224r63_2011res)

# $call = funzione che abbiamo utilizzato
# $model = modello, correlazione tra le bande
# $map = oggetto raster

summary(p224r63_2011respca$model)

# plot
plot(p224r63_2011respca$map)


# pacchetto viridis 
# ggplot

g1 <- ggplot() + 
geom_raster(p224r63_2011respca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC1")

g2 <- ggplot() + 
geom_raster(p224r63_2011respca$map, mapping=aes(x=x, y=y, fill=PC7)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("PC7")

# visualizzazione
g1+g2

g3 <- ggplot() + 
geom_raster(p224r63_2011res, mapping=aes(x=x, y=y, fill=B4_sre)) + 
scale_fill_viridis(option = "inferno") +
ggtitle("NIR")

# visualizzazione 
g1+g3

g4 <- ggRGB(p224r63_2011, 2, 3, 4, stretch="hist")

g1+g4

plotRGB(p224r63_2011respca$map, 1, 2, 3, stretch="lin")
plotRGB(p224r63_2011respca$map, 5, 6, 7, stretch="lin")


###########################################################################################################

########## ARGOMENTO 9: VARIABILITY 2 #########

# R code variability 2 - Using PC components

library(raster)
library(RStoolbox)
library(ggplot2) 
library(patchwork)
library(viridis)

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/")

# importazione immagine con brick 
# assegnazione
sen <- brick("sentinel.png")
sen

# plot immagine
# NIR = banda 1
# red = banda 2
# green = banda 3
 
# strecht automatico 
ggRGB(sen, 1, 2, 3)

# visualizzazione con vegetazione verde fluorescente e suolo nudo viola 
# NIR sulla componente g 
ggRGB(sen, 2, 1, 3)

# analisi multivariata 
# pca
# assegnazione 
# no ricampionamento perchè immagine leggera 
sen_pca <- rasterPCA(sen)
sen_pca

# $call - funzione che abbiamo ultilizzato 
# $model - modello da utilizzare, grafico con bande 
# $map - mappa finale 

# summery del modello
# variabilità, quante informazioni contiene il primo modello 
summary(sen_pca$model)
# Proportion of Variance: componente 1 tot %, componente 2 tot %
# componente 3 solo rumore 
# Cumulative Proportion: somma 1 + 2
# noi ci accontentiamo solo della prima componente cumulativa 

# plot mappa 
plot(sen_pca$map)

# ggplot vuoto + geometria raster (componente 1 = pc1)

# come scrivere componenti:
pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3

g1 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))
# aestetic : x corrisponde a x immagine, uguale y, fill è la componente 1
# assegnazione per patchwork

g2 <- ggplot() +
geom_raster(pc2, mapping=aes(x=x, y=y, fill=PC2))

g3 <- ggplot() +
geom_raster(pc3, mapping=aes(x=x, y=y, fill=PC3))
# g3 solo rumore 

#library(patchwork)
g1 + g2 + g3

# deviazione standard 
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
sd3
# matrice 3*3, quindi 1/9

# mappare con ggplot la deviazione standard della componente 1 
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) 
# names mappa: layer > fill=layer 

# colore viridis
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()

# cividis
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="cividis")

# inferno 
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

# plottare insieme 
# assegnazione 
im1 <- ggRGB(sen, 2, 1, 3)

im2 <- ggplot() +
geom_raster(pc1, mapping=aes(x=x, y=y, fill=PC1))

im3 <- ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

# patchwork
im1 + im2 + im3

# calcolo variabilità con finestra 5*5
# aumento finestra di calcolo = aumenta varibilità 
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun=sd)
# matrice 5*5
# singolo pixel 1 su 25 

# assegnazione immagine 
# libreria colori inferno
im4 <- ggplot() +
geom_raster(sd5, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

# visualizzazione immagine 3*3 e 5*5
im3 + im4

# calcolo variabilità con finstra 7*7
sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)

# assegnazione immagine 
# libreria colori inferno
im5 <- ggplot() +
geom_raster(sd7, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno")

# viasualizzazione 3*3, 5*5, 7*7
im3 + im4 + im5


###########################################################################################################

########## ARGOMENTO 10: LIDAR #########

# R code per visualizzare dati Lidar 
# creare un chm
# visualizzare point cloud 

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

             
###########################################################################################################

########### ARGOMENTO 11: SDM ##########
             
# R code per visualizzare dati Lidar 
# creare un chm
# visualizzare point cloud 

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


###########################################################################################################

########## ARGOMENTO 12: COLORIST ##########

# librerie 
# install.packages("colorist")
library(colorist)
library(ggplot2)

# come agire: 
# 1. definizione metrica 
# 2. creazione palette
# 3. mappiamo singole mappe : mappe multiple 
# 4. mappa distillata 
# 5. legenda 

# mappare specie com dati dal 1 gennaio al 31 dicembre 
# dato già presente ne pacchetto colorist 
data("fiespa_occ")
# raster stack

# colorist lavora solo con raster stack !

# dati cicli annuali con metrics
# assegnazione 
# sta preparandp alla visualizzazione del raster 
# metrica 
met1 <- metrics_pull(fiespa_occ) 

# palette ciclo annuale 
pal <- palette_timecycle(fiespa_occ)

# creare mappa multipla 
# numero colonne 3
# vogliamo una mappa multipla che prenda il dato, la palette, li divida in 3 colonne e che assegni il nome del nostro dato alle mappe multiple 
map_multiples(met1, pal, ncol=3, labels=names(fiespa_occ))

# mappa singola 
# solo del mese che ci interessa 
map_single(met1, pal, layer=6)

# cambiare i colori 
# modificare colore di partenza
# palette nuova 
# valore 60 = giallo 
p1custom <- palette_timecycle(12, start_hue=60)

# mappa multipla con colori diversi 
map_multiples(met1, p1custom, ncol=3, labels=names(fiespa_occ))

# unione dei layer 
# per distillare la mappa 
# metrica distillata
met1_distill<-metrics_distill(fiespa_occ)

# mappa distillata 
# creo mappa singola con la metrica distillata 
# palette iniziale 
map_single(met1_distill,pal) 
# palette 2
map_single(met1_distill,p1custom)
# parti grigie = bassa specificità, la specie ci sarà tutto l'anno, non è caratteristica solo di alcuni mesi
# colore ci dice che in un determinato mese, la specie si concentra in un determinato punto 

# legenda 
legend_timecycle(pal,origin_label = "1 jan")

######### esempio 2 #########

# caricamento dato 
# ciclo lineare 
data("fisher_ud") 

# metrica 
# rende visibile dati teorici
m2 <- metrics_pull(fisher_ud)

# palette per ciclo lineare 
pal2 <- palette_timeline(fisher_ud)

# valori che ci restituisce 
# sigle dei colori 
head(pal2)

# mappa multipla 
map_multiples(m2,ncol = 3, pal2)
# lambda = cambia opacità 
map_multiples(m2,ncol = 3, pal2, lambda_i = -12)

# mappa singola 

# metrica distillata 
m2_distill<-metrics_distill(fisher_ud)
# mappa singola distillata con lambda
map_single(m2_distill,pal2,lambda_i = -10)

# legenda lineare 
legend_timeline(pal2,time_labels = c("2 aprile", "11 aprile"))


######### esempio 3 #########

# dato 
data("elephant_ud")
elephant_ud

# metrica 
met3<-metrics_pull(elephant_ud)

# palette per dati non ordinati (no linerari, no circolari)
pal3<-palette_set(elephant_ud)

# mappa multipla 
map_multiples(met3, pal3, ncol = 2,lambda_i = -5,labels = names(elephant_ud))

# SPECIFICITA' : misura di passaggio differenziale 
# bassa specificità = uso comune del paesaggio
# alta specificità = uso differenziale del paesaggio

# metrica distillata 
met3_distt<-metrics_distill(elephant_ud)

# mappa singola 
map_single(met3_distt,pal2,lambda_i = -5)

# legenda per dati non ordinati 
legend_set(pal3, group_labels = names(elephant_ud))

             
###########################################################################################################

########## ARGOMENTO 13: FUNCTIONS ##########

# creare una funzione 

# libreria
library(raster)

# Set working directory
setwd("/Users/alicegiacomelli/Desktop/lab/")


# Funzione 1
# Creo una funzione che, una volta chiamata, "saluta" il nome inserito
cheer_me <- function(your_name) {
cheer_string <- paste("Hello", your_name, sep = " ")
print(cheer_string)
}   

cheer_me("alice")

# Funzione 2
# funzione che, una volta chiamata, "saluta" il nome inserito n volte, "n" lo scelgo io
cheer_me_n_times <- function(your_name, n) {
cheer_string <- paste("Hello", your_name, sep = " ")

for(i in seq(1, n)) {
print(cheer_string)
}
}






