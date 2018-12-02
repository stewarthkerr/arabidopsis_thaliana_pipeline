#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

# :: step6 calculate distances between all pairs of trees
# a. between all pairs of trees from the same chromosome, for each chromosome
# b. between all pairs of trees from consecutive blocks
# ::::: (which could be extracted from the larger set of distance values above)

if [ "$#" -lt 1 ]; then
  echo "calculatedist.sh: an argument for chromosome must be provided"; exit 1
elif [[ !("$1" =~ ^(1|2|3|4|5|C|M)$) ]]; then
  echo "argument 1 must be one of 12345, C or M"; exit 1
fi

#Overwrite old all-tree file
truncate -s 0 treedist/chr$1-all.tre

# Create file for iqtree by concatenating all trees
for eachtree in iqtree/chr$1/*.treefile
    do cat $eachtree >> treedist/chr$1-all.tre
done

# measure distances between all pairs of trees
iqtree -t treedist/chr$1-all.tre -rf_all -nt AUTO --no-outfiles -pre treedist/allblocks/all_chr$1

# measure distance between adjacent trees
iqtree -t treedist/chr$1-all.tre -rf_adj -nt AUTO --no-outfiles -pre treedist/consecutiveblocks/consecutive_chr$1
