#----------------------------#
# Step 7 Test for similarity
#----------------------------#

# clear environment
rm(list=ls())

# please install qqplot2 package if you don't have it on your computer
# install.packages("ggplot2")
# install.packages("stringr")
library(ggplot2)
library(stringr)
library(reshape2)
setwd("../treedist")

# please check "fake-chr4-all.tre" and "fake-chr4-adj.tre" in the folder of "treedist"
# "fake-chr4-all.tre" is as follows:
# 4 4
# Tree0       0 0 2 1
# Tree1       0 0 2 1
# Tree2       2 2 0 1
# Tree3       1 1 1 0

# "fake-chr4-adj.tre" is as follows:
# XXX        1 4
# 0 2 1 0

all.tre <- read.table("fake-chr4-all.tre")
rfdist <- read.table("fake-chr4-all.tre.rfdist", skip=1, row.names = 1)
colnames(rfdist) <-row.names(rfdist)
rfdist

adj.rfdist <- read.table("fake-chr4-adj.tre.rfdist", row.names=NULL)
adj.rfdist

# :::::::::::::
# :::: A ::::::
# :::::::::::::


# ::: 1. find n
# # way 1
# n <- dim(read.table("fake-chr4-all.tre", sep=","))[2]
# # way 2
# n <- read.table("fake-chr4-all.tre.rfdist", nrows=1)[1,2]

n <- str_count(all.tre[1],",") + 1

# ::: 2. find observed distance
# find distances between all pairs of trees.
distance <- rfdist[lower.tri(rfdist)]

# ::: 3. find D
set.seed(42)
S <- rpois(length(distance), 1/8) 
D <- 2*(n-3-S)

# ::: 4. make a graph
# ggplot(S, aes(x=S)) + geom_histogram(aes(y=..density..), binwidth=0.5, color="black", fill="white") +
#     geom_density(alpha=.2, fill="#FF6666") + stat_function(fun=dpois, args=list(1/8)) 
D_distance <- data.frame(D = D, distance = distance)
D_distance.m <- melt(D_distance)
ggplot(D_distance.m,aes(x=value, fill=variable)) + geom_density(alpha=0.2)

# scale needs to be consistent. histogram's scale is not the density scale. need to check!

# :::::::::::::
# :::: B ::::::
# :::::::::::::

# ::: 2. find true distance
adj.distance <- as.numeric(adj.rfdist[-length(adj.rfdist)]) # The last 0 is extra.

# ::: 3. find D
set.seed(42)
adj.S <- rpois(length(adj.distance), 1/8) 
adj.D <- 2*(n-3-S)


# ::: 4. make a graph
adj.D_distance <- data.frame(adj.D = adj.D, adj.distance = adj.distance)
adj.D_distance.m <- melt(adj.D_distance)
ggplot(adj.D_distance.m,aes(x=value, fill=variable)) + geom_density(alpha=0.2)

# ggplot(adj.S, aes(x=adj.S)) + geom_histogram(aes(y=..density..), binwidth = 0.1, color="black", fill="white") +
#   geom_density(alpha=.2, fill="#FF6666") + stat_function(fun=dpois, args=list(1/8)) 
# scale needs to be consistent. histogram's scale is not the density scale. need to check!
