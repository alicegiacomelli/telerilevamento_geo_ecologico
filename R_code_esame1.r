library(raster)       # gestione immagini raster
library(ggplot2)      # visualizzazione dati in modo potente (grafici)
library(viridis)      # scale di colore
library(RStoolbox)    # visualizzazione e analisi dati satellitari (calcolo variabilità)
library(patchwork)    # unire più plot di ggplot

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/vaia")

# importazione immagine colori

vaia18 <- brick("T32TQS_20180926T101021_TCI_10m.jp2")
vaia18

vaia19 <- brick("T32TQS_20190723T101031_TCI_10m.jp2")
vaia19

vaia22 <- brick("T32TQS_20220612T100559_TCI_10m.jp2")
vaia22

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

# salvo immagini 
pdf("Immagini_colori_naturali_anno_2018.pdf")
plotRGB(v18) +
title = "immagine a colori naturale - anno 2018"
dev.off()

pdf("Immagini_colori_naturali_anno_2019.pdf")
plotRGB(v19) +
title = "immagine a colori naturale - anno 2019"
dev.off()

pdf("Immagini_colori_naturali_anno_2022.pdf")
plotRGB(v22) +
title = "immagine a colori naturale - anno 2018"
dev.off()
# pdf("Immagini con NIR al posto del rosso - anno 2018")
# ggRGB(v18_bande, 8, 4, 3, stretch="lin") +
    #  ggtitle("2018")
#dev.off()

# salvataggio immagine multiframe 

# importo immagine con bande 

# creo una lista con pattern in comune =  
list18 <- list.files(pattern="**********")
# importo con la funzione raster lapply
import18 <- lapply(list18, raster)
# unisco componenti della list96 in un unico blocco con la funzione raster stack
vaia18_bande <- stack(import18) 

# creo una lista con pattern in comune =  
list19 <- list.files(pattern="**********")
import19 <- lapply(list19, raster)
vaia19_bande <- stack(import19) 

# creo una lista con pattern in comune =  
list22 <- list.files(pattern="**********")
import22 <- lapply(list22, raster)
vaia22_bande <- stack(import22) 

# ritaglio 
v18_bande <- crop(vaia18_bande, e)
v19_bande <- crop(vaia19_bande, e)
v22_bande <- crop(vaia22_bande, e)

v18_bande
v19_bande 
v22_bande 

# vedo quante bande ci sono 

# al posto del rosso nella banda RGB ci metto NIR 

g4 <- ggRGB(v18_bande, 8, 4, 3, stretch="lin") +
      ggtitle("2018")
              
g4 <- ggRGB(v19_bande, 8, 4, 3, stretch="lin") +
      ggtitle("2019")

g4 <- ggRGB(v22_bande, 8, 4, 3, stretch="lin") +
      ggtitle("2022")


# salvo immagini 
pdf("NIR_rosso_anno_2018.pdf")
ggRGB(v18_bande, 8, 4, 3, stretch="lin") +
      ggtitle("Immagini con NIR al posto del rosso - anno 2018")
dev.off()

pdf("NIR_rosso_anno_2019.pdf")
ggRGB(v18_bande, 8, 4, 3, stretch="lin") +
      ggtitle("Immagini con NIR al posto del rosso - anno 2019")
dev.off()

pdf("NIR_rosso_anno_2022.pdf")
ggRGB(v18_bande, 8, 4, 3, stretch="lin") +
      ggtitle("Immagini con NIR al posto del rosso - anno 2022")
dev.off()

# DVI 

#    BANDA   NOME LAYER JULY22   NOME LAYER JULY30
#   NIR=B08     july22_B08          july30_B08
#   RED=B04     july22_B04          july30_B04
#   SWIR=B12    july22_B12          july30_B12         **********++++++++++

# Differenza NIR e red 

dvi18 = v18_bande[[8]] - v18_bande[[4]]
dvi19 = v19_bande[[8]] - v19_bande[[4]]
dvi22 = v22_bande[[8]] - v22_bande[[4]]

# NDVI 

ndvi18 <- dvi18 / v18_bande[[8]] + v18_bande[[4]]
ndvi19 <- dvi19 / v19_bande[[8]] + v19_bande[[4]]
ndvi22 <- dvi22 / v22_bande[[8]] + v22_bande[[4]]

# ggplot
ndviplot18 <- ggplot() +
  geom_raster(ndvi18, mapping = aes(x=x, y=y, fill=layer), show.legend = FALSE) +
  scale_fill_viridis(option = "magma", name = "NDVI") +
  ggtitle("2018")

ndviplot19 <- ggplot() +
  geom_raster(ndvi19, mapping = aes(x=x, y=y, fill=layer), show.legend = FALSE) +
  scale_fill_viridis(option = "magma", name = "NDVI") +
  ggtitle("2019")

ndviplot22 <- ggplot() +
  geom_raster(ndvi22, mapping = aes(x=x, y=y, fill=layer), show.legend = FALSE) +
  scale_fill_viridis(option = "magma", name = "NDVI") +
  ggtitle("2022")


patchwork1 <- ndviplot18 + ndviplot19 + ndviplot22
patchwork1 + plot_annotation(
  title = 'NDVI',
  subtitle = 'Levico Terme negli anni 2018, 2019, 2022',
  caption = 'Fonte: Sentinel 2')

# salvataggio 
pdf("NDVI_santiago.pdf")
print(patchwork1 + plot_annotation(
  title = 'NDVI',
  subtitle = 'Levico Terme negli anni 2018, 2019, 2022',
  caption = 'Fonte: Sentinel 2'))
dev.off

# differenze NDVI 

# 2018 / 2019
diff_ndvi_1 = ndvi18 - ndvi19
plot(diff1)

# 2019 / 2022
diff_ndvi_2 = ndvi19 - ndvi22

# landcover 
landcover18 <- unsuperClass(v18_bande, nClasses=3)
landcover19 <- unsuperClass(v19_bande, nClasses=3)
landcover22 <- unsuperClass(v22_bande, nClasses=3)

landcover18
landcover19
landcover22

# mappa classificazione 
plot(landcover18$map)
plot(landcover19$map)
plot(landcover22$map)

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


