#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --job-name=htseq_count
#SBATCH --output=htseq.out
#SBATCH --error=htseq.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

bam_dir=/home/s484579/Masterthesis/mapping/STARout
files=/home/s484579/Masterthesis/mapping/STARout/*.Aligned.sortedByCoord.out.bam
gtf_file=/home/s484579/Masterthesis/mapping/annotated_genome/gencode.v47.annotation.gtf
output_dir=/home/s484579/Masterthesis/mapping/htseq_counts/count_reverse

cd $bam_dir

# Loop through BAM files
for f in *.Aligned.sortedByCoord.out.bam; do
    n=${f%%.Aligned.sortedByCoord.out.bam}
    htseq-count -f bam -s reverse -t exon -i gene_id -m union "$f" "$gtf_file" > "$output_dir/${n}_htseqcounts.txt"
done