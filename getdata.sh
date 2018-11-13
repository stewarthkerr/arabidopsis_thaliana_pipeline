# ::::::: team-12 final project ::::::::::

# NOTE: start from the main folder, (e.g., project-team-12)

#mkdir data # create "data" folder
cp SNP_data_list.txt data/SNP_data_list.txt # copy SNP_data_list.txt into "data" folder.

cd data # go to "data" folder

namelist=$(tail -n 216 SNP_data_list.txt | cut -d ' ' -f 1) # get strain names 

# get SNP data
for name in namelist
    do
        wget http://signal.salk.edu/atg1001/data/Salk/quality_variant_$name.txt
    done