#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=16gb
#SBATCH --job-name=Fastqc
#SBATCH --array=1
#SBATCH --output=Fastqc-trimmed.U2AF2andSF1.out
#SBATCH --error=Fastqc-trimmed.U2AF2andSF1.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

source ../.env

path=$PROJECT_DIR/quality_control/Adapter_trimming/U2AF2-SF1_control
files=$PROJECT_DIR/quality_control/Adapter_trimming/U2AF2-SF1_control/*.fastq.gz
output_dir=$PROJECT_DIR/quality_control/Output_Fastqc/After_trim_U2AF2andSF1

cd $path

for f in $files; do 
echo "Working on $f"

fastqc -o $output_dir -f fastq $f
done