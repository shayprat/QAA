BI623 - Quality Assessment

## Upload your:
- [x] lab notebook (you're already here!)
- [x] Talapas batch script/code, [Part 1](https://github.com/shayprat/QAA/tree/master/Part_1), [Part 2](https://github.com/shayprat/QAA/tree/master/Part_2), [Part 3](https://github.com/shayprat/QAA/tree/master/Part_3)
- [x] [FastQC plots](https://github.com/shayprat/QAA/tree/master/Part_1/fastqc_out)
- [x] [counts files](https://github.com/shayprat/QAA/tree/master/Part_3/htseq_counts_file) generated from htseq-count (in a folder would be nice),
- [x] [pdf report](https://github.com/shayprat/QAA/blob/master/QAA_report.pdf)  
- [ ] and any additional plots, code, or code output

[Packages installed in QAA environment](package_install_info.md)
-----
Start Date: 9/4/2024

Path to assigned demux'd files:
--
```/projects/bgmp/shared/Bi623/QAA_data_assignments.txt```

**Assigned samples:**
``` bash
24_4A_control_S18_L008    15_3C_mbnl_S11_L008
```

**file paths**
`/projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R1_001.fastq.gz `

`/projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R2_001.fastq.gz `

```/projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R1_001.fastq.gz```

```/projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R2_001.fastq.gz ```

**Do not move, copy, or unzip these data!**
--
**inital file exploration summary**     
| File | Line Count | Record Count| Phred encoding | File Size (M)| Read Length
|---|---|---|---|---|---|
| 15_3C_mbnl_S11_L008_R1_001.fastq.gz| 31,225,612 | 7,806,403 | phred+33 | 407 | 101
| 15_3C_mbnl_S11_L008_R2_001.fastq.gz | 31,225,612 | 7,806,403 | phred+33 | 465 | 101
| 24_4A_control_S18_L008_R1_001.fastq.gz| 42,063,496  | 10,515,874 | phred+33 | 578 | 101
| 24_4A_control_S18_L008_R2_001.fastq.gz| 42,063,496   | 10,515,874 | phred+33 | 595 | 101

**Commands used**
Line count 
```bash 
zcat <filename> | wc -l
```
Read Count = Line Count / 4

Phred Encoding 
``` bash
zcat <filename> | sed -n '4~4n' | head
```
Includes non-alphabetical characters (i.e #, <, -), therefore Phred+33

File Size
``` bash
cd /projects/bgmp/shared/2017_sequencing/demultiplexed/
ls -lah
```
Read Length
```bash 
zcat <filename> | sed -n '2~4p' | awk '{print length($0)}' | uniq
```
----
# Part 1 – Read quality score distributions
1. Create a new conda environment called `QAA` and install `FastQC`. Google around if you need a refresher on how to create conda environments. Recommend doing this in an interactive session, not the login node! Record details of how you created this environment in your lab notebook! Make sure you check your installation with:
   - `fastqc --version` (should be 0.12.1)

first moved onto a compute node using:
``` bash
srun -A bgmp -p bgmp --mem=100gb -c 8 --pty bash
```

```bash 
$ conda create -n "QAA"
#To activate this environment, use
#     $ conda activate QAA
#
#To deactivate an active environment, use
#
#     $ conda deactivate

$ conda install FastQC=0.12.1
$ fastqc --version                                                                                                                                   
FastQC v0.12.1 
```


2. Using `FastQC` via the command line on Talapas, produce plots of the per-base quality score distributions for R1 and R2 reads. Also, produce plots of the per-base N content, and comment on whether or not they are consistent with the quality score plots.


Looking at this [Link](https://hbctraining.github.io/Intro-to-rnaseq-hpc-salmon-flipped/lessons/05_qc_running_fastqc_interactively.html) to use ```FastQC```
```srun -A bgmp -p bgmp --mem=100gb -c 8 --pty bash```

[FastQC Sbatch](Part_1/fastqc.sh)

```/usr/bin/time -v fastqc -o <output directory> <absolute path to file>```

Pushed up QAA to github and pulled down locally to view plots
filepath to FastQC output: /home/spratap/bgmp/bioinfo/Bi623/QAA/Part_1/fastqc_out

Using avg q-score per base scripts from Demux Assignment the first (Bi622)


# Part 2 – Adaptor trimming comparison

5.  In your QAA environment, install `cutadapt` and `Trimmomatic`. Check your installations with:
    - `cutadapt --version` (should be 4.9)
    - `trimmomatic -version` (should be 0.39)

```
(base) [spratap@n0349 QAA]$ conda activate QAA
(QAA) [spratap@n0349 QAA]$ conda install cutadapt 
(QAA) [spratap@n0349 QAA]$ cutadapt --version                                                                                                                  
4.9   
(QAA) [spratap@n0349 QAA]$ conda install trimmomatic   
(QAA) [spratap@n0349 QAA]$ trimmomatic -version                                                                                                                
0.39  
```

From Metadata, libraries use ILMN TruSeq adapters:
Read 1: `AGATCGGAAGAGCACACGTCTGAACTCCAGTCA`
Read 2: `AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT`

[Cutadapt sbatch](Part_2/cutadapt.sh)

```/usr/bin/time -v cutadapt -a <R1 adapter sequence> -A <R2 adapter sequence> -o <R1 outfile.fastq.qz> -p <R2 outfile.fastq.qz> <file path to R1 fastq> <filepath to R2 fastq>```

**Cutadapt output** (/home/spratap/bgmp/bioinfo/Bi623/QAA/Part_2/slurm-16026622.out)

```
Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o cut_24_4A_control_S18_L008_R1_001.fastq.gz -p cut_24_4A_control_S18_L008_R2_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/24_4A_control_S18_L008_R2_001.fastq.gz
Processing paired-end reads on 1 core ...
Finished in 152.698 s (14.521 µs/read; 4.13 M reads/minute).

=== Summary ===

Total read pairs processed:         10,515,874
  Read 1 with adapter:                 335,742 (3.2%)
  Read 2 with adapter:                 417,709 (4.0%)
Pairs written (passing filters):    10,515,874 (100.0%)

Total basepairs processed: 2,124,206,548 bp
  Read 1: 1,062,103,274 bp
  Read 2: 1,062,103,274 bp
Total written (filtered):  2,119,352,063 bp (99.8%)
  Read 1: 1,059,836,363 bp
  Read 2: 1,059,515,700 bp

=== First read: Adapter 1 ===

Sequence: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA; Type: regular 3'; Length: 33; Trimmed: 335742 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 23.7%
  C: 30.9%
  G: 27.9%
  T: 17.4%
  none/other: 0.1%

Overview of removed sequences
length	count	expect	max.err	error counts
3	196453	164310.5	0	196453
4	44693	41077.6	0	44693
5	15081	10269.4	0	15081
6	6716	2567.4	0	6716
7	5895	641.8	0	5895
8	5084	160.5	0	5084
9	4848	40.1	0	4649 199
10	4653	10.0	1	4323 330
11	4084	2.5	1	3902 182
12	3829	0.6	1	3700 129
13	3519	0.2	1	3397 122
14	3100	0.0	1	3000 100
15	2907	0.0	1	2814 93
16	2728	0.0	1	2617 111
17	2514	0.0	1	2395 119
18	2389	0.0	1	2289 99 1
19	2047	0.0	1	1961 85 1
20	1936	0.0	2	1849 79 8
21	1781	0.0	2	1689 79 13
22	1681	0.0	2	1604 64 13
23	1447	0.0	2	1373 68 6
24	1334	0.0	2	1269 59 6
25	1309	0.0	2	1237 60 12
26	1172	0.0	2	1098 63 11
27	1159	0.0	2	1099 49 11
28	1047	0.0	2	983 50 14
29	927	0.0	2	866 53 7 1
30	858	0.0	3	807 42 7 2
31	780	0.0	3	728 39 9 4
32	716	0.0	3	661 46 6 3
33	646	0.0	3	596 34 11 5
34	641	0.0	3	601 30 4 6
35	546	0.0	3	509 27 6 4
36	541	0.0	3	507 26 5 3
37	511	0.0	3	466 36 5 4
38	482	0.0	3	451 25 3 3
39	419	0.0	3	381 33 5
40	438	0.0	3	410 23 5
41	364	0.0	3	340 17 7
42	362	0.0	3	330 26 3 3
43	287	0.0	3	267 12 6 2
44	285	0.0	3	258 22 4 1
45	270	0.0	3	248 14 3 5
46	238	0.0	3	220 9 8 1
47	251	0.0	3	225 22 3 1
48	216	0.0	3	200 11 5
49	212	0.0	3	198 9 4 1
50	206	0.0	3	183 16 4 3
51	158	0.0	3	146 9 3
52	167	0.0	3	156 6 2 3
53	158	0.0	3	142 10 4 2
54	121	0.0	3	111 6 2 2
55	90	0.0	3	81 6 1 2
56	103	0.0	3	97 6
57	87	0.0	3	76 5 2 4
58	96	0.0	3	87 4 3 2
59	64	0.0	3	58 4 1 1
60	68	0.0	3	63 3 1 1
61	81	0.0	3	77 2 2
62	63	0.0	3	57 5 1
63	63	0.0	3	57 3 3
64	32	0.0	3	30 1 0 1
65	46	0.0	3	40 5 0 1
66	51	0.0	3	48 0 1 2
67	40	0.0	3	36 3 0 1
68	40	0.0	3	36 3 0 1
69	22	0.0	3	13 4 4 1
70	29	0.0	3	27 2
71	22	0.0	3	19 2 0 1
72	18	0.0	3	15 2 1
73	17	0.0	3	16 0 1
74	9	0.0	3	9
75	20	0.0	3	13 5 1 1
76	13	0.0	3	13
77	7	0.0	3	3 3 0 1
78	7	0.0	3	5 0 1 1
79	5	0.0	3	5
80	2	0.0	3	2
81	5	0.0	3	4 1
82	3	0.0	3	3
83	7	0.0	3	7
84	6	0.0	3	5 0 1
85	8	0.0	3	7 0 0 1
86	3	0.0	3	3
87	6	0.0	3	5 1
88	1	0.0	3	1
89	5	0.0	3	4 1
90	3	0.0	3	2 1
91	6	0.0	3	6
92	4	0.0	3	4
93	1	0.0	3	1
94	1	0.0	3	1
95	2	0.0	3	2
96	6	0.0	3	5 1
97	3	0.0	3	3
98	5	0.0	3	5
99	6	0.0	3	6
100	1	0.0	3	0 0 0 1
101	359	0.0	3	1 281 72 5


=== Second read: Adapter 2 ===

Sequence: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT; Type: regular 3'; Length: 33; Trimmed: 417709 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 27.7%
  C: 31.5%
  G: 28.5%
  T: 12.2%
  none/other: 0.1%

Overview of removed sequences
length	count	expect	max.err	error counts
3	259093	164310.5	0	259093
4	58265	41077.6	0	58265
5	17491	10269.4	0	17491
6	7637	2567.4	0	7637
7	6056	641.8	0	6056
8	5204	160.5	0	5204
9	5028	40.1	0	4715 313
10	4890	10.0	1	4410 480
11	4295	2.5	1	3958 337
12	3932	0.6	1	3758 174
13	3578	0.2	1	3470 108
14	3150	0.0	1	3060 90
15	2942	0.0	1	2837 105
16	2773	0.0	1	2695 78
17	2554	0.0	1	2464 90
18	2412	0.0	1	2305 104 3
19	2083	0.0	1	2009 73 1
20	1968	0.0	2	1867 89 12
21	1805	0.0	2	1717 78 10
22	1708	0.0	2	1629 62 17
23	1473	0.0	2	1408 54 11
24	1363	0.0	2	1279 71 13
25	1334	0.0	2	1256 63 15
26	1198	0.0	2	1132 53 13
27	1189	0.0	2	1128 47 14
28	1082	0.0	2	1020 50 12
29	959	0.0	2	894 47 12 6
30	891	0.0	3	829 38 17 7
31	812	0.0	3	734 54 16 8
32	738	0.0	3	672 48 12 6
33	667	0.0	3	621 36 6 4
34	663	0.0	3	611 34 16 2
35	562	0.0	3	514 35 6 7
36	559	0.0	3	521 28 6 4
37	542	0.0	3	491 30 15 6
38	504	0.0	3	462 29 7 6
39	439	0.0	3	398 24 8 9
40	472	0.0	3	434 23 9 6
41	385	0.0	3	352 22 8 3
42	377	0.0	3	348 20 5 4
43	316	0.0	3	280 17 13 6
44	310	0.0	3	283 16 7 4
45	293	0.0	3	265 17 8 3
46	263	0.0	3	234 13 11 5
47	271	0.0	3	242 20 4 5
48	249	0.0	3	215 19 4 11
49	225	0.0	3	201 16 5 3
50	223	0.0	3	196 18 5 4
51	178	0.0	3	152 12 7 7
52	196	0.0	3	169 12 6 9
53	174	0.0	3	156 11 4 3
54	142	0.0	3	121 16 2 3
55	104	0.0	3	86 11 4 3
56	119	0.0	3	101 9 5 4
57	100	0.0	3	85 12 3
58	116	0.0	3	96 13 3 4
59	74	0.0	3	61 7 3 3
60	82	0.0	3	70 8 1 3
61	98	0.0	3	86 7 3 2
62	76	0.0	3	64 7 3 2
63	80	0.0	3	69 7 1 3
64	55	0.0	3	45 4 0 6
65	64	0.0	3	51 6 3 4
66	61	0.0	3	54 3 2 2
67	55	0.0	3	43 5 3 4
68	48	0.0	3	40 4 1 3
69	31	0.0	3	24 1 5 1
70	37	0.0	3	32 3 1 1
71	33	0.0	3	28 2 2 1
72	21	0.0	3	16 2 3
73	25	0.0	3	21 2 0 2
74	16	0.0	3	11 3 1 1
75	30	0.0	3	21 4 4 1
76	22	0.0	3	19 2 1
77	14	0.0	3	8 0 1 5
78	10	0.0	3	7 1 2
79	7	0.0	3	7
80	6	0.0	3	3 0 0 3
81	5	0.0	3	4 1
82	5	0.0	3	4 0 0 1
83	8	0.0	3	7 0 0 1
84	7	0.0	3	6 0 1
85	7	0.0	3	7
86	3	0.0	3	3
87	7	0.0	3	6 0 0 1
88	2	0.0	3	2
89	5	0.0	3	4 1
90	3	0.0	3	1 2
91	6	0.0	3	6
92	4	0.0	3	4
93	2	0.0	3	1 0 1
94	1	0.0	3	1
95	2	0.0	3	1 1
96	7	0.0	3	4 2 0 1
97	3	0.0	3	1 0 2
98	5	0.0	3	2 3
99	6	0.0	3	5 1
101	324	0.0	3	1 255 62 6


Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o cut_15_3C_mbnl_S11_L008_R1_001.fastq.gz -p cut_15_3C_mbnl_S11_L008_R2_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R1_001.fastq.gz /projects/bgmp/shared/2017_sequencing/demultiplexed/15_3C_mbnl_S11_L008_R2_001.fastq.gz
Processing paired-end reads on 1 core ...
Finished in 114.778 s (14.703 µs/read; 4.08 M reads/minute).

=== Summary ===

Total read pairs processed:          7,806,403
  Read 1 with adapter:                 417,810 (5.4%)
  Read 2 with adapter:                 477,359 (6.1%)
Pairs written (passing filters):     7,806,403 (100.0%)

Total basepairs processed: 1,576,893,406 bp
  Read 1:   788,446,703 bp
  Read 2:   788,446,703 bp
Total written (filtered):  1,566,917,010 bp (99.4%)
  Read 1:   783,587,227 bp
  Read 2:   783,329,783 bp

=== First read: Adapter 1 ===

Sequence: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA; Type: regular 3'; Length: 33; Trimmed: 417810 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 17.0%
  C: 29.2%
  G: 37.9%
  T: 15.8%
  none/other: 0.2%

Overview of removed sequences
length	count	expect	max.err	error counts
3	152119	121975.0	0	152119
4	40634	30493.8	0	40634
5	18152	7623.4	0	18152
6	11433	1905.9	0	11433
7	10612	476.5	0	10612
8	9967	119.1	0	9967
9	9897	29.8	0	9695 202
10	9771	7.4	1	9375 396
11	9272	1.9	1	8950 322
12	8958	0.5	1	8669 289
13	8435	0.1	1	8183 252
14	7935	0.0	1	7658 277
15	7804	0.0	1	7549 255
16	7350	0.0	1	7094 256
17	7259	0.0	1	6983 276
18	6676	0.0	1	6426 245 5
19	6321	0.0	1	6049 264 8
20	5859	0.0	2	5566 261 32
21	5824	0.0	2	5576 220 28
22	5455	0.0	2	5191 227 37
23	5009	0.0	2	4748 227 34
24	4769	0.0	2	4530 211 28
25	4490	0.0	2	4245 216 29
26	4138	0.0	2	3888 210 40
27	3984	0.0	2	3763 197 23 1
28	3806	0.0	2	3583 197 24 2
29	3369	0.0	2	3158 184 26 1
30	3224	0.0	3	3015 173 23 13
31	2883	0.0	3	2713 136 24 10
32	2616	0.0	3	2464 123 19 10
33	2510	0.0	3	2359 130 14 7
34	2256	0.0	3	2110 124 15 7
35	2010	0.0	3	1886 107 13 4
36	1944	0.0	3	1835 93 13 3
37	1836	0.0	3	1717 95 16 8
38	1672	0.0	3	1577 82 10 3
39	1575	0.0	3	1486 77 9 3
40	1355	0.0	3	1283 60 9 3
41	1188	0.0	3	1123 58 5 2
42	1074	0.0	3	1024 45 4 1
43	986	0.0	3	927 50 6 3
44	898	0.0	3	850 38 9 1
45	829	0.0	3	781 45 3
46	821	0.0	3	770 43 5 3
47	696	0.0	3	663 26 6 1
48	692	0.0	3	641 40 8 3
49	663	0.0	3	627 28 7 1
50	571	0.0	3	537 28 3 3
51	497	0.0	3	459 31 7
52	456	0.0	3	431 18 5 2
53	437	0.0	3	416 15 5 1
54	351	0.0	3	322 26 1 2
55	362	0.0	3	338 18 4 2
56	303	0.0	3	289 10 2 2
57	313	0.0	3	297 12 3 1
58	279	0.0	3	263 12 3 1
59	261	0.0	3	243 16 2
60	268	0.0	3	258 5 2 3
61	239	0.0	3	228 7 4
62	196	0.0	3	180 14 1 1
63	216	0.0	3	197 16 3
64	197	0.0	3	186 11
65	152	0.0	3	142 9 0 1
66	155	0.0	3	146 5 2 2
67	122	0.0	3	121 1
68	120	0.0	3	112 5 2 1
69	92	0.0	3	85 6 1
70	84	0.0	3	81 0 2 1
71	68	0.0	3	66 2
72	83	0.0	3	80 3
73	70	0.0	3	65 3 1 1
74	50	0.0	3	46 4
75	31	0.0	3	29 0 1 1
76	29	0.0	3	23 4 2
77	15	0.0	3	14 1
78	13	0.0	3	12 1
79	15	0.0	3	15
80	6	0.0	3	6
81	6	0.0	3	6
82	4	0.0	3	3 1
83	7	0.0	3	6 1
84	1	0.0	3	1
85	6	0.0	3	6
86	5	0.0	3	5
87	2	0.0	3	2
88	1	0.0	3	1
89	2	0.0	3	2
90	2	0.0	3	2
91	3	0.0	3	3
92	3	0.0	3	3
93	1	0.0	3	1
95	2	0.0	3	2
96	2	0.0	3	1 1
101	686	0.0	3	2 600 81 3


=== Second read: Adapter 2 ===

Sequence: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT; Type: regular 3'; Length: 33; Trimmed: 477359 times

Minimum overlap: 3
No. of allowed errors:
1-9 bp: 0; 10-19 bp: 1; 20-29 bp: 2; 30-33 bp: 3

Bases preceding removed adapters:
  A: 19.7%
  C: 29.8%
  G: 41.0%
  T: 9.4%
  none/other: 0.1%

Overview of removed sequences
length	count	expect	max.err	error counts
3	199425	121975.0	0	199425
4	47599	30493.8	0	47599
5	19744	7623.4	0	19744
6	12401	1905.9	0	12401
7	10799	476.5	0	10799
8	10053	119.1	0	10053
9	10101	29.8	0	9767 334
10	9962	7.4	1	9460 502
11	9490	1.9	1	9136 354
12	9057	0.5	1	8791 266
13	8483	0.1	1	8292 191
14	8005	0.0	1	7815 190
15	7863	0.0	1	7612 251
16	7412	0.0	1	7224 188
17	7300	0.0	1	7070 230
18	6732	0.0	1	6426 304 2
19	6370	0.0	1	6165 201 4
20	5896	0.0	2	5661 200 35
21	5856	0.0	2	5582 242 32
22	5504	0.0	2	5276 197 31
23	5056	0.0	2	4850 179 27
24	4802	0.0	2	4575 197 30
25	4514	0.0	2	4303 183 28
26	4180	0.0	2	3950 201 29
27	4006	0.0	2	3820 154 32
28	3839	0.0	2	3635 176 28
29	3401	0.0	2	3220 150 28 3
30	3242	0.0	3	3080 134 19 9
31	2915	0.0	3	2662 202 33 18
32	2641	0.0	3	2494 116 18 13
33	2537	0.0	3	2380 118 30 9
34	2287	0.0	3	2147 108 23 9
35	2041	0.0	3	1923 89 18 11
36	1959	0.0	3	1832 100 21 6
37	1865	0.0	3	1738 94 27 6
38	1702	0.0	3	1590 89 14 9
39	1613	0.0	3	1512 73 16 12
40	1389	0.0	3	1311 56 13 9
41	1217	0.0	3	1138 56 12 11
42	1093	0.0	3	1040 38 12 3
43	1004	0.0	3	948 37 12 7
44	914	0.0	3	854 44 6 10
45	862	0.0	3	789 48 14 11
46	845	0.0	3	796 34 5 10
47	718	0.0	3	672 39 4 3
48	714	0.0	3	646 50 14 4
49	690	0.0	3	637 35 13 5
50	592	0.0	3	548 32 7 5
51	515	0.0	3	467 34 11 3
52	474	0.0	3	438 26 4 6
53	470	0.0	3	433 22 9 6
54	373	0.0	3	340 21 5 7
55	377	0.0	3	342 22 6 7
56	319	0.0	3	293 19 6 1
57	330	0.0	3	307 14 6 3
58	305	0.0	3	278 18 4 5
59	281	0.0	3	255 14 10 2
60	288	0.0	3	261 16 9 2
61	258	0.0	3	238 15 3 2
62	215	0.0	3	199 9 6 1
63	239	0.0	3	209 23 3 4
64	214	0.0	3	194 10 8 2
65	173	0.0	3	150 16 4 3
66	166	0.0	3	150 8 4 4
67	142	0.0	3	125 10 6 1
68	130	0.0	3	117 10 1 2
69	107	0.0	3	93 6 6 2
70	93	0.0	3	84 5 3 1
71	80	0.0	3	72 5 1 2
72	100	0.0	3	86 7 5 2
73	84	0.0	3	70 8 2 4
74	61	0.0	3	54 3 2 2
75	39	0.0	3	33 2 3 1
76	33	0.0	3	30 1 1 1
77	18	0.0	3	15 2 0 1
78	16	0.0	3	16
79	22	0.0	3	16 3 0 3
80	7	0.0	3	6 1
81	8	0.0	3	7 0 1
82	4	0.0	3	4
83	7	0.0	3	7
84	2	0.0	3	1 0 0 1
85	10	0.0	3	6 1 2 1
86	5	0.0	3	4 1
87	3	0.0	3	2 0 0 1
88	1	0.0	3	1
89	2	0.0	3	2
90	3	0.0	3	2 1
91	4	0.0	3	3 0 1
92	3	0.0	3	2 1
93	1	0.0	3	1
95	2	0.0	3	2
96	2	0.0	3	1 1
98	1	0.0	3	0 0 0 1
99	2	0.0	3	0 0 2
101	680	0.0	3	0 597 73 10

```

____
[Trimmomatic sbatch](Part_2/trimmomatic.sh)


```
/usr/bin/time -v trimmomatic PE -threads 32 \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/cutadapt_out/cut_15_3C_mbnl_S11_L008_R1_001.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/cutadapt_out/cut_15_3C_mbnl_S11_L008_R2_001.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R1_001_P.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R1_001_U.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R2_001_P.fastq.gz \
 /home/spratap/bgmp/bioinfo/Bi623/QAA/trimmomatic_output/trim_15_3C_mbnl_S11_L008_R2_001_U.fastq.gz \
 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35 
 ```


Sanitiy check
```zact <path to assigned file> | grep --color=always "adapter sequence" | head ```  to highlight Adapter sequence
Looks like they're at the 3' end!


# Part 3 – Alignment and strand-specificity

1. download Mus musculus primary assembly and gtf files (/home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/**wget_mouse_ensembl.sh**)
2. GenomeGenerate database (/home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/**STAR__build_db.sh**)

A bajillion slurm scripts for building STAR db
**need to gunzip primary_assembly.fa.ga and gtf.gz (can remove readfile flag)**

3. Align trimmed paired fastqs to genome database (/home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/**STAR_aligner.sh**)


reads mapped from SAM files:
```(QAA) [spratap@n0349 Part_3]$ python reads_mapped.py -input_SAM STAR_align_output/control_S18_Aligned.out.sam 
(mapped,unmapped) (19780624, 710240)
(QAA) [spratap@n0349 Part_3]$ python reads_mapped.py -input_SAM STAR_align_output/mbnl_S11_Aligned.out.sam 
(mapped,unmapped) (14436372, 400402)
```
**S11**
 ```
                                 Started job on |	Sep 08 11:33:42
                             Started mapping on |	Sep 08 11:33:51
                                    Finished on |	Sep 08 11:34:41
       Mapping speed, Million of reads per hour |	534.12

                          Number of input reads |	7418387
                      Average input read length |	198
                                    UNIQUE READS:
                   Uniquely mapped reads number |	6900290
                        Uniquely mapped reads % |	93.02%
                          Average mapped length |	198.16
                       Number of splices: Total |	4975068
            Number of splices: Annotated (sjdb) |	4931364
                       Number of splices: GT/AG |	4922613
                       Number of splices: GC/AG |	40430
                       Number of splices: AT/AC |	5444
               Number of splices: Non-canonical |	6581
                      Mismatch rate per base, % |	0.24%
                         Deletion rate per base |	0.01%
                        Deletion average length |	2.44
                        Insertion rate per base |	0.01%
                       Insertion average length |	1.70
                             MULTI-MAPPING READS:
        Number of reads mapped to multiple loci |	325272
             % of reads mapped to multiple loci |	4.38%
        Number of reads mapped to too many loci |	53846
             % of reads mapped to too many loci |	0.73%
                                  UNMAPPED READS:
  Number of reads unmapped: too many mismatches |	0
       % of reads unmapped: too many mismatches |	0.00%
            Number of reads unmapped: too short |	134430
                 % of reads unmapped: too short |	1.81%
                Number of reads unmapped: other |	4549
                     % of reads unmapped: other |	0.06%
                                  CHIMERIC READS:
                       Number of chimeric reads |	0
                            % of chimeric reads |	0.00%
```


**S18**
```
                            Started job on |	Sep 08 11:34:41
                             Started mapping on |	Sep 08 11:34:50
                                    Finished on |	Sep 08 11:36:03
       Mapping speed, Million of reads per hour |	505.25

                          Number of input reads |	10245432
                      Average input read length |	199
                                    UNIQUE READS:
                   Uniquely mapped reads number |	9414754
                        Uniquely mapped reads % |	91.89%
                          Average mapped length |	199.03
                       Number of splices: Total |	6614199
            Number of splices: Annotated (sjdb) |	6556906
                       Number of splices: GT/AG |	6541013
                       Number of splices: GC/AG |	57206
                       Number of splices: AT/AC |	7299
               Number of splices: Non-canonical |	8681
                      Mismatch rate per base, % |	0.25%
                         Deletion rate per base |	0.02%
                        Deletion average length |	3.87
                        Insertion rate per base |	0.01%
                       Insertion average length |	1.80
                             MULTI-MAPPING READS:
        Number of reads mapped to multiple loci |	481458
             % of reads mapped to multiple loci |	4.70%
        Number of reads mapped to too many loci |	68191
             % of reads mapped to too many loci |	0.67%
                                  UNMAPPED READS:
  Number of reads unmapped: too many mismatches |	0
       % of reads unmapped: too many mismatches |	0.00%
            Number of reads unmapped: too short |	275932
                 % of reads unmapped: too short |	2.69%
                Number of reads unmapped: other |	5097
                     % of reads unmapped: other |	0.05%
                                  CHIMERIC READS:
                       Number of chimeric reads |	0
                            % of chimeric reads |	0.00%
```
4. htseq-counts (/home/spratap/bgmp/bioinfo/Bi623/QAA/Part_3/htseq.sh)
htseq-count SLURM -16037604 (did not have output file so scanceled)
                  -16037613


```(base) [spratap@login1 Part_3]$ cat htseq_out_mbbl_S11_stranded_y.txt | grep "ENSMU" | awk '{count+=$2} END {print count}'
267375
(base) [spratap@login1 Part_3]$ cat htseq_out_mbbl_S11_stranded_rev.txt | grep "ENSMU" | awk '{count+=$2} END {print count}'
6164597
(base) [spratap@login1 Part_3]$ cat htseq_out_control_S18_stranded_y.txt | grep "ENSMU" | awk '{count+=$2} END {print count}'
323588
(base) [spratap@login1 Part_3]$ cat htseq_out_control_S18_stranded_rev.txt | grep "ENSMU" | awk '{count+=$2} END {print count}'
8376547
```