#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=30g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e run_plink.err
#PBS -o run_plink.out
#PBS -N run_plink

module load plink

cd /home/jkimball/haasx092/reneth_gbs/200412_samtools

# The purpose of this code is to use plink for creation of a PCA plot for Reneth's GBS project

plink --vcf largest_scaffolds_filtered.vcf --double-id --maf 0.05 --allow-extra-chr --recode --out reneth_plink

# PCA calculation
plink --pca --file reneth_plink --allow-extra-chr -out reneth_plink_pca