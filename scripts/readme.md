* All scripts will work for both mac OS and Linux.  
* Please run all scripts under scripts folder.


## Step 1 and step 2: Download Single nucleotide polymorphism (SNP) and reference genome data  
**Script name**: getdata.sh.    
**Description**: run this script to download SNP data available for 216 strains from [Salk Arabidopsis 1,001 Genomes](http://signal.salk.edu/atg1001/download.php) and reference genome data from [here](ftp://ftp.arabidopsis.org/home/tair/Sequences/whole_chromosomes/). It may take a couple hours to download all SNP data.  

**Example**:  
```
bash getdata.sh
```
The downloaded data will be saved in a new folder named "data".  
The SNP data will be saved in the folder "data/quality_variants".  
The reference genome data will be saved in the folder "data/reference".  



## Step 3: Build individual genomes
**Script name**: buildgenome.sh.  
**Description**: run this script to get an alignment of the DNA sequences of all strains for a chromosome of interest and for a genomic range of interest.  
**Example**:  
Input argument:  
(1) index for chromosome (e.g. 1-5, C or M)  
(2) starting base position (e.g. 1,2,...20000,... 0 is not included)  
(3) ending base position (e.g. 1000)  
For example, the following command
```
bash buildgenome.sh 1 997 1006
```
will produce
```
216 10
Aa_0 ATTTGGTTAT
Abd_0 AATTGGTTAT
...
...
```
Output phylip files will be saved in the folder "alignments/'subfolder'" (the subfolder e.g. "chr1" for each chromosome will be created automatically).



### Step 4: Create non-overlapping alignments blocks  
**Script name**: makeblocks.sh  
**Description**: run this script to cut a chromosome into non-overlapping alignments or blocks of length 10,000 base pairs (except for the last one). This script checks to see if the block has already been created, and if it has, will not recreate the block.

**Example**:  
Input argument:  
(1) index for chromosome (e.g. 1-5, C or M)  
(2) starting block index (e.g. 1,2,...1858,... 0 is not included)  
(3) number of blocks (e.g. 1,2,...)  
For example, the following command
```
bash makeblocks.sh 1 1 20
```
will produce 1st to 20th block files for chromosome 1.  
Output block files will be saved in folder "alignments/subfolder" (the subfolder e.g. "chr2" for each chromosome will be created automatically).



## Step5: Get a tree for each block  
**Script name**: createtrees.sh  
**Description**: run this script to analyze each block and estimate a tree that describes the genealogy of the plants, based on their DNA.  In order to run this script successfully, you have to install IQ-TREE first and add it to environment path. This script checks to see if blocks have been created and, if not, will also create blocks.

**Example**:  
Input argument:  
(1) index for chromosome (e.g. 1-5, C or M)  
(2) starting block index (e.g. 1,2,...1858,... 0 is not included)  
(3) number of blocks (e.g. 1,2,...)  
For example, the following command
```
bash createtrees.sh 1 1 20
```
will produce 1st to 20th block files for chromosome 1 and create the tree for each block.   
Output block files will be saved in folder "alignments/subfolder" (the subfolder e.g. "chr2" for each chromosome will be created automatically).
Output tree file will be saved in the folder "iqtree/subfolder" (the subfolders e.g. "chr2" are created automatically).  




## Step 6: Calculate distances between all pairs of trees  
**Script name**: calculatedist.sh.  
**Description**: run this script to get following distances for chromosome 2, C, and M.  
a. distance between all pairs of trees from the same chromosome, for each chromosome.  
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

Open R or run following command if you have R/Rstudio in your environment:
```
Rscript testsimilarity.R
```
Output plots will be saved in folder "results_summary".
