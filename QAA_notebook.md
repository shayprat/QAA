Start Date: 9/4/2024

Assigned demux'd files:
--
```/projects/bgmp/shared/Bi623/QAA_data_assignments.txt```

24_4A_control_S18_L008  

```/projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R1_001.fastq.gz ```

```/projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R2_001.fastq.gz ```

15_3C_mbnl_S11_L008

```/projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R1_001.fastq.gz```

```/projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R2_001.fastq.gz ```

Do not move, copy, or unzip these data!
--
# Part 1 – Read quality score distributions
1. Create a new conda environment called `QAA` and install `FastQC`. Google around if you need a refresher on how to create conda environments. Recommend doing this in an interactive session, not the login node! Record details of how you created this environment in your lab notebook! Make sure you check your installation with:
   - `fastqc --version` (should be 0.12.1)


   ```$ conda create -n "QAA"```
```To activate this environment, use
#     $ conda activate QAA
#
# To deactivate an active environment, use
#
#     $ conda deactivate
```
```
(base) [spratap@login1 QAA]```$ conda install FastQC=0.12.1
```
Channels:
 - conda-forge
 - bioconda
 - defaults
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done
## Package Plan ##

  environment location: /projects/bgmp/spratap/miniforge3

  added / updated specs:
    - fastqc=0.12.1


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    ca-certificates-2024.8.30  |       hbcca054_0         155 KB  conda-forge
    certifi-2024.8.30          |     pyhd8ed1ab_0         160 KB  conda-forge
    fastqc-0.12.1              |       hdfd78af_0        11.1 MB  bioconda
    giflib-5.2.2               |       hd590300_0          75 KB  conda-forge
    libgcc-14.1.0              |       h77fa898_1         827 KB  conda-forge
    libgcc-ng-14.1.0           |       h69a702a_1          51 KB  conda-forge
    libgomp-14.1.0             |       h77fa898_1         449 KB  conda-forge
    openjdk-21.0.2             |       haa376d0_0       172.5 MB  conda-forge
    openssl-3.3.2              |       hb9d3cd8_0         2.8 MB  conda-forge
    xorg-fixesproto-5.0        |    h7f98852_1002           9 KB  conda-forge
    xorg-inputproto-2.3.2      |    h7f98852_1002          19 KB  conda-forge
    xorg-libxfixes-5.0.3       |    h7f98852_1004          18 KB  conda-forge
    xorg-libxi-1.7.10          |       h4bc722e_1          46 KB  conda-forge
    xorg-libxt-1.3.0           |       hd590300_1         370 KB  conda-forge
    xorg-libxtst-1.2.5         |       h4bc722e_0          32 KB  conda-forge
    xorg-recordproto-1.14.2    |    h7f98852_1002           8 KB  conda-forge
    ------------------------------------------------------------
                                           Total:       188.5 MB

The following NEW packages will be INSTALLED:

  fastqc             bioconda/noarch::fastqc-0.12.1-hdfd78af_0 
  giflib             conda-forge/linux-64::giflib-5.2.2-hd590300_0 
  libgcc             conda-forge/linux-64::libgcc-14.1.0-h77fa898_1 
  openjdk            conda-forge/linux-64::openjdk-21.0.2-haa376d0_0 
  perl               conda-forge/linux-64::perl-5.32.1-7_hd590300_perl5 
  xorg-fixesproto    conda-forge/linux-64::xorg-fixesproto-5.0-h7f98852_1002 
  xorg-inputproto    conda-forge/linux-64::xorg-inputproto-2.3.2-h7f98852_1002 
  xorg-libxfixes     conda-forge/linux-64::xorg-libxfixes-5.0.3-h7f98852_1004 
  xorg-libxi         conda-forge/linux-64::xorg-libxi-1.7.10-h4bc722e_1 
  xorg-libxt         conda-forge/linux-64::xorg-libxt-1.3.0-hd590300_1 
  xorg-libxtst       conda-forge/linux-64::xorg-libxtst-1.2.5-h4bc722e_0 
  xorg-recordproto   conda-forge/linux-64::xorg-recordproto-1.14.2-h7f98852_1002 

The following packages will be UPDATED:

  ca-certificates                       2024.7.4-hbcca054_0 --> 2024.8.30-hbcca054_0 
  certifi                             2024.7.4-pyhd8ed1ab_0 --> 2024.8.30-pyhd8ed1ab_0 
  libgcc-ng                               13.2.0-h807b86a_5 --> 14.1.0-h69a702a_1 
  libgomp                                 13.2.0-h807b86a_5 --> 14.1.0-h77fa898_1 
  openssl                                  3.3.1-h4bc722e_2 --> 3.3.2-hb9d3cd8_0 


Proceed ([y]/n)? y


Downloading and Extracting Packages:
      
Preparing transaction: 
done 
Verifying transaction:
done                                                                    
Executing transaction:
 done 


---
Confirm FastQC verison:
 ```
 (base) [spratap@login1 QAA]$ fastqc --version                                                                                                                                   
FastQC v0.12.1 
```

---

2. Using `FastQC` via the command line on Talapas, produce plots of the per-base quality score distributions for R1 and R2 reads. Also, produce plots of the per-base N content, and comment on whether or not they are consistent with the quality score plots.


Looking at this [Link](https://hbctraining.github.io/Intro-to-rnaseq-hpc-salmon-flipped/lessons/05_qc_running_fastqc_interactively.html) to use ```FastQC```

Link (above) recommends using a commpute note before running FastQC
```srun -A bgmp -p bgmp --mem=100gb -c 8 --pty bash```

SBATCH SCRIPT: fastqc.sh 

```/usr/bin/time -v fastqc -o <output directory> <absolute path to file>```

