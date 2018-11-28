
# :: step6 calculate distances between all pairs of trees
# a. between all pairs of trees from the same chromosome, for each chromosome
# b. between all pairs of trees from consecutive blocks 
# ::::: (which could be extracted from the larger set of distance values above)


# a. between all pairs of trees

for eachtree in iqtree/chrM/chrM*
    do cat $eachtree >> treedist/chrM-all.tre
    done


# check only with the first two trees from chrM
temp2=$(ls iqtree/chrM/chrM* | head -n 2)

for eachtree in $temp2
    do cat $eachtree >> treedist/chrM-firstwo.tre
    done


# measure distrances between all pairs of trees
iqtree -t treedist/chrM-all.tre -rf_adj -nt AUTO --no-outfiles -quiet
 # ERROR: Tree has different number of taxa!

iqtree -t treedist/chrM-firstwo.tre -rf_adj -nt AUTO --no-outfiles -quiet 
 # ERROR: Tree has different number of taxa!