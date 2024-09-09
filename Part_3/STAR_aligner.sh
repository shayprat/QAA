#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=aligner

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_2/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R1_001_P.fastq.gz /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_2/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R2_001_P.fastq.gz \
    --genomeDir /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.DNA.GRCm39.ensembl.112_db \
    --outFileNamePrefix mbnl_S11_

    /usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_2/trimmomatic_output/trim_24_4A_control_S18_L008_R1_001_P.fastq.gz /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_2/trimmomatic_output/trim_24_4A_control_S18_L008_R2_001_P.fastq.gz \
    --genomeDir /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.DNA.GRCm39.ensembl.112_db \
    --outFileNamePrefix control_S18_
    