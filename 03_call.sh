#!/bin/bash

#SBATCH --job-name="03_haplotypecaller"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12


# run job parallelly on HPC using GNU parallel tool

export PROJECT_DIR="/share/lab_teng/xiangliu/gatk_rna"
export PARALLEL_WLIST="$PROJECT_DIR/03_haplotypecaller_wlist"

module load GATK
#module load picard/2.21.6-Java-11
#source ~/.bashrc
cd $PROJECT_DIR

parallel -j 4 -k < $PARALLEL_WLIST
