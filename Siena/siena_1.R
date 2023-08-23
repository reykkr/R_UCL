library(RSiena)

#https://www.stats.ox.ac.uk/~snijders/siena/s50_data.htm



#import des données
#le meme reseau mais a trois moment différent histoire de suivre l'évolution
friend.data.w1 <- as.matrix(read.table("s50-1.dat"))
friend.data.w2 <- as.matrix(read.table("s50-network2.dat"))
friend.data.w3 <- as.matrix(read.table("s50-network3.dat"))


#visualisation des matrices
library( network )
library( sna )
net1 <- as.network( friend.data.w1 )
net2 <- as.network( friend.data.w2 )
net3 <- as.network( friend.data.w3 )
plot.sociomatrix( net1,drawlab = F, diaglab = F, xlab = "friendship t1" )
plot.sociomatrix( net2,drawlab = F, diaglab = F, xlab = "friendship t2" )
plot.sociomatrix( net3,drawlab = F, diaglab = F, xlab = "friendship t3" )


#attributs
drink <- as.matrix(read.table("s50-alcohol.dat"))
smoke <- as.matrix(read.table("s50-smoke.dat"))


#visualisation des attributs
plot(net1)
#ajout de l'alcool
net1 %v% "drink" <- drink[,1]
# color the nodes by drink
plot(net1, vertex.col = "drink" )



#transformation en objet Siena (variable à expliquer)
#empilant les 3 matrices 50*50
friendship <- sienaNet(
  array(c(friend.data.w1, friend.data.w2, friend.data.w3),
        dim = c(50,50,3)))

#variable expliquée : l'évolution du réseau
friendship <- sienaDependent(friendship)

#creation des covariables 
#cocovar : constant actor covariate (juste pour utiliser dans l'exemple, pas de sens d'être constante)
smoke1 <- coCovar(smoke[,1])
#varCovar : variable actor covariate
alcohol <- varCovar(drink)

#combinaison des variables
mydata <- sienaDataCreate(friendship, smoke1, alcohol)

#create output avec satistique descriptives de base (output dans un fichier texte)
print01Report( mydata, modelname="s50_xyztre")


#spécification du modèle :

#creation de l'objet des effets
myeff <- getEffects(mydata)

#liste effets possibles
effectsDocumentation(myeff)


#tester et sélectionner des effets structuraux
#manuel : ?includeEffects
myeff <- includeEffects( myeff, transTrip, cycle3)

#myeff <- includeEffects(myeff, similarity, cycle3)
summary(myeff)

myeff <- includeEffects( myeff, egoX, altX, simX, interaction1 = "alcohol" )
myeff <- includeEffects( myeff, simX, interaction1 = "smoke1" )

#simx  (similarity)
#egox  (helps one make links)
#altx  (enhances (or reduces) popularity)

#creation algorithme
#?sienaAlgorithmCreate : manuel
myalgorithm <- sienaAlgorithmCreate( projname = 's50' )

#estimation des paramètres
#?siena07 : manuel
ans <- siena07( myalgorithm, data = mydata, effects = myeff)
ans

#création du modèle et estimation des paramètres
#mymodel <- sienaModelCreate(useStdInits = FALSE, projname="s50_3")


#ans <- siena07(mymodel, data = mydata, effects = myeff)
#summary(ans)