rm(list=ls())

#require(devtools)  
#install.packages("cartography", dependencies = TRUE)
#devtools::install_github(repo = 'rCarto/rCarto')

#vieux truc donc dur a installer. s'appelle cartography maintenant. pas eu le temps de changer script
#packages
library(reshape2)

#les deux packages indispensables
library(maptools)   # spatial vector data
library (rgdal)     # Geospatial Data Abstraction Library for spatial data

library(rCarto)     # vieux package que je dois changer (remplacer par cartography)
#donne des fonction sympatoche pour affichage.
library(cartography)

#importation et transformation d'une matrice de flux
#chargement d'une matrice de flux
tab <- read.table("migrations.csv",
                  header=TRUE,
                  sep=";",
                  stringsAsFactors=FALSE,
                  encoding="UTF-8")
str(tab)
tab

mat <- as.matrix(tab[,-1])
row.names(mat) <- tab[,1]
mat


Fij<-mat
#slice to see
Fij[1:3,1:3]

#transpose
Fji <- t(mat)
#slice to see
Fji[1:3,1:3]

#départ + arrivé
Fvij <- Fij + Fji
#slicing
Fvij[1:3,1:3]


#départ - arrivé
Fsij <- Fij - Fji
#slicing
Fsij[1:3,1:3]

O <- apply(Fij, 1, sum) #sum rows
D <- apply(Fij, 2, sum) #sum of cols
V <- O + D
S <- D - O
A <- round(S/V, 2)
param <- data.frame(cbind(O,D,V,S,A))
param$CODE <- row.names(param)

#cartographie

carte <- "fondcarte.shp"
fdc <- readOGR(carte)

head(fdc@data) #connaitre id des polygones

