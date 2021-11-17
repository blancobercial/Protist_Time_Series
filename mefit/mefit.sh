#!/bin/bash

mkdir mefit_results

#make one line for each of the file pairs in the folder - example below

./mefit -s ./mefit_results/NS_30401 -r1 FILE_R1.fastq  -r2 FILE_R2.fastq  -p casper.params -meep 0.1
