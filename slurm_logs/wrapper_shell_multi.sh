#!/bin/bash -l

#SBATCH
#SBATCH --job-name=AutNet
#SBATCH --time=0:01:00
#SBATCH --partition=parallel
#SBATCH --nodes=1
# number of tasks per node
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1


## load and unload modules

module load matlab/R2017a
module list

# invokes the Batch Script with desired parameter settings in place

for p in $(seq 80 10 80);
do
	for thresh in $(seq 0 2 4);
	do
        	l2=0.2;
		l1=10;
       		export thresh p l2 l1
        	sbatch Batch_script_sim.sh
	done
done

