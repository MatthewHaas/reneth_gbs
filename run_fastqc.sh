#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=30g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -o run_fastqc.out
#PBS -e run_fastqc.err
#PBS -N run_fastqc

cd /home/jkimball/haasx092/reneth_gbs

module load fastqc

# Run fastQC on trimmed reads
for i in $(cat 200410_sample_list.txt); do
fastqc $i/${i}_trimmed.fq.gz;
done
