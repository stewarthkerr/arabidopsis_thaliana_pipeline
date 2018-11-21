#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Takes 4 arguments (3 required, 4th optional)
# 1: Chromosome (1-5, C, or M)
# 2: Starting base position
# 3: Ending base position

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
elif [[ ($2 -gt $3) ]]; then
  echo "Starting base pair must be before ending base pair."; exit 1
fi

#Short check on genome length
#Maybe make ending position take last position of chromosome
maxbp=$(wc -c data/reference/TAIR10_chr$1.fas | cut -f1 -d' ')
if [[ ($2 -gt $maxbp) ]]; then
  echo "chr$1 does not have that many base pairs. Reduce starting position."; exit 1
elif [[ ($3 -gt $maxbp) ]]; then
  echo "chr$1 does not have that many base pairs. Reduce ending position"; exit 1
fi

#Pull base pairs from reference genome and stash in variable
((length = $3 - $2 + 1)) #Add 1 because genome includes starting bp
seq=$(tail -n +2 data/reference/TAIR10_chr$1.fas | tr -d '\040\011\012\015' | head -c $3 | tail -c $length )

#pad start and end position to 8 digits,
sp=$(printf %08d $2)
ep=$(printf %08d $3)
#Create the .phy file which will hold the genome -- pad to 8 digits
#Note that if the file already exists, then this will delete the old file
truncate -s 0 alignments/chr${1}_${sp}_to_${ep}.phy

((num_variant = 0))
#Create line for each variant by editing reference genome
for variant in data/quality_variants/quality_variant_*; do
  #strip directory and .txt from variant name
  vname=$(echo $variant | grep -Eo "[A-Z][^/.]+")

  #increment number of variants
  ((num_variant++))

  #Pull each of the changes that need to be done
  #changes variable: #BP to change:old BP:new BP
  changes=$(awk -v chr=$1 -v sp=$2 -v ep=$3 '{if (NR > 1 && $2 ~ chr && $3 > sp && $3 < ep)
    changes = changes $3 ":" $4 ":" $5 ","}
    END {print changes}' $variant)

  #Get total number of changes to be performed
  numchanges=$(echo $changes | grep -o ',' | wc -l)

  #Perform the change - loop through each change in $changes
  new_seq=$seq
  for i in `seq 1 $numchanges`; do
    change_i=$(echo $changes | cut -d ',' -f $i )
    position=$(echo $change_i | cut -d ':' -f 1 )
    let "position=position-1" #Need to decrement by 1 to to sed match before change
    old_bp=$(echo $change_i | cut -d ':' -f 2 )
    new_bp=$(echo $change_i | cut -d ':' -f 3 )

    #Would LIKE to add a check on old_bp to make sure we're replacing the right thing
    tempseq=$(echo $new_seq | sed -E "s/^(.{$position}).(.*)$/\1$new_bp\2/")
    new_seq=$tempseq
  done

  #Output to screen to show it's still working
  echo $vname, Number of changes: $numchanges
  #Output a line for this variant
  echo $vname' '$new_seq >> alignments/chr${1}_${sp}_to_${ep}.phy

done

#Add the first line to the file
sed -i "1 i $num_variant $length" alignments/chr${1}_${sp}_to_${ep}.phy
