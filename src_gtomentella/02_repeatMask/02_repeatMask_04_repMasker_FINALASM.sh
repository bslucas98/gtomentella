#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=100G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 16 #cpus-per-task
#SBATCH -p hudsonator 
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=02_repeatMask
# SJOBNAME=02_repeatMask_04_repMasker_FINALASM
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
module load RepeatMasker/4.1.1-IGB-gcc-4.9.4-Perl-5.24.1

# ----------------Set Variables--------------------
NUMCPU=4
TASK=02_repeatMask
SJOBNAME=02_repeatMask_04_repMasker_FINALASM
PROJDIR=/home/labs/hudson_lab/gtomentella
ASM=${PROJDIR}/analysis/02_repeatMask/02_repeatMask_03_repModeler_FINALASM/Glycine_tomentella.FINAL_ASM.fasta

MODELER_JOBNAME=02_repeatMask_03_repModeler_FINALASM #jobname of repModeler output used for masking
REP_DIR=RM_2788892.TueMay311115422022 #output dir from RepModeler
DIRMOD=${PROJDIR}/analysis/${TASK}/${MODELER_JOBNAME}/${REP_DIR} #dir containing models
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}

# ----------------RUN RepeatMasker--------------------
mkdir -p ${DIR}
cd ${DIR}

RepeatMasker \
-e ncbi \
-pa ${NUMCPU} \
-gff \
-xsmall -a -inv \
-lib ${DIRMOD}/consensi.fa.classified \
-dir . \
${ASM} > RMask_out.log 2> RMask_err.log