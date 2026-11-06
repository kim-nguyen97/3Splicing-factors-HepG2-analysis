#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16gb
#SBATCH --job-name=trimmomatic
#SBATCH --output=TrimU2AF2-SF1.out
#SBATCH --error=TrimU2AF2-SF1.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

input_dir=/home/s484579/Masterthesis/SF1/ENCODE_inputdata
files=/home/s484579/Masterthesis/SF1/ENCODE_inputdata/*_R1.fastq.gz
output_dir=/home/s484579/Masterthesis/quality_control/Adapter_trimming/U2AF2-SF1_control
adapter_file=/home/s484579/Masterthesis/quality_control/Adapter_trimming/TruSeq3-PE-2.fa

cd $input_dir

for f in *_R1.fastq.gz # for each sample
do
    n=${f%%_R1.fastq.gz} # strip part of file name
    trimmomatic PE ${n}_R1.fastq.gz  ${n}_R2.fastq.gz \
    ${output_dir}/${n}_R1_trimmed.fastq.gz ${output_dir}/${n}_R1_unpaired.fastq.gz ${output_dir}/${n}_R2_trimmed.fastq.gz \
    ${output_dir}/${n}_R2_unpaired.fastq.gz ILLUMINACLIP:"$adapter_file":2:30:10 \
    LEADING:3 TRAILING:3 HEADCROP:10 SLIDINGWINDOW:4:15 MINLEN:36
done