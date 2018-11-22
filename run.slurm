#!/bin/bash
#SBATCH --job-name=jltest
#SBATCH --output=partest.out
#SBATCH --error=partest.err
#SBATCH --partition=MISC
#SBATCH --nodes=2

srun -l julia script.jl