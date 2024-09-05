#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --mem=16G
#SBATCH --job-name=fastqc_Bi623

/usr/bin/time -v fastqc -o /home/spratap/bgmp/bioinfo/Bi623/QAA/fastqc_out /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R1_001.fastq.gz 
/usr/bin/time -v fastqc -o /home/spratap/bgmp/bioinfo/Bi623/QAA/fastqc_out /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R2_001.fastq.gz
/usr/bin/time -v fastqc -o /home/spratap/bgmp/bioinfo/Bi623/QAA/fastqc_out /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R1_001.fastq.gz
/usr/bin/time -v fastqc -o /home/spratap/bgmp/bioinfo/Bi623/QAA/fastqc_out /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R2_001.fastq.gz