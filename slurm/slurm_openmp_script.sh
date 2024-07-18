#!/bin/bash
#SBATCH --job-name=openmp

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

#SBATCH --time=10:00

#SBATCH --output=ompresult.txt

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

srun ./hello.omp
