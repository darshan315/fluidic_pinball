#!/bin/bash -l        
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --time=2-12:00:00
#SBATCH --job-name=o3_i3
#SBATCH --ntasks-per-node=4

module load singularity/3.6.0rc2 

singularity run of2106-py1.9.0-cpu.sif ./Allrun ./test_cases/run/mesh_o3_i3/
