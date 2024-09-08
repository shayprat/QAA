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

Pushed up QAA to github and pulled down locally to view plots

Using avg q-score per base scripts from Demux Assignment the first (Bi622)




(base) [spratap@n0349 QAA]$ conda activate QAA
(QAA) [spratap@n0349 QAA]$ conda install cutadapt
Retrieving notices: ...working... done
Channels:
 - conda-forge
 - bioconda
 - defaults
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: /projects/bgmp/spratap/miniforge3/envs/QAA

  added / updated specs:
    - cutadapt


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    cffi-1.17.1                |  py312h06ac9bb_0         288 KB  conda-forge
    cutadapt-4.9               |  py312hf67a6ed_1         335 KB  bioconda
    dnaio-1.2.1                |  py312hf67a6ed_2         150 KB  bioconda
    isa-l-2.31.0               |       h4bc722e_2         156 KB  conda-forge
    libexpat-2.6.3             |       h5888daf_0          72 KB  conda-forge
    libsqlite-3.46.1           |       hadc24fc_0         845 KB  conda-forge
    libstdcxx-14.1.0           |       hc0a3c3a_1         3.7 MB  conda-forge
    libstdcxx-ng-14.1.0        |       h4852527_1          51 KB  conda-forge
    ncurses-6.5                |       he02047a_1         868 KB  conda-forge
    pbzip2-1.1.13              |       h1fcc475_2          41 KB  conda-forge
    pigz-2.8                   |       h2797004_0          71 KB  conda-forge
    pip-24.2                   |     pyh8b19718_1         1.2 MB  conda-forge
    python-3.12.5              |h2ad013b_0_cpython        30.2 MB  conda-forge
    python-isal-1.7.0          |  py312h66e93f0_1          64 KB  conda-forge
    python-zlib-ng-0.5.0       |  py312h1ba79a0_1          55 KB  conda-forge
    setuptools-73.0.1          |     pyhd8ed1ab_0         1.4 MB  conda-forge
    tzdata-2024a               |       h8827d51_1         121 KB  conda-forge
    xopen-2.0.2                |     pyh707e725_1          21 KB  conda-forge
    zlib-ng-2.2.1              |       he02047a_0         102 KB  conda-forge
    zstandard-0.23.0           |  py312hef9b889_1         410 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        40.0 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge 
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-2_gnu 
  bzip2              conda-forge/linux-64::bzip2-1.0.8-h4bc722e_7 
  ca-certificates    conda-forge/linux-64::ca-certificates-2024.8.30-hbcca054_0 
  cffi               conda-forge/linux-64::cffi-1.17.1-py312h06ac9bb_0 
  cutadapt           bioconda/linux-64::cutadapt-4.9-py312hf67a6ed_1 
  dnaio              bioconda/linux-64::dnaio-1.2.1-py312hf67a6ed_2 
  isa-l              conda-forge/linux-64::isa-l-2.31.0-h4bc722e_2 
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.40-hf3520f5_7 
  libexpat           conda-forge/linux-64::libexpat-2.6.3-h5888daf_0 
  libffi             conda-forge/linux-64::libffi-3.4.2-h7f98852_5 
  libgcc             conda-forge/linux-64::libgcc-14.1.0-h77fa898_1 
  libgcc-ng          conda-forge/linux-64::libgcc-ng-14.1.0-h69a702a_1 
  libgomp            conda-forge/linux-64::libgomp-14.1.0-h77fa898_1 
  libnsl             conda-forge/linux-64::libnsl-2.0.1-hd590300_0 
  libsqlite          conda-forge/linux-64::libsqlite-3.46.1-hadc24fc_0 
  libstdcxx          conda-forge/linux-64::libstdcxx-14.1.0-hc0a3c3a_1 
  libstdcxx-ng       conda-forge/linux-64::libstdcxx-ng-14.1.0-h4852527_1 
  libuuid            conda-forge/linux-64::libuuid-2.38.1-h0b41bf4_0 
  libxcrypt          conda-forge/linux-64::libxcrypt-4.4.36-hd590300_1 
  libzlib            conda-forge/linux-64::libzlib-1.3.1-h4ab18f5_1 
  ncurses            conda-forge/linux-64::ncurses-6.5-he02047a_1 
  openssl            conda-forge/linux-64::openssl-3.3.2-hb9d3cd8_0 
  pbzip2             conda-forge/linux-64::pbzip2-1.1.13-h1fcc475_2 
  pigz               conda-forge/linux-64::pigz-2.8-h2797004_0 
  pip                conda-forge/noarch::pip-24.2-pyh8b19718_1 
  pycparser          conda-forge/noarch::pycparser-2.22-pyhd8ed1ab_0 
  python             conda-forge/linux-64::python-3.12.5-h2ad013b_0_cpython 
  python-isal        conda-forge/linux-64::python-isal-1.7.0-py312h66e93f0_1 
  python-zlib-ng     conda-forge/linux-64::python-zlib-ng-0.5.0-py312h1ba79a0_1 
  python_abi         conda-forge/linux-64::python_abi-3.12-5_cp312 
  readline           conda-forge/linux-64::readline-8.2-h8228510_1 
  setuptools         conda-forge/noarch::setuptools-73.0.1-pyhd8ed1ab_0 
  tk                 conda-forge/linux-64::tk-8.6.13-noxft_h4845f30_101 
  tzdata             conda-forge/noarch::tzdata-2024a-h8827d51_1 
  wheel              conda-forge/noarch::wheel-0.44.0-pyhd8ed1ab_0 
  xopen              conda-forge/noarch::xopen-2.0.2-pyh707e725_1 
  xz                 conda-forge/linux-64::xz-5.2.6-h166bdaf_0 
  zlib-ng            conda-forge/linux-64::zlib-ng-2.2.1-he02047a_0 
  zstandard          conda-forge/linux-64::zstandard-0.23.0-py312hef9b889_1 
  zstd               conda-forge/linux-64::zstd-1.5.6-ha6fb4c9_0 


Proceed ([y]/n)? y


Downloading and Extracting Packages:
                                                                                                                                                               
Preparing transaction: done                                                                                                                                    
Verifying transaction: done                                                                                                                                    
Executing transaction: done 

(QAA) [spratap@n0349 QAA]$ cutadapt --version                                                                                                                  
4.9   

(QAA) [spratap@n0349 QAA]$ conda install Trimmomatic                                                                                                           
Channels:                                                                                                                                                      
 - conda-forge                                                                                                                                                 
 - bioconda                                                                                                                                                    
 - defaults                                                                                                                                                    
Platform: linux-64                                                                                                                                             
Collecting package metadata (repodata.json): done                                                                                                              
Solving environment: done                                                                                                                                      
                                                                                                                                                               
## Package Plan ##                                                                                                                                             
                                                                                                                                                               
  environment location: /projects/bgmp/spratap/miniforge3/envs/QAA                                                                                             
                      
  added / updated specs:
    - trimmomatic


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    cairo-1.18.0               |       hebfffa5_3         961 KB  conda-forge
    expat-2.6.3                |       h5888daf_0         135 KB  conda-forge
    harfbuzz-9.0.0             |       hda332d3_1         1.5 MB  conda-forge
    icu-75.1                   |       he02047a_0        11.6 MB  conda-forge
    libdeflate-1.21            |       h4bc722e_0          69 KB  conda-forge
    libglib-2.80.3             |       h315aac3_2         3.7 MB  conda-forge
    libtiff-4.6.0              |       h46a8edc_4         276 KB  conda-forge
    libxcb-1.16                |       hb9d3cd8_1         386 KB  conda-forge
    openjdk-22.0.1             |       h8651b0f_1       173.3 MB  conda-forge
    pcre2-10.44                |       hba22ea6_2         930 KB  conda-forge
    trimmomatic-0.39           |       hdfd78af_2         144 KB  bioconda
    ------------------------------------------------------------
                                           Total:       193.0 MB

The following NEW packages will be INSTALLED:

  alsa-lib           conda-forge/linux-64::alsa-lib-1.2.12-h4ab18f5_0 
  cairo              conda-forge/linux-64::cairo-1.18.0-hebfffa5_3 
  expat              conda-forge/linux-64::expat-2.6.3-h5888daf_0 
  font-ttf-dejavu-s~ conda-forge/noarch::font-ttf-dejavu-sans-mono-2.37-hab24e00_0 
  font-ttf-inconsol~ conda-forge/noarch::font-ttf-inconsolata-3.000-h77eed37_0 
  font-ttf-source-c~ conda-forge/noarch::font-ttf-source-code-pro-2.038-h77eed37_0 
  font-ttf-ubuntu    conda-forge/noarch::font-ttf-ubuntu-0.83-h77eed37_2 
  fontconfig         conda-forge/linux-64::fontconfig-2.14.2-h14ed4e7_0 
  fonts-conda-ecosy~ conda-forge/noarch::fonts-conda-ecosystem-1-0 
  fonts-conda-forge  conda-forge/noarch::fonts-conda-forge-1-0 
  freetype           conda-forge/linux-64::freetype-2.12.1-h267a509_2 
  giflib             conda-forge/linux-64::giflib-5.2.2-hd590300_0 
  graphite2          conda-forge/linux-64::graphite2-1.3.13-h59595ed_1003 
  harfbuzz           conda-forge/linux-64::harfbuzz-9.0.0-hda332d3_1 
  icu                conda-forge/linux-64::icu-75.1-he02047a_0 
  keyutils           conda-forge/linux-64::keyutils-1.6.1-h166bdaf_0 
  krb5               conda-forge/linux-64::krb5-1.21.3-h659f571_0 
  lcms2              conda-forge/linux-64::lcms2-2.16-hb7c19ff_0 
  lerc               conda-forge/linux-64::lerc-4.0.0-h27087fc_0 
  libcups            conda-forge/linux-64::libcups-2.3.3-h4637d8d_4 
  libdeflate         conda-forge/linux-64::libdeflate-1.21-h4bc722e_0 
  libedit            conda-forge/linux-64::libedit-3.1.20191231-he28a2e2_2 
  libglib            conda-forge/linux-64::libglib-2.80.3-h315aac3_2 
  libiconv           conda-forge/linux-64::libiconv-1.17-hd590300_2 
  libjpeg-turbo      conda-forge/linux-64::libjpeg-turbo-3.0.0-hd590300_1 
  libpng             conda-forge/linux-64::libpng-1.6.43-h2797004_0 
  libtiff            conda-forge/linux-64::libtiff-4.6.0-h46a8edc_4 
  libwebp-base       conda-forge/linux-64::libwebp-base-1.4.0-hd590300_0 
  libxcb             conda-forge/linux-64::libxcb-1.16-hb9d3cd8_1 
  openjdk            conda-forge/linux-64::openjdk-22.0.1-h8651b0f_1 
  pcre2              conda-forge/linux-64::pcre2-10.44-hba22ea6_2 
  pixman             conda-forge/linux-64::pixman-0.43.2-h59595ed_0 
  pthread-stubs      conda-forge/linux-64::pthread-stubs-0.4-h36c2ea0_1001 
  trimmomatic        bioconda/noarch::trimmomatic-0.39-hdfd78af_2 
  xorg-fixesproto    conda-forge/linux-64::xorg-fixesproto-5.0-h7f98852_1002 
  xorg-inputproto    conda-forge/linux-64::xorg-inputproto-2.3.2-h7f98852_1002 
  xorg-kbproto       conda-forge/linux-64::xorg-kbproto-1.0.7-h7f98852_1002 
  xorg-libice        conda-forge/linux-64::xorg-libice-1.1.1-hd590300_0 
  xorg-libsm         conda-forge/linux-64::xorg-libsm-1.2.4-h7391055_0 
  xorg-libx11        conda-forge/linux-64::xorg-libx11-1.8.9-hb711507_1 
  xorg-libxau        conda-forge/linux-64::xorg-libxau-1.0.11-hd590300_0 
  xorg-libxdmcp      conda-forge/linux-64::xorg-libxdmcp-1.1.3-h7f98852_0 
  xorg-libxext       conda-forge/linux-64::xorg-libxext-1.3.4-h0b41bf4_2 
  xorg-libxfixes     conda-forge/linux-64::xorg-libxfixes-5.0.3-h7f98852_1004 
  xorg-libxi         conda-forge/linux-64::xorg-libxi-1.7.10-h4bc722e_1 
  xorg-libxrender    conda-forge/linux-64::xorg-libxrender-0.9.11-hd590300_0 
  xorg-libxt         conda-forge/linux-64::xorg-libxt-1.3.0-hd590300_1 
  xorg-libxtst       conda-forge/linux-64::xorg-libxtst-1.2.5-h4bc722e_0 
  xorg-recordproto   conda-forge/linux-64::xorg-recordproto-1.14.2-h7f98852_1002 
  xorg-renderproto   conda-forge/linux-64::xorg-renderproto-0.11.1-h7f98852_1002 
  xorg-xextproto     conda-forge/linux-64::xorg-xextproto-7.3.0-h0b41bf4_1003 
  xorg-xproto        conda-forge/linux-64::xorg-xproto-7.0.31-h7f98852_1007 
  zlib               conda-forge/linux-64::zlib-1.3.1-h4ab18f5_1 


Proceed ([y]/n)? y


Downloading and Extracting Packages:
                                                                                                                                                               
Preparing transaction: done                                                                                                                                    
Verifying transaction: done                                                                                                                                    
Executing transaction: done

(QAA) [spratap@n0349 QAA]$ trimmomatic -version                                                                                                                
0.39  


cutadapt.sh

Sanitiy check


(base) [spratap@n0349 QAA]$ conda install star
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
    - star


The following NEW packages will be INSTALLED:

  htslib             bioconda/linux-64::htslib-1.20-h5efdd21_2 
  star               bioconda/linux-64::star-2.7.11b-h43eeafb_2 


Proceed ([y]/n)? y


Downloading and Extracting Packages:

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

(base) [spratap@n0349 QAA]$ conda install numpy
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
    - numpy


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    numpy-2.1.1                |  py312h58c1407_0         8.1 MB  conda-forge
    ------------------------------------------------------------
                                           Total:         8.1 MB

The following NEW packages will be INSTALLED:

  libstdcxx          conda-forge/linux-64::libstdcxx-14.1.0-hc0a3c3a_1 

The following packages will be UPDATED:

  numpy                               2.0.0-py312h22e1c76_0 --> 2.1.1-py312h58c1407_0 


Proceed ([y]/n)? y


Downloading and Extracting Packages:
                                                                                                                                                                             
Preparing transaction: done
Verifying transaction: done
Executing transaction: done



(base) [spratap@n0349 QAA]$ conda install matplotlib
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
    - matplotlib


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    double-conversion-3.3.0    |       h59595ed_0          77 KB  conda-forge
    libclang-cpp18.1-18.1.8    |default_hf981a13_4        18.3 MB  conda-forge
    libdrm-2.4.123             |       hb9d3cd8_0         296 KB  conda-forge
    libpciaccess-0.18          |       hd590300_0          28 KB  conda-forge
    libxslt-1.1.39             |       h76b75d6_0         248 KB  conda-forge
    matplotlib-3.9.2           |  py312h7900ff3_0           9 KB  conda-forge
    matplotlib-base-3.9.2      |  py312h854627b_0         7.5 MB  conda-forge
    pyside6-6.7.2              |  py312hb5137db_2        10.1 MB  conda-forge
    qt6-main-6.7.2             |       h0f8cd61_2        44.8 MB  conda-forge
    wayland-1.23.1             |       h3e06ad9_0         314 KB  conda-forge
    xcb-util-cursor-0.1.4      |       h4ab18f5_2          20 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        81.8 MB

The following NEW packages will be INSTALLED:

  double-conversion  conda-forge/linux-64::double-conversion-3.3.0-h59595ed_0 
  libclang-cpp18.1   conda-forge/linux-64::libclang-cpp18.1-18.1.8-default_hf981a13_4 
  libdrm             conda-forge/linux-64::libdrm-2.4.123-hb9d3cd8_0 
  libpciaccess       conda-forge/linux-64::libpciaccess-0.18-hd590300_0 
  libxslt            conda-forge/linux-64::libxslt-1.1.39-h76b75d6_0 
  pyside6            conda-forge/linux-64::pyside6-6.7.2-py312hb5137db_2 
  qt6-main           conda-forge/linux-64::qt6-main-6.7.2-h0f8cd61_2 
  wayland            conda-forge/linux-64::wayland-1.23.1-h3e06ad9_0 
  xcb-util-cursor    conda-forge/linux-64::xcb-util-cursor-0.1.4-h4ab18f5_2 

The following packages will be UPDATED:

  matplotlib                          3.9.1-py312h7900ff3_0 --> 3.9.2-py312h7900ff3_0 
  matplotlib-base                     3.9.1-py312h9201f00_0 --> 3.9.2-py312h854627b_0 

The following packages will be DOWNGRADED:

  glib                                    2.80.3-h8a4344b_1 --> 2.80.2-hf974151_0 
  glib-tools                              2.80.3-h73ef956_1 --> 2.80.2-hb6ce0ca_0 
  libglib                                 2.80.3-h8a4344b_1 --> 2.80.2-hf974151_0 
  pcre2                                    10.44-h0f59acf_0 --> 10.43-hcad00b1_0 


Proceed ([y]/n)? y


Downloading and Extracting Packages:
                                                                                                                                                                 
Preparing transaction: done                                                                                                                                      
Verifying transaction: done                                                                                                                                      
Executing transaction: done 




(base) [spratap@n0349 QAA]$ conda install htseq                                                                                                                  
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
    - htseq


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    htseq-2.0.5                |  py312h8cd533b_2         470 KB  bioconda
    numpy-1.26.4               |  py312heda63a1_0         7.1 MB  conda-forge
    pandas-2.2.2               |  py312h1d6d2e6_1        14.7 MB  conda-forge
    pysam-0.22.1               |  py312hcfdcdd7_2         4.4 MB  bioconda
    python-tzdata-2024.1       |     pyhd8ed1ab_0         141 KB  conda-forge
    scipy-1.14.0               |  py312h499d17b_2        16.8 MB  conda-forge
    ------------------------------------------------------------
                                           Total:        43.7 MB

The following NEW packages will be INSTALLED:

  htseq              bioconda/linux-64::htseq-2.0.5-py312h8cd533b_2 
  pandas             conda-forge/linux-64::pandas-2.2.2-py312h1d6d2e6_1 
  pysam              bioconda/linux-64::pysam-0.22.1-py312hcfdcdd7_2 
  python-tzdata      conda-forge/noarch::python-tzdata-2024.1-pyhd8ed1ab_0 
  scipy              conda-forge/linux-64::scipy-1.14.0-py312h499d17b_2 

The following packages will be DOWNGRADED:

  numpy                               2.1.1-py312h58c1407_0 --> 1.26.4-py312heda63a1_0 


Proceed ([y]/n)? y


Downloading and Extracting Packages:
                                                                                                                                                                 
Preparing transaction: done                                                                                                                                      
Verifying transaction: done                                                                                                                                      
Executing transaction: done



A bajillion slurm scripts for building STAR db
-need to gunzip primary_assembly.fa.ga and gtf.gz (can remove readfile flag)




reads mapped from SAM files:
(QAA) [spratap@n0349 Part_3]$ python reads_mapped.py -input_SAM STAR_align_output/control_S18_Aligned.out.sam 
(mapped,unmapped) (19780624, 710240)
(QAA) [spratap@n0349 Part_3]$ python reads_mapped.py -input_SAM STAR_align_output/mbnl_S11_Aligned.out.sam 
(mapped,unmapped) (14436372, 400402)


htseq-count SLURM -16037604 (did not have output file so scanceled)
                  -16037613
