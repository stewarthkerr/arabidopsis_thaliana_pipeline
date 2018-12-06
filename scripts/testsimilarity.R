#----------------------------#
# Step 7 Test for similarity
#----------------------------#

# clear environment
rm(list=ls())

#### Processing data
# ::: Set the main directory in "treedist" for step 7
setwd("../treedist")

# Load data about distance results between all pairs of trees from chr. 2, C, and M, respectively. 
chr2.all.rfdist <- read.table("allblocks/chr2-all.tre.rfdist", skip=1, row.names = 1)
chrC.all.rfdist <- read.table("allblocks/chrC-all.tre.rfdist", skip=1, row.names = 1)
chrM.all.rfdist <- read.table("allblocks/chrM-all.tre.rfdist", skip=1, row.names = 1)

# Load data about distance results between all pairs of trees from chr. 2, C, and M, respectively.
chr2.cnsc.rfdist <- read.table("consecutiveblocks/chr2-cnsc.tre.rfdist", skip=1)
chrC.cnsc.rfdist <- read.table("consecutiveblocks/chrC-cnsc.tre.rfdist", skip=1)
chrM.cnsc.rfdist <- read.table("consecutiveblocks/chrM-cnsc.tre.rfdist", skip=1)

# Find D, distances between all pairs of trees for each chromosome.
chr2.all.D <- chr2.all.rfdist[lower.tri(chr2.all.rfdist)]
chrC.all.D <- chrC.all.rfdist[lower.tri(chrC.all.rfdist)]
chrM.all.D <- chrM.all.rfdist[lower.tri(chrM.all.rfdist)]

# Find D, distances between all pairs of trees from consecutive blocks for each chromosome.
chr2.cnsc.D <- as.numeric(chr2.cnsc.rfdist[-length(chr2.cnsc.rfdist)])
chrC.cnsc.D <- as.numeric(chrC.cnsc.rfdist[-length(chrC.cnsc.rfdist)])
chrM.cnsc.D <- as.numeric(chrM.cnsc.rfdist[-length(chrM.cnsc.rfdist)])


#### Making plot
png("../results_summary/step7_distributions.png",height = 2000, width = 2200)

# Change density scales for chromosome D.
h1 <- hist(chrM.all.D, prob=T)
h1$counts <- h1$counts/sum(h1$counts)

h2 <- hist(chrM.cnsc.D, prob=T)
h2$counts <- h2$counts/sum(h2$counts)

par(mfrow=c(2,3))

# ::: a :::
# for chromosome 2
hist(chr2.all.D, main="Distance density for Chr. 2 with all blocks", xlab="Chromosome 2", col=rgb(1,0,0,0.2), prob=TRUE, breaks=30)
S = seq(from=round(217-3-max(chr2.all.D)/2), to=round(217-3-min(chr2.all.D)/2), by=1)
lines(x=I(2*(217-3-S)), y=dpois(S, lambda=1/8), lwd=2)
abline(v=mean(chr2.all.D), col="red", lty=3, lwd=2)
text(mean(chr2.all.D)-30,0.04, paste0("mean= ", round(mean(chr2.all.D),3)))
legend("topleft", c("Expected Distance", "Mean"), col=c("black", "red"), lty=c(1, 3), lwd=c(2 ,2))


# for chromosome C
hist(chrC.all.D, main="Distance density for Chr. C with all blocks", xlab="Chromosome C", col=rgb(1,0,0,0.2), prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chrC.all.D)/2), to=round(216-3-min(chrC.all.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), lwd=2)
abline(v=mean(chrC.all.D), col="red", lty=3, lwd=2)
text(mean(chrC.all.D)-10,0.1, paste0("mean= ", round(mean(chrC.all.D),3)))
legend("topleft", c("Expected Distance", "Mean"), col=c("black", "red"), lty=c(1, 3), lwd=c(2 ,2))


# for chromosome M
plot(h1, main="Distance density for Chr. M with all blocks", xlab="Chromosome M", col=rgb(1,0,0,0.2), breaks=10, ylab="Density")
S = seq(from=round(216-3-max(chrM.all.D)/2), to=round(217-3-min(chrM.all.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), lwd=2)
abline(v=mean(chrM.all.D), col="red", lty=3, lwd=2)
text(mean(chrM.all.D)-1.2,0.6, paste0("mean= ", round(mean(chrM.all.D),3)))
legend("topleft", c("Expected Distance", "Mean"), col=c("black", "red"), lty=c(1, 3), lwd=c(2 ,2))


# ::: b :::
# for chromosome 2
hist(chr2.cnsc.D, main="Distance density for Chr. 2 with consec. blocks", xlab="Chromosome 2", col=rgb(1,0,0,0.2), prob=TRUE, breaks=30)
S = seq(from=round(217-3-max(chr2.cnsc.D)/2), to=round(217-3-min(chr2.cnsc.D)/2), by=1)
lines(x=I(2*(217-3-S)), y=dpois(S, lambda=1/8), lwd=2)
abline(v=mean(chr2.cnsc.D), col="red", lty=3, lwd=2)
text(mean(chr2.cnsc.D)-30,0.015, paste0("mean= ", round(mean(chr2.cnsc.D),3)))
legend("topleft", c("Expected Distance", "Mean"), col=c("black", "red"), lty=c(1, 3), lwd=c(2 ,2))

# for chromosome C
hist(chrC.cnsc.D, main="Distance density for Chr. C with consec. blocks", xlab="Chromosome C", col=rgb(1,0,0,0.2), prob=TRUE, breaks=30)
S = seq(from=round(216-3-max(chrC.cnsc.D)/2), to=round(216-3-min(chrC.cnsc.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), lwd=2)
abline(v=mean(chrC.cnsc.D), col="red", lty=3, lwd=2)
text(mean(chrC.cnsc.D)+9.2,0.08, paste0("mean= ", round(mean(chrC.cnsc.D),3)))
legend("topleft", c("Expected Distance", "Mean"), col=c("black", "red"), lty=c(1, 3), lwd=c(2 ,2))

# for chromosome M
plot(h2, main="Distance density for Chr. M with consec. blocks", xlab="Chromosome M", col=rgb(1,0,0,0.2), breaks=10, ylab="Density")
S = seq(from=round(216-3-max(chrM.cnsc.D)/2), to=round(216-3-min(chrM.cnsc.D)/2), by=1)
lines(x=I(2*(216-3-S)), y=dpois(S, lambda=1/8), lwd=2)
abline(v=mean(chrM.cnsc.D), col="red", lty=3, lwd=2)
text(mean(chrM.cnsc.D)-1.2, 0.6, paste0("mean= ", round(mean(chrM.cnsc.D),3)))
legend("topleft", c("Expected Distance", "Mean"), col=c("black", "red"), lty=c(1, 3), lwd=c(2 ,2))

dev.off()


