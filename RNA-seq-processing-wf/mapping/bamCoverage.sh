#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16gb
#SBATCH --job-name=bamCoverage
#SBATCH --array=1
#SBATCH --output=bamCoverage.out
#SBATCH --error=bamCoverage.err
#SBATCH --mail-user=sankaran@hhu.de
#SBATCH --mail-type=ALL

source ../.env

path=$PROJECT_DIR/mapping/STARout
files=$PROJECT_DIR/mapping/STARout/*.bam
output_dir=$PROJECT_DIR/mapping/bamCoverage

cd $output_dir

# Process each BAM file
for f in $files; do 
    echo "Working on $f"
# Extract the base name of the input file (without extension)
base_name=$(basename "$f" .bam)

# Define the output file path and name
output_file="$output_dir/$base_name.bw"

# Run bamCoverage with the correct number of processors
bamCoverage -bs 1 --normalizeUsing CPM -b "$f" -o "$output_file" -of "bigwig" --numberOfProcessors $SLURM_CPUS_PER_TASK
done