#!/bin/bash

#REAPR PIPELINE

#SETUP
SPEC=$1
mkdir -p /scratch/tsackton/assemblies/$SPEC/reapr
#mkdir -p /scratch/tsackton/assemblies/$SPEC/final
cd /scratch/tsackton/assemblies/$SPEC/reapr
ASSEMBLY="../haplofied/final.assembly.fasta"
LOCAL_AS="$SPEC.fa"
echo "Working directory is $(pwd)"

#CHECK FASTA AND MAKE LOCAL COPY OF ASSEMBLY
reapr facheck $ASSEMBLY $SPEC
reapr perfectmap $LOCAL_AS /scratch/tsackton/ratite_trimmed/reapr/${SPEC}_frag_1.fastq.gz /scratch/tsackton/ratite_trimmed/reapr/${SPEC}_frag_2.fastq.gz 280 ${SPEC}_perfect 
reapr smaltmap -n 16 $LOCAL_AS /scratch/tsackton/ratite_trimmed/reapr/${SPEC}_jump_1_forREAPR.fastq /scratch/tsackton/ratite_trimmed/reapr/${SPEC}_jump_2_forREAPR.fastq ${SPEC}_longmapped.bam
reapr pipeline $LOCAL_AS ${SPEC}_longmapped.bam ../final ${SPEC}_perfect
