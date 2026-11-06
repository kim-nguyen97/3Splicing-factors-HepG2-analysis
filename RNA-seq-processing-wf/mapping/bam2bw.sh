#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --job-name=coverage
#SBATCH --output=coverage.out
#SBATCH --error=coverage.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

source ../.env

bam_dir=$PROJECT_DIR/hepG2/mapping/bamFiles_IGV/mybam_IGV
files="$bam_dir/*.bam"
output_dir=$PROJECT_DIR/hepG2/mapping/bamFiles_IGV/mybam_IGV/bw_IGV

cd $bam_dir

# Loop through BAM files
for f in $files; do
  echo "Working on $f"

  # Extract the base name of the input file (without extension)
  sample=$(basename "$f" .bam)

  # Ensure BAM is indexed
  #samtools index "$f"

  bamCoverage \
    -bs 1 \ 
    -b "$f" \
    -o ${output_dir}/${sample}.bw \
    -of "bigwig" \
    --normalizeUsing CPM \
    --numberOfProcessors $SLURM_CPUS_PER_TASK
done

# Set bin size to 1 bp for high-resolution coverage
# Use 'CPM' normalization to account for library size differences
# numberOfProcessors is set to the number of CPUs allocated by SLURM