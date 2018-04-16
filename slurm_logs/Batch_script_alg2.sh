#!/bin/bash
#SBATCH
#SBATCH --job-name=USTB_$n
#SBATCH --time=7:0:0
#SBATCH --partition=shared
#SBATCH --nodes=2
# number of tasks (processes) per node
#SBATCH --ntasks=10
# number of cpus (threads) per task (process)
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64

curr_dir=$PWD
#cd Convex_Relaxation/
matlab -nojvm -nodisplay -nosplash -r "run('/home-3/ndsouza4@jhu.edu/data/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Complete_sweep_alg2.m');exit;"
cd $curr_dir
