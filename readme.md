### STAT 679 Final project
### Project team: 12
### Contributors: Stewart Kerr, Youmi Suk, Ruocheng Dong

## Introduction
A data pipeline for performing short analyses to evaluate the variability of the genealogical pattern across the genome of 200+ variants of the *Arabidopsis thaliana* plant was built and used. The overview for this project can be accessed via [the project overview](projectoverview.md). A more detailed outline of each step can be accessed via [stepsinstructions.md](stepsinstructions.md)

## Scripts
The script for each step can be accessed in the script directory. The instruction for running those scripts are in [readme.md under that directory](scripts/readme.md).

## Files
Tree files created from step 5 are in iqtree directory.  
Tree distance files created from step 6 are in treedist directory.  

## Results
Result summaries for each step can be accessed from summary files in the results_summary directory. After downloading data and constructing trees, the R Markdown file scripts/testsimilarity.Rmd can be run to create a summary report of our results.

We think that the observed tree distances are closer to 0 than expected if two trees were chosen randomly. This is because when we compare the density of the observed tree distances with that of the expected distances (see the top three plots of Rmd report), the observed tree distances have a higher density in relatively smaller values of distance measures. This implies the observed tree distances are smaller than the expected distances on average.

We think that trees from two consecutive blocks tend to be more similar to each other. This is because when we compare the top three plots with the bottom three plots, the observed tree distances from two consecutive blocks are smaller than those from all blocks on average. In addition, the mean observed distances with consecutive blocks are smaller than those with all blocks. The greatest mean difference is found with chr. 2, while the mean difference is very small with chr. M. However, we found clear differences in density, even for chr. M.
