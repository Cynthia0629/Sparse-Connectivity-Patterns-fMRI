#!/bin/bash
#SBATCH
#SBATCH --job-name=USTB_$n
#SBATCH --time=10:0:0
#SBATCH --partition=shared
#SBATCH --nodes=10
# number of tasks (processes) per node
#SBATCH --ntasks-per-node=1
# number of cpus (threads) per task (process)
#SBATCH --cpus-per-task=1

curr_dir=$PWD
cd Convex_Relaxation/
matlab -nojvm -nodisplay -nosplash -r "run('/home-3/ndsouza4@jhu.edu/data/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Simulated_Data_comp.m');exit;"
cd $curr_dir
