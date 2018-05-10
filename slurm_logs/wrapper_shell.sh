#!/bin/bash -l

#SBATCH
#SBATCH --job-name=AutNet
#SBATCH --time=0:07:00
#SBATCH --partition=shared
#SBATCH --nodes=1
# number of tasks per node
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1


## load and unload modules

module load matlab/R2017a
module list

# invokes the Batch Script with desired parameter settings in place


for l2 in $(seq 0.02 0.02 0.1);
do
	l1=50;
	l=1;
	l3=1;
	ne=6;
	offs=0;
	scale=1;
	
        st="/work-zfs/avenka14/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Praxis_Cont";
	export l1 l2 l3 l ne offs scale st
	sbatch Batch_script_alg2.sh
done 
