# Notes for working in the UPenn PMACS HPC environment. 
These are general notes for using the PMACS cluster at UPenn. 

## Logging into cluster 


 ssh PMACSUSER@consign.pmacs.upenn.edu

 
## Transferring files to cluster

rsync -av test PMACSUSER@mercury.pmacs.upenn.edu:~/directory_in_cluster


## Interactive sessions

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

## Batch submission and submission scripts

Place submission script and all relevant analyses files in the folder. For multiple jobs there will be multiple folders that each contain a submission file and data/analyses files. A batch subsmission script *multi_sub.sh* which is provided can be executed in the command line of the cluster to execute each of these subsmission scripts indepedently. Note: to use the multisub.sh script must use an interactive session see relevant section.


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


## Installing software


You can request the PMACS staff to install things and they may get it up there one day and may not even install it properly if they do. If you dont want to wait you can rysnc the executables for a program into your cluster environment and save it there.

For example if i have the executable file for IQTREE you can uploud it to a folder called bin:

rsync -av iqtree username@mercury.pmacs.upenn.edu:~/bin

This will let you use it in a submission script by calling the location of the script (see submission script example above)
In this case the iqtree executable can be downloaded here: http://www.iqtree.org/#download (choose the 64-bit Linux version)


## Monitoring Jobs

When running jobs that have outputs to console, because LSF clusters dont write outfiles in realtime you need to use the *bpeek* commmand:

bpeek <jobid> 
 
 This will allow you to see your console output, this is especially useful for running BEAST where seeing your states/time and other parameters is useful for diagnosing runs in realtime. 
 
## BEAST 2 and packages
    
 Louise interactive job steps:
 
1.  Once in an interactive job, `module load beast2`. Then do `packagemanager -help`.
2.   To get a list of all available packages and their locations, do `packagemanager -list`
3.   To install package (E.g. mascot) do: `packagemanager -add Mascot`. This will install the publicly available one on packagemanager.
   
 
 Installing beta package versions (Example): 
 
1. To get Nicola’s latest Mascot version, downloaded that version from here: https://github.com/nicfel/Mascot/releases/download/v3.0.2/Mascot.v3.0.2.zip
2. All packages are in this directory on pMACs: Packages user path : /home/lhmoncla/.beast/2.7
3. To see that directory: `ls /home/lhmoncla/.beast/`To see what is in the mascot folder: `ls .beast/2.7/Mascot`
4. To update with the new files, simply replace those files with the new ones by syncing the new files to pMACS and moving them into that folder. Just replaced all the files in `/ .beast/2.7/Mascot` with those in `Mascot.v3.0.2`.

 To update BEAST 2 to latest version (as of 2023-06-11 v 2.7.4): 
 
 packagemanager -update

If run into issues adding a beast2 package using packagemanager and receive the following error:

packages user path : /home/user/.beast/2.7
Access URL : https://raw.githubusercontent.com/CompEvol/CBAN/master/packages2.7.xml
Getting list of packages ...Done!

Determine packages to install
Start installation
java.io.FileNotFoundException: /home/user/.beast/2.7/toDeleteList (No such file or directory)
	at java.base/java.io.FileOutputStream.open0(Native Method)
	at java.base/java.io.FileOutputStream.open(Unknown Source)
	at java.base/java.io.FileOutputStream.<init>(Unknown Source)
	at java.base/java.io.FileWriter.<init>(Unknown Source)
	at beast.pkgmgmt.PackageManager.uninstallPackage(Unknown Source)
	at beast.pkgmgmt.PackageManager.uninstallPackage(Unknown Source)
	at beast.pkgmgmt.PackageManager.prepareForInstall(Unknown Source)
	at beast.pkgmgmt.PackageManager.main(Unknown Source)

Do the following:
Go to the your user directory and do the following:

1. mkdir .beast
2. mkdir 2.7
3. touch toDeleteList

### Increasing heap for JAVA jobs

Sometimes for jobs that are really large BEAST will throw a java.lang.OutOfMemoryError error that it has reached heap memory. To deal with this you will set the heap memory higher for java doing the following steps:
In an interactive job (bsub -Is bash) do the following:
1. nano ~/.bashrc and add the following line:           export JAVA_TOOL_OPTIONS="-Xmx4g"
2. If want to set it higher change the number, in this example it is 4gigabytes
3. source ~/.bashrc 

When you run the jobs the heap should now be higher.

## Notes:

** always ensure that you are pointing to the right file location in your submission script

** if jobs fail, the error file is always helpful first step in diagnoistics

** Make sure to back up all results locally and onto Box and remove data/results from cluster once properly backed up (there is a storage space charage and some program outputs from BEAST can add up alot)





