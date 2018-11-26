import os
import copy
import re
import pandas as pd
import numpy as np
import csv
import argparse


# get current(script) working directory
script_path = os.getcwd()


# get project folder directory
project_path = os.path.dirname(script_path)


# get strain folder directory
strain_path = os.path.join(project_path,"data/quality_variants")


# get reference chromosom folder directory
ref_path = os.path.join(project_path,"data/reference")


# get a list of chromosome files' name
chr_files = [file for file in os.listdir(ref_path)]


chrfiles_dict = {}
for name in chr_files:
    chrfiles_dict[name[10]] = name


# get a list of strain files' name
strain_files = [file for file in os.listdir(strain_path)]



# use an Argument Parser object to handle script arguments
parser = argparse.ArgumentParser()
parser.add_argument("-chr_index", type=str, help="chromosom 1-5, C or M")
parser.add_argument("-start", type=int, help="starting base position")
parser.add_argument("-end", type=int, help="ending base position")
args = parser.parse_args()

def mutant_alignment(chr_index, start, end):
    """Input
    start: the index of start base position in a chrmosome(starting at 1)
    end: the index of end base position in a chromosome
    chr_index: the index of specific chrmosome(in 1-5, C or M)
    
    Examples:
    mutant_alignment("1", 1, 10)
    """

    
    # convert int to string
    if type(chr_index) == int:
        chr_index = str(chr_index)
    
    assert start > 0 and type(start) == int,"error message: start index must be a positive integer!"
    assert end > 0 and type(start) == int,"error message: end index must be a positive integer \
                                                larger than start index and within chromosome length!"

    # Use start and end position to find which lines should be read in
    # Since each file will have 80 bases on each line, so we get the quotient of start/80 as start line index
    # and use the quotient of end/80 as the end line index
    line_start = int(start/80)
    line_end = int(end/80) + 1
    
    start_new = start - line_start*80
    end_new = end - line_start*80
    
    print(line_start, line_end, start_new, end_new)
    # Get the path for each chromosome file
    chrfile_name = chrfiles_dict[chr_index]
    chrfile = os.path.join(ref_path,chrfile_name)
    print(chrfile)
    
    chr_seq = ""
    with open(chrfile) as chromosome:
        next(chromosome) # Skip the first line since it does not contain bases
        lines = [line.strip('\n') for line in chromosome][line_start:line_end]
        
    chr_seq = "".join(lines)
    print(chr_seq)
    
    # start-1 and end-1 to get right index in python, since python starts from 0
    # narrow to the sequence we need
    chr_seq = chr_seq[start_new-1:end_new]
    # change string to list for future modification
    chr_seq_list = list(chr_seq)
    print(chr_seq_list)
        
    output = []
    chromosome = 'chr' + chr_index
    print(chromosome)
    
    # read in strain files and extract useful information
    for strainfile_name in strain_files:
        strainfile = os.path.join(strain_path, strainfile_name)
        strain =  pd.read_csv(strainfile, header = None, names = ["strain", "chr", "pos", "ref_base", "sub_base", "qua", "non", "con", "avg"], sep = '\t')
        
        # limit data within specific range (specified chrmosome and position between start and end)
        strain = strain[(strain.chr == chromosome) & (strain.pos >= start) & (strain.pos <= end)]
        
        # get strain name
        strain_name = re.split('quality_variant_|.txt', strainfile_name)[1]
        
        #begin substitution
        if strain.empty == False:
            chr_seq_list_mutant = copy.deepcopy(chr_seq_list)
            for i in range(len(strain)):
                position = strain.iloc[i,2] - 1 - line_start*80 - start_new
                chr_seq_list_mutant[position] = strain.iloc[i,4]
            output.append([strain_name, "".join(chr_seq_list_mutant)])
        else:
            output.append([strain_name, "".join(chr_seq_list)])
            
    total_bases = end - start + 1
    total_strains = len(strain_files)
    output.insert(0, [total_strains, total_bases])
    
    if len(str(start)) == 1:
        start_string = "00000" + str(start)
    elif len(str(start)) == 2:
        start_string = "0000" + str(start)
    elif len(str(start)) == 3:
        start_string = "000" + str(start)
    elif len(str(start)) == 4:
        start_string = "00" + str(start)
    elif len(str(start)) == 5:
        start_string = "0" + str(start)
    elif len(str(start)) == 6:
        start_string = str(start)
        
    if len(str(end)) == 1:
        end_string = "00000" + str(end)
    elif len(str(end)) == 2:
        end_string = "0000" + str(end)
    elif len(str(end)) == 3:
        end_string = "000" + str(end)
    elif len(str(end)) == 4:
        end_string = "00" + str(end)
    elif len(str(end)) == 5:
        end_string = "0" + str(end)
    elif len(str(end)) == 6:
        end_string = str(end)
    
    output_file = chromosome + "_" + start_string + "_to_" + end_string + ".phy"
    
    with open(output_file, 'w', newline='') as f:
        csv_writer = csv.writer(f,delimiter =' ')
        csv_writer.writerows(output)
    
    return output

if __name__ == '__main__':
     print(mutant_alignment(args.chr_index,args.start, args.end))