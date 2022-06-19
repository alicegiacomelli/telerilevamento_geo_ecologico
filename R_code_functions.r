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
