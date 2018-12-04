* All scripts will works for both mac OS and Linux.  
* Please run all scripts under scripts folder.  

## Step 6: Calculate distances between all pairs of trees  
**Script name**: calculatedist.sh  
**Description**: run this script to get following distances for chrmosome 2, C, and M.  
a.distance between all pairs of trees from the same chromosome, for each chromosome.  
b. distance between all pairs of trees from consecutive blocks (which could be extracted from the larger set of distance values above).  

**Example**:  
Input argument: index for chromosome (2, C, M).
```
bash calculatedist.sh 2
```
Output rfdist files for a will be stored in folder "treedist/allblocks".   
Output rfdist files for b will be stored in folder "treedist/consecutiveblocks".  


## Step 7: Test for tree similarity  
**Script name**: testsimilarity.Rmd (testsimilarity.R).  
**Description**: run this script to see the answers following question.  
a. Are the observed tree distances closer to 0 than expected if the 2 trees were chosen at random uniformly?   
b. Do trees from 2 consecutive blocks tend to be more similar to each other (at smaller distance) than trees from 2 randomly chosen blocks from the same chromosome? 

**Example**:  
Open R / R studio or run following command if you have R/rstudio in your environment:
```
R calculatedist.R
rstudio calculatedist.Rmd
```

Output "step7_results.html" will be stored in folder "results_summary".



