#!/bin/bash

#SBATCH --job-name="gatk_hpv_2"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12


# run job parallelly on HPC using GNU parallel tool

export PROJECT_DIR="/share/lab_teng/xiangliu/gatk_rna"
export PARALLEL_WLIST="$PROJECT_DIR/hpv16_wlist_human"

module load GATK
#source ~/.bashrc
cd $PROJECT_DIR

parallel -j 10 -k < $PARALLEL_WLIST
