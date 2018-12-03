#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

# :: step6 calculate distances between all pairs of trees
# a. between all pairs of trees from the same chromosome, for each chromosome
# b. between all pairs of trees from consecutive blocks

# create folders to save results of iqtree (for a. and b. respectively).
mkdir -p treedist/allblocks  
mkdir -p treedist/consecutiveblocks

# Take 1 argument
# 1: the 3 samllest chromosomes only (2, C, or M)

# check to make sure 1 arguments was supplied
if [ "$#" -lt 1 ]; then
  echo "calculatedist.sh: 1 arguments must be provided"; exit 1
elif [[ !("$1" =~ ^(2|C|M)$) ]]; then
  echo "calculatedist.sh: argument 1 must be one of 2, C or M"; exit 1
fi


# create fils with all trees for a and b, respectively. The output is the same but with different names.
for eachtree in iqtree/chr${1}/chr${1}*
    do 
       cat $eachtree >> treedist/allblocks/chr${1}-all.tre
       cat $eachtree >> treedist/consecutiveblocks/chr${1}-cnsc.tre
    done


# calculate distances between all pairs of trees, for a.
iqtree -t treedist/allblocks/chr${1}-all.tre -rf_all -nt AUTO

# calculate distances between trees from consecutive blocks, for b.
iqtree -t treedist/consecutiveblocks/chr${1}-cnsc.tre -rf_adj -nt AUTO --no-outfiles -quiet