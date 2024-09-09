#!/usr/bin/env python

import argparse
#import bioinfo  
#import numpy as np
#import gzip
#import itertools as it


def get_args():
    parser = argparse.ArgumentParser(description="report the number of mapped and unmapped reads from each of your 2 sam files")
    parser.add_argument("-input_SAM", "--input_SAM", help="To specify the input SAM file", type=str,required=True)
    #parser.add_argument("-seq_BC", "--seq_BC", help="To specify txt file containing all valid barcodes", type=str,required=True)
    return parser.parse_args()
	
args = get_args()

#assign global variables
input_file = args.input_SAM

#input_file="dre_wtAligned.out.sam"

def parse_SAM(file=input_file):
    #header_list=['@HD','@PG','@SQ','@CO']
    mapped_reads_count=0
    unmapped_reads_count=0
    with open(file, "r") as fh:
        for line in fh:
            #line=line.strip('\n')
            line_fragment=line[0:3] 
            #0:3 is the length of the header
            if line_fragment.startswith("@"):
                #skips header
                continue
            bitscore=int(line.split("\t")[1])           
            #captures bitscore
            if((bitscore & 256) != 256):                
            #is the read new/primary... first time seeing it?
                if((bitscore & 4) != 4):                
                #is the read mapped?
                    mapped_reads_count += 1
                else:
                    unmapped_reads_count += 1
    return mapped_reads_count,unmapped_reads_count


print(parse_SAM(input_file))