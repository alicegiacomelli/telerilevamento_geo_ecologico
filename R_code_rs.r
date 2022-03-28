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

