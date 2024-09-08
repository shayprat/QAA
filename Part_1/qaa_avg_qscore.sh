#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --mem=16G
#SBATCH --job-name=mean_qscore_per_base


/usr/bin/time -v python avg_qscore_tsv.py -ifq /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R1_001.fastq.gz -seq_len 101 > 24_4A_control_S18_L008_R1_001.tsv
/usr/bin/time -v python avg_qscore_tsv.py -ifq /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R2_001.fastq.gz -seq_len 101 > 24_4A_control_S18_L008_R2_001.tsv
/usr/bin/time -v python avg_qscore_tsv.py -ifq /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R1_001.fastq.gz -seq_len 101 > 15_3C_mbnl_S11_L008_R1_001.tsv
/usr/bin/time -v python avg_qscore_tsv.py -ifq /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R2_001.fastq.gz -seq_len 101 > 15_3C_mbnl_S11_L008_R2_001.tsv
