#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=htseq

/usr/bin/time -v htseq-count --stranded=yes \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/STAR_align_output/control_S18_Aligned.out.sam \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.GRCm39.112.gtf > htseq_out_control_S18_stranded_y.txt

/usr/bin/time -v htseq-count --stranded=reverse \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/STAR_align_output/control_S18_Aligned.out.sam \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.GRCm39.112.gtf > htseq_out_control_S18_stranded_rev.txt

/usr/bin/time -v htseq-count --stranded=yes \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/STAR_align_output/mbnl_S11_Aligned.out.sam \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.GRCm39.112.gtf > htseq_out_mbbl_S11_stranded_y.txt

/usr/bin/time -v htseq-count --stranded=reverse \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/STAR_align_output/mbnl_S11_Aligned.out.sam \
    /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/Mus_musculus.GRCm39.112.gtf > htseq_out_mbbl_S11_stranded_rev.txt