#!/bin/bash -l
#PBS -l nodes=1:ppn=24,mem=20g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e filter_with_vcftools.err
#PBS -o filter_with_vcftools.out
#PBS -N filter_with_vcftools

# Include path to the working directory
cd /home/jkimball/haasx092/reneth_gbs/200412_samtools

# Filter VCF files for missing data (75%), biallelic sites only, no indels, and a depth of 6
for i in $(cat original_vcf_file_list.txt)
do
STEM=$(echo ${i} | cut -f 1 -d ".")
~/vcftools/bin/vcftools --gzvcf  $i --max-missing 0.75 --min-alleles 2 --max-alleles 2 --remove-indels --minDP 6 --recode --recode-INFO-all --out ${STEM}_filtered
done