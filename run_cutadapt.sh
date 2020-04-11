#!/bin/bash -1
#PBS -l nodes=1:ppn=8,mem=30g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -o run_cutadapt.out
#PBS -e run_cutadapt.err
cd ~/reneth_gbs
module load cutadapt
for i in $(cat 200410_sample_list.txt); do
cutadapt -b TCGCTGTCTCTTATACACATCT $i/${i}.fq.gz -o $i/${i}_trimmed.fq.gz 2> $i/${i}_cutadapt.err
done
