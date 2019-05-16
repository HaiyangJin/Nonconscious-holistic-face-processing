#!/bin/bash
#SBATCH --job-name=1lmmRT     # job name (shows up in the queue)
#SBATCH --account=uoa00424     # Project Account
#SBATCH --time=00:10:00         # Walltime (HH:MM:SS)
#SBATCH --mem-per-cpu=8192      # memory/cpu (in MB)
#SBATCH --ntasks=1              # number of tasks (e.g. MPI)
#SBATCH --cpus-per-task=2       # number of cores per task (e.g. OpenMP)
#SBATCH --partition=large        # specify a partition
#SBATCH --hint=nomultithread    # don't use hyperthreading
#SBATCH --mail-type=END
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --output=P101/R_P101_RT_lmm_%j.out # Include the job ID in the names of

module load R/3.5.3-gimkl-2018b
srun Rscript P101/NeSI_lmm_rt_P101.R