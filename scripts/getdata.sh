#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Creates data directory, -p means it won't throw an error if /data already exists
mkdir -p data

#Pull list of variants from 1001 genome, save to data/quality_variant_list.txt
wget -O - http://signal.salk.edu/atg1001/download.php |
  grep -oE "id=[^>]*" | cut -d = -f 2 > data/quality_variant_list.txt

#Pulls SNP data from 1001 genome
while read vname
  do
    wget -O data/quality_variant_$vname.txt http://signal.salk.edu/atg1001/data/Salk/quality_variant_$vname.txt
  done < data/quality_variant_list.txt
