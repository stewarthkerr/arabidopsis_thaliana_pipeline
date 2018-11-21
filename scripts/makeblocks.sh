#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Takes 5 arguments (3 required, 4th/5th optional)
# 1: Chromosome (1-5, C, or M)
# 2: Starting block
# 3: Number of blocks to produce
#4 : blocklength (Need to add still)
# 5: Optional flag: -b = all blocks for given chromosome, -a = all blocks for all chromosomes

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
((sp=(($2-1)*10000)+1))

#Calculate ending position -for file name
((ep=($sp-1)+($3*10000)))

### I THINK THERE'S AN ISSUE BECAUSE I'M USING SP AND EP IN BOTH THIS AND BUILDGENOME.SH
for index in `seq $sp 10000 $ep`; do
  file_sp=$(printf %08d $index)
  ((end_index=index+9999))
  file_ep=$(printf %08d $end_index)
  echo Calculating block chr${1}_${file_sp}_to_${file_ep}
  bash scripts/buildgenome.sh $1 $index $end_index
done
