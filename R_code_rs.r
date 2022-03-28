# questo è il primo script che useremo a lezione 

# install.packages("raster")
library(raster)

# settaggio cartella di lavoro, file nella cartella zip scaricata, importare cartella   
setwd("/Users/alicegiacomelli/desktop/lab")

# importazione immagine e assegnazione 
l2011 <- brick("p224r63_2011.grd")

# vedere info immagine
l2011

# vedere grafica 
plot(l2011)

# colorazione e assegnazione, 100 sfumature massime di colore 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

# vedere grafica con nuova colorazione 
plot (l2011, col=cl)

# dev.off() per problemi con la grafica 
