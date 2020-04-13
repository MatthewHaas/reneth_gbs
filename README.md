# README file for reneth_gbs
All files related to Reneth's first GBS project. After setting up the directory with code in **gbs_directory_setup.txt**, the scripts were run in the following order:
1) **run_cutadapt.sh** to remove adapters from fastq files
2) **run_fastqc.sh** to do quality control on fastq files
3) **run_bwa.sh** to align fastq sequences to the genome
4) **index_bams.sh** to index BAM files which needs to be done prior to SNP calling
5) **scythe_mpileup.sh** to do the SNP calling portion
6) **make_snp_table.sh** & **normalize.awk** to create SNP table from VCF files
7) **filter_with_vcftools.sh** to filter VCF files based on desired parameters
8) **merge_vcf_files.sh** Merges filtered VCF files into one VCF file that will be used as input for PLINK
9) **run_plink.sh** Puts VCF SNP data into PLINK format & calculates eigenvalue/eigenvector files for PCA plot
10) **run_reneth_pca.sh** & **reneth_pca.R** to generate PCA plot (in R) using eigenvalues/eigenvectors from PLINK

## filter_with_vcftools.sh
Shell script uses VCFtools to filter VCF files (e.g., on % missing data, bi-allelic sites, depth).

## gbs_directory_setup.txt
This file contains the code used to setup the directory structure.

## index_bams.sh
Shell script uses samtools index to index BAM files (needs to be done prior to SNP calling).

## make_snp_table.sh
Shell script to pull SNP calls out of VCF files and put into a tab-separated (TSV) file. Requires normalize.awk

## merge_vcf_files.sh
Shell script that uses bcftools merge to combine the largest VCF files (filtered) into a single VCF file

## normalize.awk
AWK script required by **make_snp_table.sh** to pull SNP calls out of VCF files to make tab-separated (TSV) file.

## reneth_pca.R
R code that reads in PCA data (eigenvalues and eigenvectors) from PLINK and creates a PCA plot.

## run_bwa.sh
Shell script to run BWA-MEM to align fastq sequences to the _Zizania palustris_ genome.

## run_cutadapt.sh
Shell script to run the program cutadapt to remove adapters from GBS sequences. Uses the Nextera transposase sequence adapter.

## run_fastqc.sh
Shell script to run the program fastQC to check the quality of GBS sequences.

## run_plink.sh
Shell script to run PLINK to convert VCF SNP data into PLINK format and generate eigenvalue/eigenvector files to make PCA.

## run_reneth_pca.sh
Shell script that launches the R script **reneth_pca.R** to create a PCA plot of the GBS data from this project.

## scythe_mpileup.sh
Shell script to run the SNP calling portion of GBS pipeline. Uses samtools mpileup and bcftools call functions.
