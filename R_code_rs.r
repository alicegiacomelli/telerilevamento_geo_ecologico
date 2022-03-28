# questo è il primo script che useremo a lezione 

# install.packages("raster")
library(raster)

# settaggio cartella di lavoro, trovare file nella cartella zip scaricata  
setwd("/Users/alicegiacomelli/desktop/lab")

# importazione immagine e assegnazione 
l2011 <- brick("p224r63_2011.grd")

# vedere info immagine
l2011

class      : RasterBrick 
dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)
resolution : 30, 30  (x, y)
extent     : 579765, 668775, -522705, -477735  (xmin, xmax, ymin, ymax)
crs        : +proj=utm +zone=22 +datum=WGS84 +units=m +no_defs 
source     : p224r63_2011.grd 
names      :      B1_sre,      B2_sre,      B3_sre,      B4_sre,      B5_sre,       B6_bt,      B7_sre 
min values :         0.0,         0.0,         0.0,         0.0,         0.0,       295.1,         0.0 
max values :   1.0000000,   0.2563655,   0.2591587,   0.5592193,   0.4894984, 305.2000000,   0.3692634 

plot(l2011)

# colorazione e assegnazione, 100 sfumature massime di colore 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot (l2011, col=cl)

# dev.off() per problemi con la grafica 
