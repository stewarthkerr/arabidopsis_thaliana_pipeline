# Step 3: build individual Genomes

## Description
This script takes the reference genome and quality_variant data for each variant and reconstructs a specified portion of the genome of a specified chromosome for each variant. The script is run using the following command:

`bash scripts/buildgenome.sh C 998 1010`
Where the first argument is the chromosome of interest (1,2,3,4,5, C, or M), the second argument is the starting base pair position, and the last argument is the ending base pair position.

## Output
This script creates .phy files in the alignments/chrX directory where X is the specified chromosome.

## Notes
This script is not optimized and may take quite some time to run for large blocks of base pairs and many variants. Also, the script does not currently check to make sure the reference genome base pair matches the expected base pair from the quality_variant file. **Visual inspection of a number of base pairs suggest that there is likely a discrepancy between some of the quality_variant expected base pairs and the reference genome base pairs."
