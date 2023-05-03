#!/bin/bash
#BSUB -W 72:00 # walltime of 72 hours
#BSUB -J rand_all_3 # job name
#BSUB -o rand_all_3.out
#BSUB -e rand_all_3.err
#BSUB -M 10240
#BSUB -u lamda@vet.upenn.edu    # sends emnail upon job completion


~/bin/FastTree -nt -gtr -fastest  WI-COVID-to2023_04_15.wloc.align90.rand3.fasta > WI-COVID-to2023_04_15.wloc.align90.rand3.tree
