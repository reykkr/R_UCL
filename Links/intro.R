library(igraph)

liens <- read.table("liens.txt", header=TRUE, sep=";")

attributs <- read.table("attribut.txt", header = TRUE, sep = ";")
monograph <- graph.data.frame(liens,vertices = attributs,  directed = F)

tailledesnoeuds <- get.vertex.attribute(monograph,"taille")

largeurdesliens <- get.edge.attribute(monograph, "poid")

couleursdesnoeuds <- get.vertex.attribute(monograph, "Type")
couleursutilisees = c("green","blue")
couleursdesnoeuds[couleursdesnoeuds == "True"] = couleursutilisees[1]
couleursdesnoeuds[couleursdesnoeuds == "False"] = couleursutilisees[2]


plot(monograph, vertex.size = 5 * tailledesnoeuds,vertex.color = couleursdesnoeuds,edge.width = largeurdesliens)




