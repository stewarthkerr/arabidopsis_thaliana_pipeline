#!/bin/bash
#Use dirname to set the wd to where the script is located, and then go up a level
cd "$(dirname "$0")"/..

#Creates data directory, -p means it won't throw an error if /data already exists
mkdir -p data

#Step 2: Download reference genome
#-P lets us specify download directory, -N says don't download if file already downloaded
wget -N --timestamping -P data/ ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/*.fas

#Pull list of variants from 1001 genomes, save to data/quality_variant_list.txt
wget -O - http://signal.salk.edu/atg1001/download.php |
  grep -oE "id=[^>]*" | cut -d = -f 2 > data/quality_variant_list.txt

#Pulls SNP data from 1001 genome
while read vname
  do
    wget -O data/quality_variant_$vname.txt http://signal.salk.edu/atg1001/data/Salk/quality_variant_$vname.txt
  done < data/quality_variant_list.txt

#MAYBE: Add a check to make sure all files were downloaded
#Do the check before downloading and after downloading. If files already exist
#then we don't need to redownload
