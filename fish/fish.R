library(igraph)

liens <- read.table("fish.txt", header=TRUE, sep=",")
monograph <- graph.data.frame(liens, directed = F)
plot(monograph)

monograph2 <- delete.edges(monograph, which(E(monograph)$poidsqte<3000))
plot(monograph2, vertex.size=2, vertex.label = NA)

monograph3 <- delete.vertices(monograph2, V(monograph2)[degree(monograph2) < 1])

plot(monograph3, vertex.size=2, vertex.label = NA)

gorder(monograph)
gsize(monograph)
edge_density(monograph, loops = FALSE)
mean(degree(monograph)-1)
diameter(monograph, directed = F)
transitivity(monograph, type = "global")
mean_distance(monograph)
degree(monograph)

monograph.comm <- cluster_edge_betweenness(monograph, weights = NULL)
monograph.comm <- cluster_fast_greedy(monograph, weights = NULL)
monograph.comm <- cluster_edge_betweenness(monograph, weights = NULL)






