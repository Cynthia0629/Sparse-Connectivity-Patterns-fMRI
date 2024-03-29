#!/bin/bash -l

#SBATCH
#SBATCH --job-name=AutNet
#SBATCH --time=0:01:00
#SBATCH --partition=shared
#SBATCH --nodes=1
# number of tasks per node
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1


## load and unload modules

module load matlab/R2017a
module list

# invokes the Batch Script with desired parameter settings in place


for l2 in $(seq 1 0.2 2);
do
for en in $(seq 1 1 1);
do

	l1=40;
	l=1;
	l3=1;
	ne=7;
	offs=100;
	scale=-1;
        
        st="'/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Praxis_Aut/'";
	export l1 l2 l3 l ne offs scale st
	sbatch Batch_script_alg2.sh
done
done 
