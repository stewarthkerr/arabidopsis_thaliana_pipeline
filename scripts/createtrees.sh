#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Takes 3 arguments
# 1: Chromosome (1-5, C, or M)
# 2: Starting block
# 3: Number of blocks to produce trees for

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

#If time, add argument 4:
#if  [ $4 == '-c']; then
#  for alignment_fname in alignments/chr$1*; do
    #iqtree -s $alignment_fname --no-outfiles -djc -m HKY+G -nt AUTO -pre ../iqtree
#elif [ $4 == '-a']; then
#  for alignment_fname in alignments/*; do
    #iqtree -s $alignment_fname --no-outfiles -djc -m HKY+G -nt AUTO -pre ../iqtree

#Construct the blocks using makeblocks.sh
#Fourth argument tells makeblocks to make the trees
bash scripts/makeblocks.sh $1 $2 $3

#Calculate starting position - used to determine which file to use
((ct_sp=(($2-1)*10000)+1))

#Calculate ending position -for file name
((ct_ep=($ct_sp-1)+($3*10000)))

#Calculate last bp position for this Chromosome
lastbp=$(tail -n +2 data/reference/TAIR10_chr$1.fas | tr -d '\040\011\012\015' | wc -c | cut -f1 -d' ')

#Make directory in iqtree folder for Chromosome
mkdir -p iqtree/chr$1

for index in `seq $ct_sp 10000 $ct_ep`; do

  #Check to make sure we have enough bp in chromosome
  if [[ ($index -gt $lastbp) ]]; then
    echo Last tree for this chromosome has been constructed; exit 1;
  fi

  #Print message to screen to show that it's working
  file_sp=$(printf %08d $index)
  ((end_index=index+9999))
  file_ep=$(printf %08d $end_index)
  echo Constructing tree chr${1}_${file_sp}_to_${file_ep}

  #Call iqtree for the specified alignment
  iqtree -s alignments/chr$1/chr$1_${file_sp}_to_${file_ep}.phy --no-outfiles -djc -m HKY+G -nt AUTO -pre iqtree/chr$1/chr$1_${file_sp}_to_${file_ep}

done
