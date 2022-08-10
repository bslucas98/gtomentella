#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=80G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 20 #cpus-per-task
#SBATCH -p virtualmatt
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
#SBATCH --array=1-8%1
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=04_alignReads
# SJOBNAME=04_alignReads_02_STAR
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
NUMCPU=20
TASK=04_alignReads
SJOBNAME=04_alignReads_02_STAR
PROJDIR=/home/labs/hudson_lab/gtomentella
LIB=$(sed -n -e "${SLURM_ARRAY_TASK_ID} p"  /home/labs/hudson_lab/gtomentella/lucasb/data/list_Gtom_RNAseq.txt)

STAR_IDX_DIR=${PROJDIR}/analysis/04_alignReads/04_alignReads_01_indexSTAR
FW_READS=${PROJDIR}/analysis/03_trimRNAseq/03_trimRNAseq_01_galore/${LIB}_R1_001_val_1.fq.gz
RV_READS=${PROJDIR}/analysis/03_trimRNAseq/03_trimRNAseq_01_galore/${LIB}_R2_001_val_2.fq.gz

# ----------------Run STAR--------------------
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}/${LIB}
mkdir -p ${DIR}
cd ${DIR}

singularity exec ${PROJDIR}/containers/star.sif STAR \
--runMode alignReads \
--twopassMode Basic \
--twopass1readsN -1 \
--sjdbOverhang 249 \
--readFilesCommand zcat \
--outSAMtype BAM Unsorted \
--genomeDir ${STAR_IDX_DIR} \
--readFilesIn ${FW_READS} ${RV_READS} \
--runThreadN ${NUMCPU} \
--outFileNamePrefix ${LIB} \
> out_STAR_${LIB}.txt  2> err_out_STAR_${LIB}.txt
