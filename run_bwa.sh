#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=15g,walltime=48:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -o run_bwa.out
#PBS -e run_bwa.err
#PBS -N run_bwa

module load bwa
module load samtools

FASTA='/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta.gz'

cd /home/jkimball/haasx092/reneth_gbs

for i in $(cat 200410_sample_list.txt); do
bwa mem $FASTA $i/${i}_trimmed.fq.gz 2> $i/${i}_bwa.err | samtools sort -o $i/${i}_sorted.bam 2> $i/${i}_samtools_sort.err;
done
