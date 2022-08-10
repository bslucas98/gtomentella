#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=240G
#SBATCH -n 1 
#SBATCH -N 1 
#SBATCH -c 18 
#SBATCH -p hudsonator 
#SBATCH --mail-user=kcs123@illinois.edu
#SBATCH --mail-type=NONE
#SBATCH --array=1-3,5-8%7
# ----------------SLURM Parameters END----------------

###QUEUE job

#task=task_11_portcullis
#cd /home/labs/hudson_lab/scn_pan_genome/src_scn_pan_genome/${task}
#sjobname=11_portcullis_01_star
#xslurmout=/home/labs/hudson_lab/scn_pan_genome/xslurm_out/${task}/${sjobname}
#mkdir -p ${xslurmout}
#sbatch \
#--output=${xslurmout}/${sjobname}.%j.out \
#--error=${xslurmout}/${sjobname}.%j.err.out \
#--job-name=${sjobname} \
#/home/labs/hudson_lab/scn_pan_genome/src_scn_pan_genome/${task}/${sjobname}.sh &> /home/labs/hudson_lab/scn_pan_genome/xslurm_out/${task}/${sjobname}/sub_out.txt

###QUEUE job END

# ----------------Load-Modules--------------------
module purge 
module load singularity/3.4.1
# ----------------Set-Variables--------------------
NUMCPU=18
TASK=task_11_portcullis
SJOBNAME=11_portcullis_01_star
ASM_NAME=$(sed -n -e "${SLURM_ARRAY_TASK_ID} p" /home/labs/hudson_lab/scn_pan_genome/src_scn_pan_genome/data_src/lists/list_asm_chrom_wUn_ed.txt | cut -d '.' -f1)

DIR=/home/labs/hudson_lab/scn_pan_genome/analysis/${TASK}/${SJOBNAME}/${ASM_NAME}
mkdir -p ${DIR}
cd ${DIR}

#ln -s /home/labs/hudson_lab/scn_pan_genome/analysis/task_04_align_ilmn_rna/04_align_ilmn_rna_04_trimmed_sort_merge/${ASM_NAME}/merged_${ASM_NAME}.bam ./merged_${ASM_NAME}.bam
#ln -s /home/labs/hudson_lab/scn_pan_genome/analysis/task_04_align_ilmn_rna/04_align_ilmn_rna_04_trimmed_sort_merge/${ASM_NAME}/merged_${ASM_NAME}.bam.bai ./merged_${ASM_NAME}.bam.bai

GENOME_DIR=/home/labs/hudson_lab/scn_pan_genome/data/asm/asm_chr_wUn
ln -s ${GENOME_DIR}/${ASM_NAME}.fasta ./${ASM_NAME}.fasta

singularity exec -B $PWD /home/labs/hudson_lab/scn_pan_genome/containers/portcullis.sif portcullis \
full --threads ${NUMCPU} --verbose --exon_gff --intron_gff \
--output portcullis_out_STAR_${ASM_NAME} --orientation RF --strandedness firststrand \
./${ASM_NAME}.fasta \
/home/labs/hudson_lab/scn_pan_genome/analysis/task_04_align_ilmn_rna/04_align_ilmn_rna_04_trimmed_sort_merge/${ASM_NAME}/merged_${ASM_NAME}.bam > out_portcullis.txt  2> err_out_portcullis.txt