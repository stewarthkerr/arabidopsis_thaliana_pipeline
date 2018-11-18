#!/usr/bin/env python

import itertools # package to remove the first line

def split_ch(chromodata, startingindex, numberblocks):
    """Create non-overlapping alignments blocks."""
    new_data = '' # create an empty string object.
    with open (chromodata) as f: # open the chromosome dataset as filename "f".
        for line in itertools.islice(f, 1, None): # skip the first line.
            new_data += line.rstrip('\n') # append lines after removing a trailing new line.
        return new_data[10000*startingindex:(10000*startingindex+10000*numberblocks)] # get the blocks determined by the starting block index and the number of blocks.


# ::: examples : if you want to play with
# please get rid of the below codes when we submit the final projects.
split_ch('TAIR10_chr1.fas', 0, 1)
split_ch('TAIR10_chr2.fas', 0, 2)
split_ch('TAIR10_chr2.fas', 1, 2)

split_ch('data/TAIR10_chr1.fas', 0, 1) # if you run this code in the main directory (project-team-12), it also works properly.


# ::: to understand how codes work with the small dataset (here, the unit of block = 10, not 10000):::
dat = 'CCCTAAACCCTAAACCCTAAACCCTAAACCTCTGAATCCTTAATCCCTAAATCCCTAAATCTTTAAATCCTACATCCAT'
dat[0:10] # starting index =0, #blocks=1  
dat[10:30]  # starting index =1, #blocks=2
dat[10:20]  # starting index =1, #blocks=1