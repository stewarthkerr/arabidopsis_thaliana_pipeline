* All scripts will works for both mac OS and Linux.  
* Please run all scripts under scripts folder.  


## Step 1 and step 2: Download Single nucleotide polymorphism (SNP) and reference genome data  
**Script name**: getdata.sh.    
**Description**: run this script to download SNP data available for 216 strains from [Salk Arabidopsis 1,001 Genomes](http://signal.salk.edu/atg1001/download.php) and reference genome data from [here](ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/). It may take a couple hours to download all SNP data.  

**Example**:  
```
bash getdata.sh
```
The dowanloaded data will be saved in a new folder "data".  
The SNP data will be saved in folder "data/quality_variants".  
The reference genome data will be in folder "data/reference".  

## Step 3: Build individual genomes
**Script name**: buildgenome.sh.  
**Description**:   

**Example**:  
Input argument:  
(1) index for chromosome (e.g. 1-5, C or M)  
(2) starting base postion (e.g. 1,2,...20000,... 0 is not included))  
(3) ending base position (e.g. 1000)  
```
bash buildgenome.sh 1 20 2000
```
Outputfiles will be saved in folder "alignments".  

### Step 4: Create non-overlapping alignments blocks  
**Script name**: makeblocks.sh  
**Description**: run this script to cut a chromosome into non-overlapping alignments -or blocks- of length 10,000 base pairs (except for the last one). 

**Example**:  
Input argument:  
(1) index for chromosome (e.g. 1-5, C or M)  
(2) starting block index (e.g. 1,2,...1858,... 0 is not included)  
(3) number of blocks (e.g. 1,2,...)  
```
bash buildgenome.sh 1 1 20
```
Output block files will be saved in 

## Step5: Get a tree for each block
**Script name**: createtrees.sh
**Description**: run this script to


## Step 6: Calculate distances between all pairs of trees  
**Script name**: calculatedist.sh.  
**Description**: run this script to get following distances for chrmosome 2, C, and M.  
a.distance between all pairs of trees from the same chromosome, for each chromosome.  
b. distance between all pairs of trees from consecutive blocks (which could be extracted from the larger set of distance values above).  

**Example**:  
Input argument: index for chromosome (e.g. 2, C, M).
```
bash calculatedist.sh 2
```
Output rfdist files for a will be saved in folder "treedist/allblocks".   
Output rfdist files for b will be saved in folder "treedist/consecutiveblocks".  


## Step 7: Test for tree similarity  
**Script name**: testsimilarity.Rmd (testsimilarity.R).  
**Description**: run this script to see the answers following question.  
a. Are the observed tree distances closer to 0 than expected if the 2 trees were chosen at random uniformly?   
b. Do trees from 2 consecutive blocks tend to be more similar to each other (at smaller distance) than trees from 2 randomly chosen blocks from the same chromosome? 

**Example**:  
Open R studio run testsimilarity.Rmd(R markdown file).  
Output "step7_results.html" will be saved in folder "results_summary".  

Open R or run following command if you have R/rstudio in your environment:
```
Rscript testsimilarity.R
```
Output plots will be saved in folder "results_summary".




