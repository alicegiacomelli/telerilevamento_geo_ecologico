# librerie 
# install.packages("colorist")
library(colorist)
library(ggplot2)

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
# distillare la mappa 
# metrica 
met1_distill<-metrics_distill(fiespa_occ)

# mappa distillata 
# creo mappa singola con la nostra metrica 
# palette iniziale 
map_single(met1_distill,pal) 
# palette 2
map_single(met1_distill,p1custom)
# parti grigie = bassa specificità 














