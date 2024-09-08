#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --mem=16G
#SBATCH --job-name=trimmomatic

/usr/bin/time -v trimmomatic PE -threads 32 \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/cutadapt_out/cut_15_3C_mbnl_S11_L008_R1_001.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/cutadapt_out/cut_15_3C_mbnl_S11_L008_R2_001.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R1_001_P.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R1_001_U.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R2_001_P.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R2_001_U.fastq.gz \
 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

 /usr/bin/time -v trimmomatic PE -threads 32 \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/cutadapt_out/cut_24_4A_control_S18_L008_R1_001.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/cutadapt_out/cut_24_4A_control_S18_L008_R2_001.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_24_4A_control_S18_L008_R1_001_P.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_24_4A_control_S18_L008_R1_001_U.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_24_4A_control_S18_L008_R2_001_P.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_24_4A_control_S18_L008_R2_001_U.fastq.gz \
 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

