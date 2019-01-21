#!/bin/bash
#SBATCH --job-name=R_P101     # job name (shows up in the queue)
#SBATCH --account=uoa00424     # Project Account
#SBATCH --time=0:30:00         # Walltime (HH:MM:SS)
#SBATCH --mem-per-cpu=8192      # memory/cpu (in MB)
#SBATCH --ntasks=1              # number of tasks (e.g. MPI)
#SBATCH --cpus-per-task=6       # number of cores per task (e.g. OpenMP)
#SBATCH --partition=bigmem        # specify a partition
#SBATCH --hint=nomultithread    # don't use hyperthreading
#SBATCH --mail-type=END
#SBATCH --mail-user=hjin317@aucklanduni.ac.nz
#SBATCH --output=P101/R_P101_%j.out # Include the job ID in the names of

module load Rstudio/1.1.456
srun Rscript P101/NeSI_fit_glmm_P101.R