#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=100G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 20 #cpus-per-task
#SBATCH -p hudsonator 
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

###QUEUE job
TASK=02_repeatMask
SJOBNAME=02_repeatMask_02_repMasker
PROJDIR=/home/labs/hudson_lab/gtomentella
XSLURMOUT=${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}

cd ${PROJDIR}/${USER}/src_gtomentella/${TASK}
mkdir -p ${XSLURMOUT}
sbatch \
--dependency=afterany:9307239 \
--output=${XSLURMOUT}/${SJOBNAME}.%j.out \
--error=${XSLURMOUT}/${SJOBNAME}.%j.err.out \
--job-name=${SJOBNAME} \
${PROJDIR}/${USER}/src_gtomentella/${TASK}/${SJOBNAME}.sh &> ${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}/sub_out.txt
###QUEUE job END

# ----------------Load Modules--------------------
module load RepeatMasker/4.1.1-IGB-gcc-4.9.4-Perl-5.24.1

# ----------------Set Variables--------------------
NUMCPU=1
TASK=02_repeatMask
SJOBNAME=02_repeatMask_02_repMasker
PROJDIR=/home/labs/hudson_lab/gtomentella
ASM=${PROJDIR}/data/Gtom/Glycine_tomentella.CHROMOSOMES.fasta

# ----------------RUN RepeatMasker--------------------

REP_DIR=RM_2568107.WedMay182023152022
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}
DIRMOD=${DIR}/${REP_DIR}

RepeatMasker -e rmblast \
-pa 5 \
-gff \
-xsmall \
-lib ${DIRMOD}/consensi.fa.classified \
-dir ${DIR}/ \
${ASM} > out_${SJOBNAME}.log 2> err_${SJOBNAME}.log