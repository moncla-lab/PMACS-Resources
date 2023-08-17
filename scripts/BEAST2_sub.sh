#!/bin/bash
#BSUB -W 336:00 # walltime of 2 weeks
#BSUB -J HPAI_equaldomw_mascot # job name
#BSUB -o HPAI_beast_run.out
#BSUB -e HPAI_beast_run.err
#BSUB -M 20240
#BSUB -N
#BSUB -u lamda@upenn.edu    # sends email upon job completion


module load openjdk-1.8.0
module load beast/2.7.4
module load beagle/4.0.0

beast -beagle -beagle_SSE 526meta-domwild-mascot.xml