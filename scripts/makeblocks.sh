#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Takes 3 arguments
# 1: Chromosome (1-5, C, or M)
# 2: Starting block
# 3: Number of blocks to produce

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

#Calculate starting position - used to determine which file to use
((mb_sp=(($2-1)*10000)+1))

#Calculate ending position -for file name
((mb_ep=($mb_sp-1)+($3*10000)))

#Calculate last bp position for this Chromosome
lastbp=$(tail -n +2 data/reference/TAIR10_chr$1.fas | tr -d '\040\011\012\015' | wc -c | cut -f1 -d' ')

for index in `seq $mb_sp 10000 $mb_ep`; do

  #Check to make sure we have enough bp in chromosome
  if [[ ($index -gt $lastbp) ]]; then
    echo Last block for this chromosome has been constructed; exit 1;
  fi

  #Print message to screen to show that it's working
  file_sp=$(printf %08d $index)
  ((end_index=index+9999))
  file_ep=$(printf %08d $end_index)
  echo Constructing block chr${1}_${file_sp}_to_${file_ep}

  #Run buildgenome.sh to create the block
  bash scripts/buildgenome.sh $1 $index $end_index

done
