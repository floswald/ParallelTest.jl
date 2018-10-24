#!/bin/bash
#SBATCH --job-name=hostname
#SBATCH --output=slurm.out
#SBATCH --error=slurm.err
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1

srun -l julia -p 4 -e '@everywhere println("hi i am $(getpid())")'