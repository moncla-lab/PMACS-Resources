Notes for working in the UPenn PMACS HPC environment. 
LD, 2023-05


These are general notes for using the PMACS cluster at UPenn. 

###Logging into cluster 


 ssh PMACSUSER@consign.pmacs.upenn.edu

 
###Transferring files to cluster

rsync -av test PMACSUSER@mercury.pmacs.upenn.edu:~/directory_in_cluster


###Interactive sessions

bsub -Is bash

Louise BEAST example of interactive session:

   1. log into your account on consign.pmacs.upenn.edu with ssh: ssh username@consign.pmacs.upenn.edu
   2. start an interactive node: bsub -Is bash
   3. load java: module load java/openjdk-1.8.0
   4. load beast: module load beast  -> beast=beast1, and beast2=beast 2
   5. load beagle: module load beagle
   6. launch the job: bsub  beast filename.xml
   7. view currently running jobs: bjobs -u username
   8. kill a job: bkill job_id

###Batch submission and submission scripts

Place submission script and all relevant analyses files in the folder. For multiple jobs there will be multiple folders that each contain a submission file and data/analyses files. A batch subsmission script *multi_sub.sh* which is provided can be executed in the command line of the cluster to execute each of these subsmission scripts indepedently.


To submit a single job script use following syntax in terminal:

bsub < sub.sh


Example submission script contents *sub.sh*:

#!/bin/bash
#BSUB -W 72:00 # walltime of 72 hours
#BSUB -J rand_all_3 # job name
#BSUB -o rand_all_3.out
#BSUB -e rand_all_3.err
#BSUB -M 10240


~/bin/FastTree -nt -gtr -fastest  WI-COVID-to2023_04_15.wloc.align90.rand3.fasta > WI-COVID-to2023_04_15.wloc.align90.rand3.tree



In above example we are setting a wall time and output files for error and console outputs. We are also setting a higher memory limit than the default (default 6GB).
In this case we are calling an executable file in our bin directory, in other instances where programs are already instlaled on the cluster you would add the following after your #BSUB block:

module load *name_of_package**


If you are not sure if a package is available , in an interactive session use the following command:

module spider *name_of_package**


### Installing software


You can request the PMACS staff to install things and they may get it up there one day. If you dont want to wait you can rysnc the executables for a program into your cluster environment and save it there.
For example if i have the executable file for IQTREE you can uploud it to a folder called bin:

rsync -av IQTREE.sh username@mercury.pmacs.upenn.edu:~/bin

This will let you use it in a submission script by calling the location of the script (see submission script example above)





###Notes:

** always ensure that you are pointing to the right file location in your submission script

** if jobs fail, the error file is always helpful first step in diagnoistics

** Make sure to back up all results locally and onto Box and remove data/results from cluster once properly backed up (there is a storage space charage and some program outputs from BEAST can add up alot)





