#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

# :: step6 calculate distances between all pairs of trees
# a. between all pairs of trees from the same chromosome, for each chromosome
# b. between all pairs of trees from consecutive blocks
# ::::: (which could be extracted from the larger set of distance values above)

mkdir -p treedist/allblocks
mkdir -p treedist/consecutiveblocks


# create all pairs of trees for a and b.

for eachtree in iqtree/chrM/chrM*
    do cat $eachtree >> treedist/allblocks/chrM-all.tre
    done

for eachtree in iqtree/chrC/chrC*
    do cat $eachtree >> treedist/allblocks/chrC-all.tre
    done

for eachtree in iqtree/chrM/chrM*
    do cat $eachtree >> treedist/consecutiveblocks/chrM-all.tre
    done

for eachtree in iqtree/chrC/chrC*
    do cat $eachtree >> treedist/consecutiveblocks/chrC-all.tre
    done


# calculate distances between all pairs of trees
# for a
iqtree -t treedist/allblocks/chrM-all.tre -rf_all -nt AUTO
iqtree -t treedist/allblocks/chrC-all.tre -rf_all -nt AUTO

# for b
iqtree -t treedist/consecutiveblocks/chrM-all.tre -rf_adj -nt AUTO --no-outfiles -quiet
iqtree -t treedist/consecutiveblocks/chrC-all.tre -rf_adj -nt AUTO --no-outfiles -quiet