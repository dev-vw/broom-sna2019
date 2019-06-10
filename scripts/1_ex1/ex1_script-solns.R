## If you haven't already, install the following packages
## install.packages("network")
## install.packages("sna")
## install.packages("GGally")

##### ----- SOME PRELIMINARIES ----- #####

# This sets the working directory
# This will be user-specific, choose a folder where you stored your data files
setwd("~/gDrive_main/grad-school/workshops/sna022019/scripts/1_ex1/")

# This loads the libraries
library(network) # allows us to create network objects
library(sna)     # allows us to calculate network metrics
library(GGally)  # allows us to plot pretty network visualizations

##### ----- DATA PROCESSING ----- #####

# Read an adjacency matrix (R stores it as a data frame by default)
relations <- read.csv("ex1_ad-matrix.csv", header = FALSE, stringsAsFactors = FALSE)

# When the matrix format is preferred, here's how you convert
relations <- as.matrix(relations)

# Read in some vertex attribute data (it's okay to leave this as a data frame)
node.info <- read.csv("ex1_vertex-attr.csv", header = TRUE, stringsAsFactors = FALSE)

# Since our relational data has no row/column names, let's set them now
rownames(relations) <- node.info$name
colnames(relations) <- node.info$name

# An aside about factors: why did we set stringsAsFactors = FALSE?
relations_wFactors<-read.csv("ex1_vertex-attr.csv", header = TRUE)

# Answer: if we perform the following action, an error is thrown
relations_wFactors[1,2]<-"Derek"

# Here's another illustrative example of factor idiosyncracies
numFactor <- as.factor(c(1,3,5))
numFactor + 1
numFactor <- as.numeric(numFactor)
numFactor + 1

##### ----- MAKING NETWORK OBJECTS ----- #####
# here, we will create two networks, one directed (nedge)
# and the other undirected (nrelations)

## ----- (1) Data source: adjacency matrix
# Create a network object based on relations (an adjacency matrix). 
# This is NOT a directed graph (directed = FALSE)
nrelations <- network(relations, directed = FALSE)
nrelations # Get a quick description of the data

## ----- (2) Data source: new network
# What if we wanted to start from a blank slate? 
# Let's make a brand new network object with 5 vertices.
nempty <- network.initialize(5)
nempty # Compare with nrelations by taking a quick look

## ----- (3) Data source: edge list
edgelist <- read.csv("ex1_edge-attr.csv", header = TRUE, stringsAsFactors = FALSE)
head(edgelist)

nedge <- network(edgelist, matrix.type = "edgelist")
nedge
nedge[,]
gplot(nedge, displaylabels = TRUE)

# ignore.eval is FALSE because we want to incorporate weight metrics
nedge <- network(edgelist, matrix.type="edgelist", ignore.eval = F, names.eval="weight")
nedge
nedge[,]
gplot(nedge, displaylabels = T, edge.lwd = as.sociomatrix(nedge, "weight")*5)

##### ----- NETWORK OVERVIEW ----- #####

summary(nrelations) # Get an overall summary
network.edgecount(nrelations) # How many edges are present?
network.size(nrelations) # How large is the network (i.e. How many nodes are in the network?)
as.sociomatrix(nrelations) # Show it as a sociomatrix
nrelations[,] # Another way to do it

##### ----- NETWORK VISUALIZATION ----- #####

plot(nrelations,displaylabels = TRUE) # Plot with names

# a multiplier to expand the horizontal axis if node labels get clipped
ggnet2(nrelations, label = TRUE, layout.exp = 0.2)
ggnet2(nedge, arrow.size = 12, arrow.gap = 0.05, label = TRUE)

##### ----- MUNIPULATING NETWORKS ----- #####

## ----- (1) Adding and deleting edges

# Create an empty graph
g <- network.initialize(5)
ggnet2(g, label = TRUE)

# Add an edge from 1 to 2
g[1, 2] <- 1
ggnet2(g, label = TRUE)

# Add edges from 2 to everyone else
g[2, ] <- 1 
ggnet2(g, label = TRUE)

# Now, let's delete edges
g[2, 5] <- 0 # Remove the edge from 3 to 5
ggnet2(g, label = TRUE)

# Testing adjacency of nrelations
nrelations_sm <- as.sociomatrix(nrelations)
nrelations["Emma", "Sarah"] # Emma to Sarah?
nrelations["Emma",]         # Emma to all other nodes

## ----- (2) Vertex Attributes 

# Add some attributes to nrelations from node.info
nrelations %v% "id" <- node.info$id 
nrelations %v% "age" <- node.info$age
nrelations %v% "sex" <- node.info$sex
nrelations %v% "handed" <- node.info$handed
nrelations %v% "lastDocVisit" <- nodeInfo$lastDocVisit

# Listing attributes
list.vertex.attributes(nrelations) # List all vertex attributes

# Retrieving attributes
nrelations %v% "age" # Retrieve vertex ages
nrelations %v% "id" # Retrieve vertex ids

##### ----- Network Analysis with the SNA package ----- #####

## ----- (1) We begin with the simplest case: degree centrality
# let's take a look at the network first
ggnet2(nedge, arrow.size = 12, arrow.gap = 0.05, label = TRUE)

degree(nedge) # Default: total degree
ideg <- degree(nedge, cmode= "indegree") # indegree
odeg <- degree(nedge, cmode= "outdegree") # outdegree

# let's confirm that in + out = total?
degree(nedge) == ideg + odeg 

# Plot simple histograms of the degree distribution:
par(mfrow=c(2,2)) # Set up a 2x2 display

hist(ideg, 
     xlab="Indegree",
     main="Indegree Distribution", 
     prob=TRUE)

hist(odeg, 
     xlab="Outdegree", 
     main="Outdegree Distribution", 
     prob=TRUE)

hist(ideg+odeg, 
     xlab="Total Degree", 
     main="Total Degree Distribution", 
     prob=TRUE)

par(mfrow=c(1,1)) # Restore display

## ----- (2) Next, let's look at betweeness centrality
# Betweenness centrality calculation, gmode indicates the type of graph being
# evaluated. "graph" indicates undirected graph.
ggnet2(nrelations, arrow.size = 12, arrow.gap = 0.05, label = TRUE)
bet <- as.matrix(betweenness(nrelations, gmode= "graph"))
rownames(bet) <- colnames(nrelations[,])
bet

## ----- (3) Geodesic distance
# Can use sna routines to explore alternatives to the common measures. . .
nrelations_gdist <- geodist(nrelations)$gdist # matrix of geodesic distances
nrelations_gdist

# max of all geodesic distances
max(nrelations_gdist[nrelations_gdist != Inf])

## ----- (4) Elementary graph-level indices
gden(nrelations) # Density
ggnet2(nedge, arrow.size = 12, arrow.gap = 0.05, label = TRUE)

## ----- (5) Dyad census routines
# dyad counnts for nrelations and nedges
dyad.census(nrelations)
dyad.census(nedge)
