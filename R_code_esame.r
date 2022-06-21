########## ANALISI DEI BOSCHI SOPRA LEVICO TERME NEGLI ANNI 2018, 2019, 2022 ########## 
      ####### COME IL TERRITORIO E' CAMBIATO IN SEGUITO ALLA TEMPESTA VAIA #######


# impatto della tempesta Vaia nei boschi sopra Levico Terme, una delle zone più colpite da questa calamità naturale.
# la tempesta Vaia è stata un evento metereologico che ha interessato il Triveneto dal 26 al 30 ottobre 2018.
# ha causato l'abbattimento di 42 milioni di alberi (dato mai registrato in epoca recente in Italia), su una siperficie di 41 mila ettari di territorio. 

# attraverso l'analisi di una immagine satellitare risalente a fine agosto 2018 (pre-tempesta), una immagine di giugno 2019 (qualche mese dopo la tempesta) 
# e una immagine di giugno 2022, analizzerò come è cambiato il terriorio nei boschi sopra Levico Terme. 

# in particolare suddividerò il mio lavoro in:
# IMPORTAZIONE E VISUALIZZAZIONE IMMAGINI SATELLITARI 
# INDICI SPETTRALI - DVI E NDVI
# LANDCOVER 
# VARIABILITA'

################################

# librerie 
library(raster)       # gestione immagini raster
library(ggplot2)      # visualizzazione dati in modo potente, per plot con ggplot
library(RStoolbox)    # visualizzazione immagine e calcolo variabilità
library(patchwork)    # per multiframe con plot ggplot2

# set working directory 
setwd("/Users/alicegiacomelli/Desktop/lab/vaia")

########## IMPORTAZIONE E VISUALIZZAZIONE IMMAGINI ##########

# Immagini scaricate da https://earthexplorer.usgs.gov/ 
# Immagini dal satellite Sentinel 2 

# BANDE SENTINEL 2:

# B01= coastal aerosol                 0.443                           
# B02= blue                            0.490                           
# B03= green                           0.560                           
# B04= red                             0.665                           
# B05= vegetation red edge             0.705                           
# B06= vegetation red edge             0.740                           
# B07= vegetation red edge             0.783                           
# B08= NIR                             0.842                           
# B08A= vegetation red edge            0.865                           
# B09= water vapour                    0.945                           
# B11= SWIR                            1.610                           
# B12= SWIR                            2.190    


# importazione 1: immagine a colori naturali
# importazione tramite funzione raster brick che mi permette di caricare più bande contemporaneamente

vaia18 <- brick("T32TPS_20180827T101021_TCI_10m.jp2")
vaia18 # info immagine

vaia19 <- brick("T32TPS_20190628T101039_TCI_10m.jp2")
vaia19 # info immagine

vaia22 <- brick("T32TPS_20220612T100559_TCI_10m.jp2")
vaia22 # info immagine 

# immagini a 8 bit 
# risoluzione 10m 

# immagini composta da 3 bande
# banda 1 = red
# banda 2 = green 
# banda 3 = blue 

# plot immagini a colori naturali 
# plotto tramite la funzione ggRGB del pacchetto ggplot2 
# titolo tramite ggtitle 

g18 <- ggRGB(vaia18, 1, 2, 3, stretch = "lin") + 
  ggtitle("2018")

# stretch lineare: dai valori originali si crea una nuova banda con valori da 0 a 100
# si ampliano i valori,riscalandoli attraverso una funzione lineare
# aumenta potenza visualizzazione (contrasto)

g19 <- ggRGB(vaia19, 1, 2, 3, stretch = "lin") + 
  ggtitle("2019")
  
g22 <- ggRGB(vaia22, 1, 2, 3, stretch = "lin") +
  ggtitle("2022")

# le visualizzo una di fianco all'altra 
g18 + g19 + g22
 
# per avere una immagine più specifica dell'area che voglio analizzare 
# ritaglio le immagini iniziali  

# plotto l'immagine 
plotRGB(vaia22, 1, 2, 3, stretch = "lin") 
# tramite la funzione drawExtent del pacchetto raster
# seleziono direttamente sull'immagine la zona d'interesse
# drawExtent(show=TRUE, col="red") 

# class      : Extent 
# xmin       : 672207.6 
# xmax       : 684354.3 
# ymin       : 5097386 
# ymax       : 5103496 

# creo un vettore con xmax, xmin, ymax, ymin
# valori presi dalle info di drawExtent
e <- extent(c(672207.6, 684354.3, 5097386, 5103496))

# ritaglio le immagini tramite la funzione crop del pacchetto raster 
v18 <- crop(vaia18, e)
v19 <- crop(vaia19, e)
v22 <- crop(vaia22, e)

# plotto le immagini ritagliate ottenute con ggplot 
# + ggtitle per titolo
g18_crop <- ggRGB(v18, 1, 2, 3, stretch = "lin") + 
  ggtitle("2018")

g19_crop <- ggRGB(v19, 1, 2, 3, stretch = "lin") + 
  ggtitle("2019")

g22_crop <- ggRGB(v22, 1, 2, 3, stretch = "lin") + 
  ggtitle("2022")

#  multiframe dei ggplot tramite funzione patchwork del pacchetto patchwork
# tramite plot_annotation do un titolo e sottotitolo
patchwork1 <- g18_crop + g19_crop + g22_crop
patchwork1 + plot_annotation(
  title = 'Immagini colori naturali',
  subtitle = 'Boschi sopra Levico Terme nel 2018, 2019, 2022')


# SALVATAGGIO 

# pdf("Immagini_colori_naturali_2018.pdf")
# g18_crop + plot_annotation(
  # title = 'Immagine colori naturali - anno 2018',
  # subtitle = 'Boschi sopra Levico Terme')
# dev.off()

# pdf("Immagini_colori_naturali_2019.pdf")
# g19_crop + plot_annotation(
  # title = 'Immagine colori naturali - anno 2019',
  # subtitle = 'Boschi sopra Levico Terme')
# dev.off()

# pdf("Immagini_colori_naturali_2022.pdf")
# g22_crop + plot_annotation(
  # title = 'Immagine colori naturali - anno 2022',
  # subtitle = 'Boschi sopra Levico Terme')
# dev.off()



### da una prima analisi si può vedere come la situazioni cambi drasticamente tra il 2018 e 2019: 
### nella prima immagine salta all'occhio il verde della zona, mentre nel 2019 si possono notare le vaste aree marroni che si sono sostituite ai boschi 
### l'immagine del 2022, è maggiormente verde rispetto a quella del 2019, ma non raggiunge i livelli del 2018. 



# importazione 2: immagini con bande 1,2,3,4 

# importazione bande singole: 
# banda 1 = B02 = blue
# banda 2 = B03 = green
# banda 3 = B04 = red
# banda 4 = B08 = NIR

# creo una lista con pattern in comune = 1021_B
list18 <- list.files(pattern="1021_B")
# importo con la funzione lapply del pacchetto raster
import18 <- lapply(list18, raster)
# unisco componenti della list18 in un unico blocco con la funzione raster stack del pacchetto raster
vaia18_bande <- stack(import18) 
vaia18_bande # per vedere nomi delle bande 

# faccio lo stesso procedimento per le immagini del 2019 e 2022

# creo una lista con pattern in comune = 1039_B
list19 <- list.files(pattern="1039_B")
# importo con la funzione lapply del pacchetto raster
import19 <- lapply(list19, raster)
# unisco componenti della list19 in un unico blocco con la funzione raster stack del pacchetto raster
vaia19_bande <- stack(import19) 
vaia19_bande # per vedere nomi delle bande

# creo una lista con pattern in comune =  0559_B
list22 <- list.files(pattern="0559_B")
# importo con la funzione lapply del pacchetto raster
import22 <- lapply(list22, raster)
# unisco componenti della list22 in un unico blocco con la funzione raster stack del pacchetto raster
vaia22_bande <- stack(import22) 
vaia22_bande # per vedere nomi delle bande

# ritaglio le immagini appena importato con gli stessi valori calcolati precedentemente (drawExtend)
# tramite la funzione crop del pacchetto raster 
v18_bande <- crop(vaia18_bande, e)
v19_bande <- crop(vaia19_bande, e)
v22_bande <- crop(vaia22_bande, e)

# visualizzo le informazioni 
v18_bande
v19_bande 
v22_bande 

# plot ggRGB
# al posto del rosso nella banda RGB ci metto NIR 
g18_bande <- ggRGB(v18_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2018")
g18_bande # plot

g19_bande <- ggRGB(v19_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2019")
g19_bande # plot

g22_bande <- ggRGB(v22_bande, 4, 3, 2, stretch="lin") +
      ggtitle("2022")
g22_bande # plot

# creo un multiframe con funzione patchwork del pacchetto patchwork (solo con ggplot2)
patchwork2 <- g18_bande + g19_bande + g22_bande
patchwork2 + plot_annotation(
  title = 'Immagini con NIR sulla prima banda',
  subtitle = 'Boschi sopra Levico Terme nel 2018, 2019, 2022')

# SALVATAGGIO 

# pdf("NIR_rosso_anno_2018.pdf")
# ggRGB(v18_bande, 4, 3, 2, stretch="lin") +
      # ggtitle("2018")
# dev.off()

# pdf("NIR_rosso_anno_2019.pdf")
# ggRGB(v19_bande, 4, 3, 2, stretch="lin") +
      # ggtitle("2019")
# dev.off()

# pdf("NIR_rosso_anno_2022.pdf")
# ggRGB(v22_bande, 4, 3, 2, stretch="lin") +
      # ggtitle("2022")
# dev.off()



### in questa nuova visualizzazione il rosso rappresenta la vetazione!
### ciò che non è vegetazione, è rappresentato in azzurrino/verde 
### il contrasto permette di visualizzare gli effetti della tempesta Vaia in maniera ancora più evidente 



########## INDICI SPETTRALI ##########

# la vegetazione assorbe la radiazione solare in diverse bande 
# ossia in diversi intervalli di frequenza e lunghezze d’onda ne riemette una percentuale differente in ciascuna di esse. 
# La percentuale di radiazione riemessa in bande specifiche, come quelle del vicino infrarosso (NIR), del rosso (RED), indica lo stato di salute della pianta

##### DVI #####

# Difference Vegetation Index

# Differenza NIR e red 
# banda 4 = NIR
# banda 3 = red
dvi18 = v18_bande[[4]] - v18_bande[[3]]
dvi19 = v19_bande[[4]] - v19_bande[[3]]
dvi22 = v22_bande[[4]] - v22_bande[[3]]

# informazioni
dvi18
dvi19
dvi22

##### NDVI #####

# Normalized Difference Vegetation Index

# range -1, 1

# dvi / somma banda NIR e red
ndvi18 = dvi18 / (v18_bande[[4]] + v18_bande[[3]])
ndvi19 = dvi19 / (v19_bande[[4]] + v19_bande[[3]])
ndvi22 = dvi22 / (v22_bande[[4]] + v22_bande[[3]])

# informazioni
ndvi18  
ndvi19
ndvi22

# plot immagini risultanti

# utilizzo una palette di colori specifica 
cl <- colorRampPalette(c('darkblue','green','red','black'))(100)

ndvi18_plot <- plot(ndvi18, col=cl)
ndvi19_plot <- plot(ndvi19, col=cl)
ndvi22_plot <- plot(ndvi22, col=cl)

# multiframe tramite funzione par del pacchetto raster 
# con 1 riga e 3 colonne 
par(mfrow=c(1,3))
plot(ndvi18, col=cl)
plot(ndvi19, col=cl)
plot(ndvi22, col=cl)

# SALVATAGGIO 

# pdf("ndvi_2018.pdf")
# plot(ndvi18, col=cl) +
# title(main="NDVI 2018")
# dev.off()

# pdf("ndvi_2019.pdf")
# plot(ndvi19, col=cl) +
# title(main="NDVI 2019")
# dev.off()



### nel grafico del 2018 la maggior parte del territorio ricade nei valori intorno all'1, con colorazione vicino al bianco
### questo significa copertura vegetale completa con alta vigoria 
### nel grafico del 2019 il territorio cambia colore, molte zone diventano rosse, cioè hanno dei valori inferiori allo 0.5
### questo significa che il grado di salute e vigoria della vegetazione è diminuito 



# differenze NDVI 

# 2018 / 2019
ndvi_dif1 = ndvi18 - ndvi19
ndvi_dif2 = ndvi19 - ndvi22

# utilizzo una palette specifica
cl <- colorRampPalette(c('darkblue','yellow','red','white'))(100)

# plot immagini risultanti
plot(ndvi_dif1, col=cl)
plot(ndvi_dif2, col=cl)

# multiframe tramite funzione par del pacchetto raster 
# con 1 riga e 2 colonne 
par(mfrow=c(1,2))
plot(ndvi_dif1, col=cl)
plot(ndvi_dif2, col=cl)

# pdf("differenze_ndvi_2018_2019.pdf")
# plot(ndvi_dif1, col=cl) +
# title(main = "Differenze NDVI 2018/2019")
# dev.off()


########## LANDCOVER ##########

# quantifico le pecentuale di lancover degli anni 2018 e 2022 e ne faccio un confronto 

# divido i pixel dell'immagine in 4 classi 
# tramite la funzione unsuperClass del pacchetto RStoolbox
landcover18 <- unsuperClass(v18_bande, nClasses=4)
landcover22 <- unsuperClass(v22_bande, nClasses=4)

# visualizzo le informazioni
landcover18
landcover22

# plotto la mappa con le classificazioni  
plot(landcover18$map) 
plot(landcover22$map)
# NB: i colori della seconda immagine rappresentano classi diverse rispetto ai colori della prima immagine 

# creo un multiframe con 1 riga e 3 colonne con la funzione par del pacchetto raster
# per visualizzare meglio le differenze 
par(mfrow=c(1,3))
plot(landcover18$map)
plot(landcover22$map)

# SALVATAGGIO 

# pdf("landcover_2018.pdf")
# plot(landcover18$map)
# dev.off()

# pdf("landcover_2022.pdf")
# plot(landcover22$map)
# dev.off()



### da una prima osservazione, nonostante i colori diversi, si possono notare delle zone dove il confine di cambio colore varia
### inoltre c'è maggiore frammentarietà dei colori 



# per operare una analisi più precisa:
# quantifico la differenza di landcover tra le due immagini
# calcolo la percentuale 
# creo dei grafici 

# calcolo la frequenza delle mappe singole 
freq(landcover18$map)
#      value    count
# [1,]     1   269484 (terreno)
# [2,]     2   348465 (bosco)
# [3,]     3    62300 (acqua)
# [4,]     4    61505 (città)

freq(landcover22$map)
#      value   count
# [1,]     1   57954 (acqua)
# [2,]     2   82523 (città)
# [3,]     3  296801 (terreno)
# [4,]     4  304476 (bosco)

# numero totale di pixel 
v18_bande
v22_bande
# v18 : dimensions : 611, 1214, 741754, 4  (nrow, ncol, ncell, nlayers)
# v22 : dimensions : 611, 1214, 741754, 4  (nrow, ncol, ncell, nlayers)
tot <- 741754


# percentuale bosco 
perc_bosco_18 <- 348465 * 100 / tot
perc_bosco_19 <- 304476 * 100 / tot
perc_bosco_18 # 46.97851
perc_bosco_19 # 41.04811

# percentuale terreno 
perc_terreno_18 <- 269484 * 100 / tot
perc_terreno_22 <- 296801 * 100 / tot
perc_terreno_18 # 36.33064
perc_terreno_22 # 40.0134

# percentuale città 
perc_citta_18 <- 61505 * 100 / tot
perc_citta_22 <- 82523 * 100 / tot
perc_citta_18 # 8.291833
perc_citta_22 # 11.12539

# percentuale acqua 
perc_acqua_18 <- 62300 * 100 / tot
perc_acqua_22 <- 57954 * 100 / tot
perc_acqua_18 # 8.399011
perc_acqua_22 # 7.813102


# creo dei vettori da mettere poi nel dataframe 
class <- c("Bosco", "Terreno", "Città", "Acqua")
percent_2018 <- c(46.97851, 36.33064, 8.291833, 8.399011)                
percent_2022 <- c(41.04811, 40.0134, 11.12539, 7.813102)


# creo un dataframe tramite la funzione data.frame (funzione base di R)
multitemporal <- data.frame(class, percent_2018, percent_2022)
multitemporal # info


# creo dei barplot (grafici a istogrammi)
# tramite la funzione ggplot del pacchetto ggplo2
# tramite la funzione geom_bar del pacchetto ggplot2
barplot18 <- ggplot(multitemporal, aes(x=class, y=percent_2018, color=class)) +
             geom_bar(stat="identity", fill="white") +
             ggtitle("2018")
barplot18 # visualizzazione
# stat = "legenda"
# fill = "colore bande"

barplot22 <- ggplot(multitemporal, aes(x=class, y=percent_2022, color=class)) +
             geom_bar(stat="identity", fill="white") +
             ggtitle("2022")
barplot22 # visualizzazione 

# creo un multiframe tramite la funzione patchwork del pacchetto patchwork 
patchwork_barplot <- barplot18 + barplot22
patchwork_barplot + plot_annotation(
  title = 'Percentuali landcover',
  subtitle = 'Confonto 2018-2022')

# SALVATAGGIO 

# pdf("barplot_percentuali_landcover_2018.pdf")
# barplot18 + plot_annotation(
  # title = 'Percentuali landcover 2018',
  # subtitle = 'Boschi sopra Levico Terme')
# dev.off()    

# pdf("barplot_percentuali_landcover_2022.pdf")
# barplot12 + plot_annotation(
  # title = 'Percentuali landcover 2022',
  # subtitle = 'Boschi sopra Levico Terme')
# dev.off()    



### dalle percentuali si può vedere che il bosco, tra il 2018 e il 2022, è diminuito dal 47% al 41% 
### altro dato curioso è anche l'incremento della citta: dall'8% nel 2018 all'11% nel 2022



########## VARIABILITA' ##########

# variabilità = deviazione standard

# richiamo banda NIR
nir1 <- v18_bande[[4]]
nir2 <- v19_bande[[4]]

# creo 3 nuovi file raster con variabilità
# la variabilità la calcolo attraverso la deviazione standard 
# matrice di di 3*3
# assegnazione del valore al pixel centrale 
sd1 <- focal(nir1, matrix(1/9, 3, 3), fun=sd)
sd2 <- focal(nir2, matrix(1/9, 3, 3), fun=sd)

# utilizzo una palette specifica 
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)

# plot eterogeneità
plot(sd1, col=clsd)
plot(sd2, col=clsd)

# creo un multiframe tramite la funzione par del pacchetto raster
par(mfrow=c(1,2))
plot(sd1, col=clsd)
plot(sd2, col=clsd)


# SALVATAGGIO 

# pdf("eterogeneità.pdf")
# par(mfrow=c(1,2))
# plot(sd1, col=clsd) +
# title(main="Variabilità 2018")
# plot(sd2, col=clsd) +
# title(main="2019")
# dev.off()



### con il calcolo della variabilità si nota come questa sia maggiore nell'anno 2019, seguita dal 2022 e infine dal 2019
### questo perchè la tempesta Vaia ha creato maggiore eterogeneità del terreno in una zona dove originariamente c'era il bosco
