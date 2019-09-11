#!/bin/bash
#SBATCH --job-name=jltest
#SBATCH --output=partest.out
#SBATCH --error=partest.err
#SBATCH --partition=COMPUTE
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

#srun -l julia script.jl
julia script.jl
