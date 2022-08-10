#!/bin/bash

### OBS: sample 5_Pods requires a huge amount of memory (~350 Gb).\
### This code was initiated for the first 4 samples (PID-9486338) and\
### and finished for the remaining samples (PID-9507144) with more memory

# ----------------SLURM Parameters----------------
#SBATCH --mem=450G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 12 #cpus-per-task
#SBATCH -p virtualmatt
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
#SBATCH --array=1-4%1
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=04_alignReads
# SJOBNAME=04_alignReads_06_HISAT2
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
NUMCPU=12
TASK=04_alignReads
SJOBNAME=04_alignReads_06_HISAT2
PROJDIR=/home/labs/hudson_lab/gtomentella

LIB=$(sed -n -e "${SLURM_ARRAY_TASK_ID} p"  /home/labs/hudson_lab/gtomentella/lucasb/data/list_Gtom_RNAseq_5to8.txt)
LIB_renamed=$(sed -n -e "${SLURM_ARRAY_TASK_ID} p"  /home/labs/hudson_lab/gtomentella/lucasb/data/list_Gtom_RNAseq_5to8.txt | cut -d "_" -f1,2)

ASM=${PROJDIR}/analysis/02_repeatMask/02_repeatMask_04_repMasker_FINALASM/Glycine_tomentella.FINAL_ASM.fasta.masked
IDX_DIR=${PROJDIR}/analysis/04_alignReads/04_alignReads_05_indexHISAT2
FW_READS=${PROJDIR}/analysis/03_trimRNAseq/03_trimRNAseq_01_galore/${LIB}_R1_001_val_1.fq.gz
RV_READS=${PROJDIR}/analysis/03_trimRNAseq/03_trimRNAseq_01_galore/${LIB}_R2_001_val_2.fq.gz

# ----------------Run HISAT2--------------------
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}/${LIB_renamed}
mkdir -p ${DIR}
cd ${DIR}

singularity exec ${PROJDIR}/containers/hisat2.sif hisat2 \
-p ${NUMCPU} \
--time \
--sensitive \
-x ${IDX_DIR}/Gtom_genome_SoftMask \
-1 ${FW_READS} \
-2 ${RV_READS} \
-S ${LIB_renamed}_AlignedHISAT.sam \
> out_HISAT_${LIB_renamed}.txt 2> err_out_HISAT_${LIB_renamed}.txt



