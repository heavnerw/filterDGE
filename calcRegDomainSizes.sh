#!/bin/bash

inFile1=${1}
inFile2=${2}
fileStem1=`echo ${inFile1} | sed "s/.txt//"`

echo ${fileStem1}

cat ${inFile1} | awk '{print $1}' | sort | uniq -c | sort -nr | head -15
cat ${inFile1} | awk '{print $1}' | sort | uniq -c | sort -nr | awk '{ print $1 "\t" $2 }' > ${fileStem1}_withPeakNum.txt

#read in gene names with 0 peaks
cat ${inFile2} | sort -k1,1 | awk '{ print $1 "\t" 0 }' > tmp.txt
cat ${fileStem1}_withPeakNum.txt tmp.txt > ${fileStem1}_withPeakNums.txt

#Add mm9 GO reg domains to genes with cell type-specific peaks. Some genes have more than one reg domain, so we sort unique genes using the largest reg domain for each.
cat /cluster/u/heavner/results/mappingFiles/mm9_GORegDomainsSizes.bed | sort -k4,4 | join -t $'\t' -1 4 -2 2 - <(cat ${fileStem1}_withPeakNums.txt | sort -k2,2) | sort -nr -k5,5 | sort -u -k1,1 > ${fileStem1}_withRegDomainsU.txt 

#Create a .bed file of the mm9 GO reg domains of all the genes with cell type-specific peaks
awk -v OFS='\t' '{ print $2, $3, $4 }' ${fileStem1}_withRegDomainsU.txt > ${fileStem1}_RegDomainsU.bed

#Merge the bed file
sort -k1,1 -k2,2n ${fileStem1}_RegDomainsU.bed | mergeBed > ${fileStem1}_mergedRegDomains.bed

#Calculate and add up the sizes of the merged reg domains:
awk 'BEGIN { OFS = "\t" } { $4 = $3 - $2 }1' ${fileStem1}_mergedRegDomains.bed > ${fileStem1}_mergedRegDomainsSizes.bed
awk '{ sum += $4 } END { print sum }' ${fileStem1}_mergedRegDomainsSizes.bed #record this number for use in calculating the binomial p-value
echo ^size of merged reg domains

#Sum the total number of peaks and record the number for use in the binomial test
awk '{ sum += $6 } END { print sum }' ${fileStem1}_withRegDomainsU.txt #record this number for use in calculating the binomial p-value
echo ^total number of peaks
