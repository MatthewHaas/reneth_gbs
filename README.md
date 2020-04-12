# README file for reneth_gbs
All files related to Reneth's first GBS project. After setting up the directory with code in **gbs_directory_setup.txt**, the scripts were run in the following order:
1) **run_cutadapt.sh** to remove adapters from fastq files
2) **run_fastqc.sh** to do quality control on fastq files
3) **run_bwa.sh** to align fastq sequences to the genome
4) **index_bams.sh** to index BAM files which needs to be done prior to SNP calling
5) **scythe_mpileup.sh** to do the SNP calling portion

## gbs_directory_setup.txt
This file contains the code used to setup the directory structure.

## index_bams.sh
Shell script uses samtools index to index BAM files (needs to be done prior to SNP calling).

## run_bwa.sh
Shell script to run BWA-MEM to align fastq sequences to the _Zizania palustris_ genome.

## run_cutadapt.sh
Shell script to run the program cutadapt to remove adapters from GBS sequences. Uses the Nextera transposase sequence adapter.

## run_fastqc.sh
Shell script to run the program fastQC to check the quality of GBS sequences.

## scythe_mpileup.sh
Shell script to run the SNP calling portion of GBS pipeline. Uses samtools mpileup and bcftools call functions.
