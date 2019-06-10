# 1. load packages
library(network)
library(sna)
library(GGally)

# 2. set working directory
setwd("~/gDrive_main/grad-school/workshops/sna022019/scripts/2_ex2/")

# 3. The dataset, soc-google-plus.txt, is an edge list.
#    Create a data frame from the edge list dataset
g.edges <- read.delim("soc-google-plus.txt", sep = " ", col.names = c("v1", "v2"))

# 4. Create a network object called g.edges.
g.net <- network(g.edges, directed = TRUE, matrix.type = "edgelist")

# 5. Print a summary of the g.net network okject. 
#    How many nodes are there?
#    How many edges are in the network
summary(g.net)
network.size(g.net)
network.edgecount(g.net)

# 5. Print a census of dyads in g.net. How many mutual, asymmetric, and null
#    dyads are present in the network?
network.dyadcount(g.net)

# 6. What is the density of this graph? Is this surprising?
gden(g.net)

# 7. Find the max and min degree of the network. Are there singleton nodes in the graph?
g.deg <- degree(g.net) # Default: total degree
max(g.deg) # max degree
min(g.deg) # min degree

# 8. What are the max in degree and out degree of the network? What about the min?
ideg <- degree(g.net, cmode= "indegree") # indegree
max(ideg)
min(ideg)

odeg <- degree(g.net, cmode= "outdegree") # outdegree
max(odeg)
min(ideg)

# 9. Plot a histogram of the total degree. Do some google-fu on small-world networks. 
#    Is g.net a small-world network?
hist(g.deg)

