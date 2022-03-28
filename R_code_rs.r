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

# colorazione e assegnazione, 100 sfumature massime di colore 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)

# vedere plot con nuova colorazione 
plot (l2011, col=cl)

# dev.off() per problemi con la grafica 

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicini NIR 
