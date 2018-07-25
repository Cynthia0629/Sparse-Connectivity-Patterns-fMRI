#!/bin/bash -l
#SBATCH
##SBATCH --job-name=USTB_$n
#SBATCH --time=3:0:0
#SBATCH --partition=shared
#SBATCH --nodes=1
# number of tasks (processes) per node

# number of cpus (threads) per task (process)



curr_dir=$PWD
#cd Convex_Relaxation/
matlab -nojvm -nodisplay -nosplash -r "st=$st;l2=$l2*0.1;l1=$l1;l=$l;l3=$l3;net=$ne;offs=$offs;scale=$scale;run('/home-3/ndsouza4@jhu.edu/data/Sparse-Connectivity-Patterns-fMRI/Convex_Relaxation/Complete_sweep_alg2.m');exit;"
cd $curr_dir
