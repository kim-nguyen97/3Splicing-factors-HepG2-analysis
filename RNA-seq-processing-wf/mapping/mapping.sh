#!/bin/bash
#SBATCH --partition=cctb
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=16gb
#SBATCH --job-name="STAR"
#SBATCH --nodelist=jupiter
#SBATCH --output=mapping.out
#SBATCH --error=mapping.err
#SBATCH --mail-user=nguyenngocthienkimam@gmail.com
#SBATCH --mail-type=ALL

source ../.env
fasta_path=$PROJECT_DIR/mapping/annotated_genome/GRCh38.primary_assembly.genome.fa
gtf_path=$PROJECT_DIR/mapping/annotated_genome/gencode.v47.annotation.gtf
genomeDir=$PROJECT_DIR/mapping/star_index 
STARout=$PROJECT_DIR/mapping/STARout"
map_file=$PROJECT_DIR/quality_control/Adapter_trimming/formapping_sample"

# Generate genome index 
STAR --runThreadN 8 --runMode genomeGenerate --genomeDir $genomeDir --genomeFastaFiles $fasta_path --sjdbGTFfile $gtf_path

# Map using STAR
cat $PROJECT_DIR/quality_control/Adapter_trimming/formapping_sample | while read i; do 
    j=$(echo "$i"|cut -d, -f1)
    k=$(echo "$i" | cut -d, -f2)   
    l=$(echo "$i" | cut -d, -f3-)  
    STAR --runThreadN 8 \
    --genomeDir $genomeDir \
    --readFilesIn $map_file/$j $map_file/$k \
    --readFilesCommand zcat \
    --outSAMtype BAM SortedByCoordinate \
    --outFilterMultimapNmax 1 \
    --outFilterMismatchNmax 999 \
    --outFilterMismatchNoverLmax 0.04  \
    --outFileNamePrefix $STARout/$l; done

# Index bam files
for i in $STARout/*.bam; do samtools index $i; done