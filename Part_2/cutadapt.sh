#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --mem=16G
#SBATCH --job-name=cutadapt

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o cut_24_4A_control_S18_L008_R1_001.fastq.gz -p cut_24_4A_control_S18_L008_R2_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R2_001.fastq.gz
/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o cut_15_3C_mbnl_S11_L008_R1_001.fastq.gz -p cut_15_3C_mbnl_S11_L008_R2_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R2_001.fastq.gz
