rm(list = ls())

library(RSiena)

#charger les données
friend.data.w1 <- as.matrix(read.table("s50-1.dat"))
friend.data.w2 <- as.matrix(read.table("s50-network2.dat"))
friend.data.w3 <- as.matrix(read.table("s50-network3.dat"))
#attributs
drink <- as.matrix(read.table("s50-alcohol.dat"))
smoke <- as.matrix(read.table("s50-smoke.dat"))

#?sienaDependent #mode d'emploi
#utiliser siena pour créer une variable a expliquer (variable de comportement : alcool)

drinking <- sienaDependent( drink, type = "behavior" )

#transformation des données en objet Siena

friendship <- sienaNet(
  array(c(friend.data.w1, friend.data.w2, friend.data.w3),
        dim = c(50,50,3)))

#covariance des variables (fumer boire)
smoke1 <- varCovar(smoke)
alcohol <- varCovar(drink)


#combinaison des variables
NBdata <- sienaDataCreate( friendship, smoke1, drinking )


# definition des effets du modèle
NBeff <- getEffects( NBdata )
#afficher le listing des effets
effectsDocumentation(NBeff)

#tester et sélectionner des effets structuraux,
#c'est la que vous devez choisir les différentes variables explicatives (experimentez)
#?includeEffects #utiliser ca pour mode d'emploi

NBeff <- includeEffects( NBeff, transTrip, transRecTrip )
NBeff <- includeEffects( NBeff, egoX, egoSqX, altX, altSqX, diffSqX,
                         interaction1 = "drinking" )
NBeff <- includeEffects( NBeff, egoX, altX, simX, interaction1 = "smoke1" )


#ajouter aux effets variable explicative (conso moyenne d'alcool)
NBeff <- includeEffects( NBeff, avAlt, name="drinking",interaction1 = "friendship" )


#definir algorithme

myalgorithm1 <- sienaAlgorithmCreate( projname = 's50_NB' )

#faire l'estimation des paramètres

resultat <- siena07( myalgorithm1, data = NBdata, effects = NBeff)
resultat

#extraction resultat en html
siena.table(resultat, type="html", sig=TRUE)
