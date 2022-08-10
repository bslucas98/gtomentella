#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=128G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 8 #cpus-per-task
#SBATCH -p virtualmatt
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
#SBATCH --array=1-8%1
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=04_alignReads
# SJOBNAME=04_alignReads_07_sortHISAT
# PROJDIR=/home/labs/hudson_lab/gtomentella
# XSLURMOUT=${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}
# cd ${PROJDIR}/${USER}/src_gtomentella/${TASK}
# mkdir -p ${XSLURMOUT}
# sbatch \
# --output=${XSLURMOUT}/${SJOBNAME}.%j.out \
# --error=${XSLURMOUT}/${SJOBNAME}.%j.err.out \
# --job-name=${SJOBNAME} \
# ${PROJDIR}/${USER}/src_gtomentella/${TASK}/${SJOBNAME}.sh &> ${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}/sub_out.txt
###QUEUE job END

# ----------------Load Modules--------------------

# ----------------Set Variables--------------------
NUMCPU=8
TASK=04_alignReads
SJOBNAME=04_alignReads_07_sortHISAT
PROJDIR=/home/labs/hudson_lab/gtomentella

LIB_renamed=$(sed -n -e "${SLURM_ARRAY_TASK_ID} p"  /home/labs/hudson_lab/gtomentella/lucasb/data/list_Gtom_RNAseq.txt | cut -d "_" -f1,2)

ASM=${PROJDIR}/analysis/02_repeatMask/02_repeatMask_04_repMasker_FINALASM/Glycine_tomentella.FINAL_ASM.fasta.masked
PREV_JOBNAME=${PROJDIR}/analysis/${TASK}/04_alignReads_06_HISAT2/${LIB_renamed}

# ----------------Run SAMTOOLS--------------------
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}/${LIB_renamed}
mkdir -p ${DIR}
cd ${DIR}

singularity exec ${PROJDIR}/containers/samtools_1.15.sif samtools view \
-b \
-@ ${NUMCPU} \
-o ${LIB_renamed}_AlignedHISAT.bam \
${PREV_JOBNAME}/${LIB_renamed}_AlignedHISAT.sam \
> out_view.txt 2> err_out_view.txt

singularity exec ${PROJDIR}/containers/samtools_1.15.sif samtools sort \
-@ ${NUMCPU} \
-m 15G \
--reference ${ASM} \
-o ./sorted_${LIB_renamed}_AlignedHISAT.bam \
--output-fmt BAM \
${LIB_renamed}_AlignedHISAT.bam > out_sort.txt 2> err_out_sort.txt

singularity exec ${PROJDIR}/containers/samtools_1.15.sif samtools index \
orted_${LIB_renamed}_AlignedHISAT.bam \
> out_index.txt 2> err_out_index.txt

