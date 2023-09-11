#!/bin/bash
#BSUB -W 96:00 # walltime of 72 hours
#BSUB -J HPAI_beast_run1 # job name
#BSUB -o HPAI_beast_run.out
#BSUB -e HPAI_beast_run.err
#BSUB -M 20240
#BSUB -N
#BSUB -u lamda@upenn.edu    # sends email upon job completion


module load openjdk-1.8.0
module load beast/1.10.4
module load beagle/4.0.0
module load gcc/8.5.0 

beast -beagle -beagle_SSE filtered_sequences_h5nx_ha.mo.clean.v2.xml
