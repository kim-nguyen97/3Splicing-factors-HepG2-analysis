#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8gb
#SBATCH --job-name="MAJIQ-build"
#SBATCH --output=majiq.out
#SBATCH --error=majiq.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

bam_dir=/home/s484579/Masterthesis/hepG2/mapping/STARout

cd $bam_dir
cp U2AF2_SF1_Control_rep1.Aligned.sortedByCoord.out.bam U2AF2_control_rep1_dup.bam
cp U2AF2_SF1_Control_rep1.Aligned.sortedByCoord.out.bam.bai U2AF2_control_rep1_dup.bai
cp U2AF2_SF1_Control_rep2.Aligned.sortedByCoord.out.bam U2AF2_control_rep2_dup.bam
cp U2AF2_SF1_Control_rep2.Aligned.sortedByCoord.out.bam.bai U2AF2_control_rep2_dup.bai

build_dir=/home/s484579/Masterthesis/MAJIQ/majiq_build_output
config_file=/home/s484579/Masterthesis/MAJIQ/MAJIQ.config
genome=/home/s484579/Masterthesis/MAJIQ/gencode.v47.annotation.gff3

# Activate your condaa environment with MAJIQ
source /home/s484579/miniforge3/bin/activate majiq_env

# Run MAJIQ build
 majiq build $genome -o $build_dir -c $config_file -j 4 --minreads 2 --min-denovo 2

# Create a subdirectory for each sample
cd $build_dir

# == U2AF2 comparison ===
dpsi_dir=/home/s484579/Masterthesis/MAJIQ/majiq_build_output/U2AF2_deltapsi
majiq deltapsi \
  -grp1 ${build_dir}/U2AF2_control_rep1_dup.majiq ${build_dir}/U2AF2_control_rep2_dup.majiq \
  -grp2 ${build_dir}/shRNA_U2AF2_rep1.Aligned.sortedByCoord.out.majiq ${build_dir}/shRNA_U2AF2_rep2.Aligned.sortedByCoord.out.majiq \
  -j 4 --output-type voila -o $dpsi_dir -n CT_U2AF2 shRNA_U2AF2

voila modulize ${build_dir}/splicegraph.sql \
  /home/s484579/Masterthesis/MAJIQ/majiq_build_output/U2AF2_deltapsi/CT_U2AF2-shRNA_U2AF2.deltapsi.voila \
  --show-all -d ${dpsi_dir}/modulize -j 4

# === SF1 comparison ===
dpsi_dir=/home/s484579/Masterthesis/MAJIQ/majiq_build_output/SF1_deltapsi
majiq deltapsi \
 -grp1 ${build_dir}/U2AF2_SF1_Control_rep1.Aligned.sortedByCoord.out.majiq ${build_dir}/U2AF2_SF1_Control_rep2.Aligned.sortedByCoord.out.majiq \
 -grp2 ${build_dir}/shRNA_SF1_rep1.Aligned.sortedByCoord.out.majiq ${build_dir}/shRNA_SF1_rep2.Aligned.sortedByCoord.out.majiq \
 -j 4 --output-type voila -o $dpsi_dir -n CT_SF1 shRNA_SF1

voila modulize ${build_dir}/splicegraph.sql \
  /home/s484579/Masterthesis/MAJIQ/majiq_build_output/SF1_deltapsi/CT_SF1-shRNA_SF1.deltapsi.voila \
  --show-all -d ${dpsi_dir}/modulize -j 4

# === U2AF1 comparison ===
dpsi_dir=/home/s484579/Masterthesis/MAJIQ/majiq_build_output/U2AF1_deltapsi
majiq deltapsi \
 -grp1 ${build_dir}/U2AF1_control_rep1.Aligned.sortedByCoord.out.majiq ${build_dir}/U2AF1_control_rep2.Aligned.sortedByCoord.out.majiq \
 -grp2 ${build_dir}/shRNA_U2AF1_rep1.Aligned.sortedByCoord.out.majiq ${build_dir}/shRNA_U2AF1_rep2.Aligned.sortedByCoord.out.majiq \
 -j 4 --output-type voila -o $dpsi_dir -n CT_U2AF1 shRNA_U2AF1

voila modulize ${build_dir}/splicegraph.sql \
  /home/s484579/Masterthesis/MAJIQ/majiq_build_output/U2AF1_deltapsi/CT_U2AF1-shRNA_U2AF1.deltapsi.voila \
  --show-all -d ${dpsi_dir}/modulize -j 4