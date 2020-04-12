#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=22g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e index_bams.err
#PBS -o index_bams.out
#PBS -N index_bams

cd /home/jkimball/haasx092/reneth_gbs

module load samtools

for i in $(cat reneth_bams.txt); do
	samtools index -b $i
done
