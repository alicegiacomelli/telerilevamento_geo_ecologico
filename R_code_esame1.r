# librerie 
library(raster)       # gestione immagini raster
library(ggplot2)      # visualizzazione dati in modo potente (grafici)
library(viridis)      # scale di colore
library(RStoolbox)    # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(patchwork)    # unire più plot di ggplot

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/vaia")

# importazione immagine colori

vaia18 <- brick("T32TPS_20180827T101021_TCI_10m.jp2")
vaia18

vaia19 <- brick("T32TPS_20190628T101039_TCI_10m.jp2")
vaia19

vaia22 <- brick("T32TPS_20220612T100559_TCI_10m.jp2")
vaia22

# immagini 8 bit 

# immagine composta da 3 bande 

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

g18 <- ggRGB(vaia18, 1, 2, 3, stretch = "lin") + 
  ggtitle("2018")

g19 <- ggRGB(vaia19, 1, 2, 3, stretch = "lin") + 
  ggtitle("2019")
  
g22 <- ggRGB(vaia22, 1, 2, 3, stretch = "lin") +
  ggtitle("2022")
  
g18 + g19 + g22
  
# ritaglio 
plotRGB(vaia22, 1, 2, 3, stretch = "lin") 
drawExtent(show=TRUE, col="red") 

# class      : Extent 
# xmin       : 672207.6 
# xmax       : 684354.3 
# ymin       : 5097386 
# ymax       : 5103496 

e <- extent(c(672207.6, 684354.3, 5097386, 5103496))

v18 <- crop(vaia18, e)
v19 <- crop(vaia19, e)
v22 <- crop(vaia22, e)

g18_crop <- ggRGB(v18, 1, 2, 3, stretch = "lin") + 
  ggtitle("2018")

g19_crop <- ggRGB(v19, 1, 2, 3, stretch = "lin") + 
  ggtitle("2019")

g22_crop <- ggRGB(v22, 1, 2, 3, stretch = "lin") + 
  ggtitle("2022")

patchwork1 <- g18_crop + g19_crop + g22_crop
patchwork1 + plot_annotation(
  title = 'Immagini colori naturali',
  subtitle = 'Levico Terme nel 2018, 2019, 2022')


# salvataggio 
pdf("Immagini_colori_naturali_2018.pdf")
print(g18_crop + plot_annotation(
  title = 'Immagine colori naturali - anno 2018',
  subtitle = 'Boschi sopra Levico Terme'))
dev.off()

pdf("Immagini_colori_naturali_2019.pdf")
print(g19_crop + plot_annotation(
  title = 'Immagine colori naturali - anno 2019',
  subtitle = 'Boschi sopra Levico Terme'))
dev.off()

pdf("Immagini_colori_naturali_2022.pdf")
print(g22_crop + plot_annotation(
  title = 'Immagine colori naturali - anno 2022',
  subtitle = 'Boschi sopra Levico Terme'))
dev.off()



# da una prima analisi si può vedere come la situazioni cambi tra l'anno 201


# salvo immagini 

# pdf("Immagini_colori_naturali_anno_2022.pdf")
# plotRGB(v22) +
# title = "Immagine a colori naturale - anno 2018"
# dev.off()

# salvataggio immagine multiframe 

# importo immagine con bande 

# creo una lista con pattern in comune = 1021_B
list18 <- list.files(pattern="1021_B")
# importo con la funzione raster lapply
import18 <- lapply(list18, raster)
# unisco componenti della list96 in un unico blocco con la funzione raster stack
vaia18_bande <- stack(import18) 
vaia18_bande # per vedere nomi delle bande 

# creo una lista con pattern in comune = 1039_B
list19 <- list.files(pattern="1039_B")
import19 <- lapply(list19, raster)
vaia19_bande <- stack(import19) 
vaia19_bande 

# creo una lista con pattern in comune =  0559_B
list22 <- list.files(pattern="0559_B")
import22 <- lapply(list22, raster)
vaia22_bande <- stack(import22) 
vaia22_bande 

# ritaglio 
v18_bande <- crop(vaia18_bande, e)
v19_bande <- crop(vaia19_bande, e)
v22_bande <- crop(vaia22_bande, e)

v18_bande
v19_bande 
v22_bande 

# importazione bande singole 
# banda 1 = B02 = blue
# banda 2 = B03 = green
# banda 3 = B04 = red
# banda 4 = B08 = NIR

# al posto del rosso nella banda RGB ci metto NIR 

g18_bande <- ggRGB(v18_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2018")
g18_bande

g19_bande <- ggRGB(v19_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2019")
g19_bande

g22_bande <- ggRGB(v22_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2022")
g22_bande

patchwork2 <- g18_bande + g19_bande + g22_bande
patchwork2 + plot_annotation(
  title = 'Immagini con NIR sulla prima banda',
  subtitle = 'Boschi sopra Levico Terme nel 2018, 2019, 2022')

# rosso è vegetazione !!!!!!!

# salvo immagini 

pdf("NIR_rosso_anno_2018.pdf")
ggRGB(v18_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2018")
dev.off()

pdf("NIR_rosso_anno_2019.pdf")
ggRGB(v19_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2019")
dev.off()

pdf("NIR_rosso_anno_2022.pdf")
ggRGB(v22_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2022")
dev.off()

# DVI 

# Differenza NIR e red 

dvi18 = v18_bande[[4]] - v18_bande[[3]]
dvi19 = v19_bande[[4]] - v19_bande[[3]]
dvi22 = v22_bande[[4]] - v22_bande[[3]]

# NDVI 

ndvi18 <- dvi18 / v18_bande[[4]] + v18_bande[[3]]
ndvi19 <- dvi19 / v19_bande[[4]] + v19_bande[[3]]
ndvi22 <- dvi22 / v22_bande[[4]] + v22_bande[[3]]

# plot
cl <- colorRampPalette(c('darkblue','green','red','black'))(100)

ndvi18_plot <- plot(ndvi18, col=cl)
ndvi19_plot <- plot(ndvi19, col=cl)
ndvi22_plot <- plot(ndvi22, col=cl)

ndvi1 <- par(mfrow=c(1,3))
plot(ndvi18, col=cl)
plot(ndvi19, col=cl)
plot(ndvi22, col=cl)

# salvataggio
pdf("ndvi_2018.pdf")
plot(ndvi18, col=cl)
dev.off()

pdf("ndvi_2019.pdf")
plot(ndvi19, col=cl)
dev.off()

pdf("ndvi_2022.pdf")
plot(ndvi22, col=cl)
dev.off()


# differenze NDVI 

# 2018 / 2019
ndvi_dif1 = ndvi18 - ndvi19
ndvi_dif2 = ndvi19 -ndvi22
cl <- colorRampPalette(c('darkblue','green','red','black'))(100)

plot(dvi_dif1, col=cl)
plot(dvi_dif2, col=cl)

par(mfrow=c(1,2))
plot(dvi_dif1, col=cl)
plot(dvi_dif2, col=cl)
***************************************



###### landcover 
landcover18 <- unsuperClass(v18_bande, nClasses=3)
landcover19 <- unsuperClass(v19_bande, nClasses=3)
landcover22 <- unsuperClass(v22_bande, nClasses=3)

landcover18
landcover19
landcover22

# mappa classificazione 
plot1 <- plot(landcover18$map)
plot2 <- plot(landcover19$map)
plot3 <- plot(landcover22$map)

# frequenza 
freq(landcover18$map)
# classe 1 = 
# classe 2 =
# classe 3 =

# numero totale di pixel 
landsat18
tot18 <- ****

# proporzione foresta 2018
prop_foresta_18 <- *** / tot18
prop_foresta_18
# numero proporzione ****** 

# percentuale foresta 2018
perc_foresta_18 <- n * 100/ tot18
perc_foresta_18
#

# percentuale agricoltura l92c
perc_terreno_18 <-  n * 100 / tot18
perc_terreno_18

# percentuale altro 
perc_altro_18 <-  n * 100 / tot18
perc_altro_18

###############

# frequenza 
freq(landcover19$map)
# classe 1 = 
# classe 2 =
# classe 3 =

# numero totale di pixel 
landsat19
tot19 <- ****

# proporzione foresta 2018
prop_foresta_19 <- *** / tot19
prop_foresta_19
# numero proporzione ****** 

# percentuale foresta 2018
perc_foresta_19 <- n * 100/ tot19
perc_foresta_19
#

# percentuale agricoltura l92c
perc_terreno_19 <-  n * 100 / tot19
perc_terreno_19

# percentuale altro 
perc_altro_19 <-  n * 100 / tot19
perc_altro_19


#############

# frequenza 
freq(landcover22$map)
# classe 1 = 
# classe 2 =
# classe 3 =

# numero totale di pixel 
landsat22
tot22 <- ****

# proporzione foresta 2018
prop_foresta_22 <- *** / tot22
prop_foresta_22
# numero proporzione ****** 

# percentuale foresta 2018
perc_foresta_22 <- n * 100/ tot22
perc_foresta_22
#

# percentuale agricoltura l92c
perc_terreno_18 <-  n * 100 / tot18
perc_terreno_18

# percentuale altro 
perc_altro_18 <-  n * 100 / tot18
perc_altro_18



# colonne (fields)
# quando si fa un elenco, elementi dello stesso gruppo, c perchè un vettore
# " perchè sono testi 
class <- c("Foresta", "Terreno", "Altro")
percent_2018 <- c(89.43075, 10.56925) ******+
percent_2019 <- c(51.91932, 48.08068) ********+
percent_2019 <- c(51.91932, 48.08068) ************+

# dataframe
multitemporal <- data.frame(class, percent_2018, percent_2019, percent_2022)
multitemporal

# 2018
# aes: aestetic
# + unire due funzioni 
barplot18 <- ggplot(multitemporal, aes(x=class, y=percent_2018, color=class)) +
             geom_bar(stat="identity", fill="white") +
             ggtitle("2018")

# 2019
barplot19 <- ggplot(multitemporal, aes(x=class, y=percent_2019, color=class)) +
             geom_bar(stat="identity", fill="white") +
             ggtitle("2019")

# 2022
barplot22 <- ggplot(multitemporal, aes(x=class, y=percent_2022, color=class)) +
             geom_bar(stat="identity", fill="white") +
             ggtitle("2022")


patchwork3 <- barplot18 + barplot19 + barplot22
patchwork3 + annotazioni(
  title = 'Percentuali landcover'
  subtitle = 'Levico Terme nel 2018, 2019, 2022')

pdf("barplot_percentuali_landcover.pdf")
print(patchwork3 + plot_annotation(
  title = 'Percentuali landcover'
  subtitle = 'Levico Terme nel 2018, 2019, 2022'))
dev.off()    


### etertogeneità 
# variabilità = deviazione standard

# banda NIR
nir1 <- v18_bande[[8]]
nir2 <- v19_bande[[8]]
nir3 <- v22_bande[[8]]

# 3 nuovi file raster con variabilità
# calcola la deviazione standard 
sd1 <- focal(nir1, matrix(1/9, 3, 3), fun=sd)
# nir : immagine
# matrice formata da 3*3 pixel, matrice : 1/9
# colonne : 3
# righe : 3
# funzione : deviazione standard sd    

sd2 <- focal(nir2, matrix(1/9, 3, 3), fun=sd)
sd3 <- focal(nir3, matrix(1/9, 3, 3), fun=sd)

# plot viridis

sd1_viridis <- ggplot() + 
geom_raster(sd1, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option = "inferno") +
ggtitle("Deviazione standard con pacchetto viridis - anno 2018")

sd2_viridis <- ggplot() + 
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option = "inferno") +
ggtitle("Deviazione standard con pacchetto viridis - anno 2019")

sd3_viridis <- ggplot() + 
geom_raster(sd2, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option = "inferno") +
ggtitle("Deviazione standard con pacchetto viridis - anno 2022")

patchwork4 <- sd1_viridis + sd2_viridis + sd3_viridis
patchwork4 + plot_annotation(
  title = 'Eterogeneità'
  subtitle = 'Levico Terme nel 2018, 2019, 2022')

# salvataggio 
pdf("eterogeneità.pdf")
print(patchwork4 + plot_annotation(
  title = 'Eterogeneità'
  subtitle = 'Levico Terme nel 2018, 2019, 2022'))
dev.off()


