library(ergm)
data(florentine)
flomarriage
#visualisation
plot(flomarriage)

#modèle - les liens présents sont dépendants
#de la richesse des acteurs

#somme argent
flomodel <- ergm(flomarriage ~ edges + nodecov("wealth"))
summary(flomodel)


#difference argent
test <- ergm(flomarriage ~ edges + absdiff("wealth") + triangle)
summary(test)
#voir ici pour le mode d'emploi : https://zalmquist.github.io/ERGM_Lab/ergm-terms.html

#modifier coefficient avant interpretation.
#e(coefficient) / (1 + e(coefficient))

#simuler 30 réseaux ayant les mêmes probabilités
flomodel.sim <- simulate(flomodel, nsim=30)



#vérifier qualité du modèle selon un critère
#ici le degré
flomodel.gof <- gof(flomodel~degree)
plot(flomodel.gof)


