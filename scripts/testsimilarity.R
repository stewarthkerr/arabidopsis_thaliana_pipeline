#----------------------------#
# Step 7 Test for similarity
#----------------------------#

# clear environment
rm(list=ls())

#### Processing data
# ::: Set the main directory in "treedist" for step 7
setwd("../treedist")

# Load data
chr2.all.tre <- read.table("allblocks/chr2-all.tre")
chrC.all.tre <- read.table("allblocks/chrC-all.tre")
chrM.all.tre <- read.table("allblocks/chrM-all.tre")

#chr2.all.rfdist
chr2.all.rfdist <- read.table("allblocks/chr2-all.tre.rfdist", skip=1, row.names = 1)

#chrC.all.rfdist
chrC.all.rfdist <- read.table("allblocks/chrC-all.tre.rfdist", skip=1, row.names = 1)

#chrM.all.rfdist
chrM.all.rfdist <- read.table("allblocks/chrM-all.tre.rfdist", skip=1, row.names = 1)

# 1) find D, distances between all pairs of trees.
chr2.all.D <- chr2.all.rfdist[lower.tri(chr2.all.rfdist)]
chrC.all.D <- chrC.all.rfdist[lower.tri(chrC.all.rfdist)]
chrM.all.D <- chrM.all.rfdist[lower.tri(chrM.all.rfdist)]


# Load data
chr2.cnsc.tre <- read.table("consecutiveblocks/chr2-cnsc.tre")
chrC.cnsc.tre <- read.table("consecutiveblocks/chrC-cnsc.tre")
chrM.cnsc.tre <- read.table("consecutiveblocks/chrM-cnsc.tre")

#chr2.cnsc.rfdist
chr2.cnsc.rfdist <- read.table("consecutiveblocks/chr2-cnsc.tre.rfdist", skip=1)

#chrC.cnsc.rfdist
chrC.cnsc.rfdist <- read.table("consecutiveblocks/chrC-cnsc.tre.rfdist", skip=1)

#chrM.cnsc.rfdist
chrM.cnsc.rfdist <- read.table("consecutiveblocks/chrM-cnsc.tre.rfdist", skip=1)

# 1) find D, distances between all pairs of trees.
chr2.cnsc.D <- as.numeric(chr2.cnsc.rfdist[-length(chr2.cnsc.rfdist)])
chrC.cnsc.D <- as.numeric(chrC.cnsc.rfdist[-length(chrC.cnsc.rfdist)])
chrM.cnsc.D <- as.numeric(chrM.cnsc.rfdist[-length(chrM.cnsc.rfdist)])

 
#### Making plot
par(mfrow=c(2,3))
# ::: a :::

# :: for chromosome 2
hist(chr2.all.D, main="Density of Chr. 2 with all blocks", xlab="Chromosome 2", prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chr2.all.D)/2), to=round(216-3-min(chr2.all.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), col="red")

# :: for chromosome C
hist(chrC.all.D, main="Density of Chr. C with all blocks", xlab="Chromosome C", prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chrC.all.D)/2), to=round(216-3-min(chrC.all.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), col="red")

# :: for chromosome M
hist(chrM.all.D, main="Density of Chr. M with all blocks", xlab="Chromosome M", prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chrM.all.D)/2), to=round(216-3-min(chrM.all.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), col="red")

# ::: b :::
# :: for chromosome 2
hist(chr2.cnsc.D, main="Density of Chr. 2 with consec. blocks", xlab="Chromosome 2", prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chr2.cnsc.D)/2), to=round(216-3-min(chr2.cnsc.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), col="red")

# :: for chromosome C
hist(chrC.cnsc.D, main="Density of Chr. C with consec. blocks", xlab="Chromosome C", prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chrC.cnsc.D)/2), to=round(216-3-min(chrC.cnsc.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), col="red")

# :: for chromosome M
hist(chrM.cnsc.D, main="Density of Chr. M with consec. blocks", xlab="Chromosome M", prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chrM.cnsc.D)/2), to=round(216-3-min(chrM.cnsc.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), col="red")

# Mean
mean.dist <- rbind(cbind(mean(chr2.all.D), mean(chr2.cnsc.D)),
                   cbind(mean(chrC.all.D), mean(chrC.cnsc.D)),
                   cbind(mean(chrM.all.D), mean(chrM.cnsc.D)))
colnames(mean.dist) <- c("all blocks", "consec. blocks")
rownames(mean.dist) <- c("chr. 2", "chr. C", "chr. M")
mean.dist



