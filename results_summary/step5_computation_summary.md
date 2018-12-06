# Step 4 and 5: Blocks and Trees

## Description
These scripts call buildgenome.sh from step 3 to create disjoint blocks of 10000 base pairs and trees (using IQ-TREE) for a specific chromosome and base pair range. Both trees and blocks can be created using the command:
`bash scripts/createtrees.sh X Y Z`
where X is the chromosome (1,2,3,4,5, C, or M)
Y is the starting tree (starting at 1)
and Z is the number of trees to create

*Note that createtrees.sh will only create NEW trees and will not overwrite existing trees*

Alternatively, only blocks can be created by using the command:
`bash scripts/makeblocks.sh X Y Z`
where X is the chromosome (1,2,3,4,5, C, or M)
Y is the starting block (starting at 1)
and Z is the number of blocks to create

## output
trees are located in the iqtree/chrX folder (X is the specified chromosome)
blocks are located in alignments/chrX folder (X is the specified chromosome)

## Computation time
### Chromosome M trees
Created on Stewart's laptop. Took approximately 2 hours

### Chromosome C trees
Created on Stewart's laptop. Took approximately 30 minutes.

### Chromosome 2 trees
Created on desk22.stat.wisc.edu. Took approximately 4 days.

## Notes
If they exist, these scripts will not overwrite existing blocks and trees. Existing blocks/trees will simply be passed over in the computation until a tree/block that doesn't exist is encountered.
