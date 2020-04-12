#!/bin/bash -l
#PBS -l nodes=1:ppn=8,mem=22g,walltime=24:00:00
#PBS -m abe
#PBS -M haasx092@umn.edu
#PBS -e scythe_mpileup.err
#PBS -o scythe_mpileup.out
#PBS -N scythe_mpileup

cd /home/jkimball/haasx092/reneth_gbs

module load samtools
module load bcftools
module load htslib
module load parallel

export bams="reneth_bams.txt"
export prefix="200412_samtools"
export ref="/home/jkimball/mshao/genome_seq/zizania_palustris_13Nov2018_okGsv.fasta"

parallel_samtools_processes=15

mkdir -p $prefix
cut -f 1 ${ref}.fai


scythe_mpileup() {
	REGIONS=${1}
	SCAFFOLD=$(echo ${REGIONS} | cut -f 1 -d ";")
	samtools mpileup -q 20 -gDVu \
		-b $bams \
		-r ${REGIONS} \
		-f ${ref} \
		| bcftools call -mv \
		| bgzip -c \
		> $prefix/${prefix}_${SCAFFOLD}.vcf.gz \
		2> $prefix/${prefix}_${SCAFFOLD}.err
}
  
export -f scythe_mpileup
  
parallel --will-cite -j $parallel_samtools_processes scythe_mpileup ::: $(cut -f 1 ${ref}.fai)
