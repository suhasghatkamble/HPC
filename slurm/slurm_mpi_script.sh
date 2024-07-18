#!/bin/bash

#SBATCH --nodes=2               #specify number of nodes
#SBATCH --ntasks-per-node=2     #specify number of cores per node
#SBATCH --time=01:00:00         #specify maximum duration of run in hours:minutes:seconds format
#SBATCH --job-name=mpi hello    #specify job name
#SBATCH --error=job.%J.err      #specify error file name
#SBATCH --output=job.%J.out     #specify output file name
#SBATCH --partition=standard    #specify type of resource such as CPU/GPU/High memory etc.

### Load the default MPI module
module load intel/oneapi/mpi/2021.4.0

### Run the mpi program with mpirun
mpirun -np $SLURM_NTASKS ./hello.mpi  
