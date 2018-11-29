#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Takes 4 arguments (3 required)
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
maxbp=$(tail -n +2 data/reference/TAIR10_chr$1.fas | tr -d '\040\011\012\015' | wc -c | cut -f1 -d' ')
if [[ ($2 -gt $maxbp) ]]; then
  echo "chr$1 does not have that many base pairs. Reduce starting position."; exit 1
elif [[ ($3 -gt $maxbp) ]]; then
  echo "chr$1 does not have that many base pairs. Setting end position to last base pair."
  ep=$maxbp
elif [[ ($3 -le $maxbp) ]]; then
  ep=$3
fi

#Pull base pairs from reference genome and stash in variable
((length = $ep - $2 + 1)) #Add 1 because genome includes starting bp
seq=$(tail -n +2 data/reference/TAIR10_chr$1.fas | tr -d '\040\011\012\015' | head -c $3 | tail -c $length )
for i in `seq 1 $length`;do
  ((x=i-1))
  seq_array[i]=${seq:x:1}
done

#pad start and end position to 8 digits,
pad_sp=$(printf %08d $2)
pad_ep=$(printf %08d $ep)
#Create the .phy file which will hold the genome -- pad to 8 digits
#Note that if the file already exists, then this will delete the old file
mkdir -p alignments/chr${1}
truncate -s 0 alignments/chr${1}/chr${1}_${pad_sp}_to_${pad_ep}.phy

((num_variant = 0))
#Create line for each variant by editing reference genome
for variant in data/quality_variants/quality_variant_*; do
  #strip directory and .txt from variant name
  vname=$(echo $variant | grep -Eo "[A-Z][^/.]+")

  #increment number of variants
  ((num_variant++))

  #Pull each of the changes that need to be done
  #changes variable: #BP to change:old BP:new BP
  changes=$(awk -v chr=$1 -v sp=$2 -v ep=$ep '{if (NR > 1 && $2 ~ chr && $3 > sp && $3 < ep)
    changes = changes $3 ":" $4 ":" $5 ","}
    END {print changes}' $variant)

  #Get total number of changes to be performed
  numchanges=$(echo $changes | grep -o ',' | wc -l)

  #Output to screen to show it's still working
  echo $vname, Number of changes: $numchanges

  #Perform the change - loop through each change in $changes
  temp_seq=("${seq_array[@]}")
  for i in `seq 1 $numchanges`; do
    change_i=$(echo $changes | cut -d ',' -f $i )
    position=$(echo $change_i | cut -d ':' -f 1 )
    #old_bp=$(echo $change_i | cut -d ':' -f 2 )
    new_bp=$(echo $change_i | cut -d ':' -f 3 )

    temp_seq[$position]=$new_bp
  done

  new_seq=$(echo ${temp_seq[*]} | tr -d '\040\011\012\015')

  #Write a line to file for this variant
  echo $vname' '$new_seq >> alignments/chr${1}/chr${1}_${pad_sp}_to_${pad_ep}.phy

done

#Add the first line to the file
sed -i "1 i $num_variant $length" alignments/chr${1}/chr${1}_${pad_sp}_to_${pad_ep}.phy
