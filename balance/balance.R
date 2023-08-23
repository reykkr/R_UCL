library(igraph)
library(openxlsx)

monDataset <- read.xlsx("balancetonmetro.xlsx", colNames = TRUE)

duplicated(monDataset)