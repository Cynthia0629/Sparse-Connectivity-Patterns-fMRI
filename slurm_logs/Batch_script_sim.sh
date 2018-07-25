#!/bin/bash
#SBATCH
#SBATCH --job-name=USTB_$n
#SBATCH --time=2:0:0
#SBATCH --partition=parallel
#SBATCH --nodes=1
# number of tasks (processes) per node
#SBATCH --ntasks-per-node=1
# number of cpus (threads) per task (process)
#SBATCH --cpus-per-task=1

curr_dir=$PWD
cd MultiModal_Modelling/
matlab -nojvm -nodisplay -nosplash -r "lambda_2=$l2;lambda_1=$l1;p=$p;thresh=0.1*$thresh;run('/home-3/ndsouza4@jhu.edu/data/Sparse-Connectivity-Patterns-fMRI/MultiModal_Modelling/Runner_script.m');exit;"
cd $curr_dir
