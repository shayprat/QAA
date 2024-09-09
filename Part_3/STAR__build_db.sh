#!/usr/bin/env bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --mem=100G
#SBATCH --job-name=build_STAR_db


/usr/bin/time -v STAR --runThreadN 8 --runMode genomeGenerate \
 --genomeDir /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.DNA.GRCm39.ensembl.112_db \
 --genomeFastaFiles /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.GRCm39.dna.primary_assembly.fa \
 --sjdbGTFfile /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.GRCm39.112.gtf


