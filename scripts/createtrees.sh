#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Takes 4 arguments (3 required, 4th optional)
# 1: Chromosome (1-5, C, or M)
# 2: Starting block
# 3: Number of blocks to produce
# 4: Optional flag: -c = all trees for given chromosome, -a = all trees for all chromosomes

#Check to make sure 3 arguments were supplied
#If time: check to make sure 2 and 3 are VALID integers
if [ "$#" -lt 3 ]; then
  echo "create_trees.sh: 3 arguments must be provided"; exit 1
elif [[ !("$1" =~ ^(1|2|3|4|5|C|M)$) ]]; then
  echo "create_trees.sh: argument 1 must be one of 12345, C or M"; exit 1
elif [[ !($2 =~ ^[0-9]+$) ]]; then
  echo "create_trees.sh: argument 2 must be an integer"; exit 1
elif [[ !($3 =~ ^[0-9]+$) ]]; then
  echo "create_trees.sh: argument 3 must be an integer"; exit 1
elif [[ !($2 -gt 0 && $3 -gt 0)]]; then
  echo "Arguments 2 and 3 must both be greater than zero"; exit 1
fi

#Handle argument 4#
#if  [ $4 == '-c']; then
#  for alignment_fname in alignments/chr$1*; do
    #iqtree -s $alignment_fname --no-outfiles -djc -m HKY+G -nt AUTO -pre ../iqtree
#elif [ $4 == '-a']; then
#  for alignment_fname in alignments/*; do
    #iqtree -s $alignment_fname --no-outfiles -djc -m HKY+G -nt AUTO -pre ../iqtree

#Calculate starting position - used to determine which file to use
((sp=($2-1)*10000+1))

#Calculate ending position -for file name
((ep=$3*10000))

echo ../alignments/chr${1}_${sp}_to_${ep}.phy

#Call iqtree for the specified alignments
#iqtree -s ../alignments/chr$1_(($2*10000))_to_(($3*10000)).phy --no-outfiles -djc -m HKY+G -nt AUTO -pre iqtree/chr$1
