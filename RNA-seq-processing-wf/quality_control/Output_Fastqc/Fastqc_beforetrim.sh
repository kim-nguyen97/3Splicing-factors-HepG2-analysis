#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=16gb
#SBATCH --job-name=Fastqc
#SBATCH --array=1
#SBATCH --output=Fastqc-AF2-control.out
#SBATCH --error=Fastqc-AF2-control.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

source ../.env

path=$PROJECT_DIR/U2AF2/ENCODE_inputdata
files=$PROJECT_DIR/U2AF2/ENCODE_inputdata/*.fastq.gz
output_dir=$PROJECT_DIR/quality_control/Output_Fastqc/Before_trim_U2AF2andSF1

cd $path

for f in $files; do 
echo "Working on $f"

fastqc -o $output_dir -f fastq $f
done