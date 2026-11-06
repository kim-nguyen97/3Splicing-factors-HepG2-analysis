#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=16gb
#SBATCH --job-name=Fastqc
#SBATCH --array=1
#SBATCH --output=multiqc.mapping.out
#SBATCH --error=multiqc.mapping.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

source ../.env

path=$PROJECT_DIR/mapping/STARout
files=$PROJECT_DIR/mapping/STARout/*.Log.final.out
output_dir=$PROJECT_DIR/quality_control/Output_Fastqc/After_mapping

cd $path

multiqc -o $output_dir -f $files