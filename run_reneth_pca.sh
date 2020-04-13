#!/bin/bash -l
#PBS -l nodes=1:ppn=24,mem=15g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e run_reneth_pca.err
#PBS -o run_reneth_pca.out
#PBS -N run_reneth_pca

cd /home/jkimball/haasx092/reneth_gbs/200412_samtools

module load R/3.6.0

Rscript reneth_pca.R
