### Step 1: SNP data summary

* Unexpected link s or problems  
(1) The link of quality_variant_Utrecht.txt does not exist(404: Not) Found).  
(2) The file name of downloaded file of strain named "Li_2:1" was automatically changed due to the ":". And we renamed it to "quality_variant_Li_2_1.txt".

* Number of files and size range  
Numer: 216.
Size range: the min size is 7624 and the max size is 33916.


* Code  
You can run this command under this folder to get the number of files:  
```ls ../data/quality_variants/ | wc -l```  
You can run this command under this folder to get the max size of files:  
```ls -s ../data/quality_variants/ |awk 'NR>1{print $1 }'|sort -n |head -n 1```  
You can run this command under this folder to get the min size of files:  
```ls -s ../data/quality_variants/ |awk 'NR>1{print $1 }'|sort -n |tail -n 1```
