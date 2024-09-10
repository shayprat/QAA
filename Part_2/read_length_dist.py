#!/usr/bin/env python 

import argparse
def get_args():
    parser = argparse.ArgumentParser(description="Plot the read length distribution of paired reads - R1 and R2")
    parser.add_argument("-R1","--R1", help="input R1 fastq", required= True)
    parser.add_argument("-R2","--R2", help="input R2 fastq", required = True)
    parser.add_argument("-output","--out",help="output plot name", required = True)
    return parser.parse_args()

import matplotlib.pyplot as plt 
import gzip


args = get_args()
R1 = args.R1 
R2 = args.R2 
output = args.out


def rl_distribution(fq_file):
    rl_counts = []  
    with gzip.open(fq_file,"rt") as fh:
        i = 0   #initiate counter to track line number
        for line in fh:  
            i+=1   
            line = line.strip('\n') 
            if i%4 == 2:  #if it's a sequence line!
                rl_counts.append(len(line))
    return rl_counts

R1 = rl_distribution(R1)
R2 = rl_distribution(R2)

 
plt.hist([R1, R2],label=["R1","R2"], bins = 66, color =['goldenrod','cornflowerblue'])
plt.yscale('log')
plt.title(f'Trimmed Read Length Distrubtion - {output}')
plt.xlabel("Read Length (bp)")
plt.ylabel("Number of Reads")
plt.legend(('R1',"R2"))
plt.savefig(f'{output}.png')
