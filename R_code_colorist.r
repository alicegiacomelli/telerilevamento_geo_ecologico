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











