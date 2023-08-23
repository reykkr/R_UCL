#install.packages("drat")
#drat::addRepo("schochastics")
#install.packages("networkdata")
rm(list = ls())

library(networkdata)
library(ergm)
library(intergraph)



library(igraph)
data(package = "networkdata")
tennis<-data(atp)

net <- asNetwork(atp[[10]])

plot(atp[[10]])

plot(net)

#comment enlever des valeurs vides sur la variable age, je mets toutes les valeurs vides a 17

V(atp[[10]])$age[which(is.na ( V(atp[[10]])$age))] <- 17

#utiliser ERGM pour expliquer victoires de 2021

monresultat <- ergm(net ~ edges + absdiff("age") + mutual + nodematch("hand") + nodecov("age"))

summary(monresultat)




