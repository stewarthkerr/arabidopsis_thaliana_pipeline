#install.packages("ggplot2")
library(ggplot2)
setwd("~/Desktop/STAT992/project-team-12/treedist")

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
rfdist <- read.table("fake-chr4-all.tre.rfdist", skip=1)
row.names(rfdist) <- rfdist[,1]
rfdist <- rfdist[, -1]
rfdist

adj.rfdist <- read.table("fake-chr4-adj.tre.rfdist", row.names=NULL)
adj.rfdist

# :::::::::::::
# :::: A ::::::
# :::::::::::::


# ::: 1. find n
# way 1
n <- dim(read.table("fake-chr4-all.tre", sep=","))[2]

# way 2
n <- read.table("fake-chr4-all.tre.rfdist", nrows=1)[1,2]

# ::: 2. find D
# find distances between all pairs of trees.
D <- rfdist[lower.tri(rfdist)]

# ::: 3. find S
S <- n-3-D/2 

# ::: 4. make a graph
S <- data.frame(S)
ggplot(S, aes(x=S)) + geom_histogram(aes(y=..density..), binwidth=0.5, color="black", fill="white") +
    geom_density(alpha=.2, fill="#FF6666") + stat_function(fun=dpois, args=list(1/8)) 
# scale needs to be consistent. histogram's scale is not the density scale. need to check!

# :::::::::::::
# :::: B ::::::
# :::::::::::::

# ::: 2. find D
adj.D <- as.numeric(adj.rfdist[-length(adj.rfdist)]) # The last 0 is extra.

# ::: 3. find S
adj.S <- n-3-adj.D/2 

# ::: 4. make a graph
adj.S <- data.frame(adj.S)

ggplot(adj.S, aes(x=adj.S)) + geom_histogram(aes(y=..density..), binwidth = 0.1, color="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") + stat_function(fun=dpois, args=list(1/8)) 
# scale needs to be consistent. histogram's scale is not the density scale. need to check!
