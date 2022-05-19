#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=10G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 1 #cpus-per-task
#SBATCH -p virtualmatt
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

##QUEUE job
# TASK=data
# SJOBNAME=data_01_checkSums
# PROJDIR=/home/labs/hudson_lab/gtomentella
# XSLURMOUT=${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}

# cd ${PROJDIR}/${USER}/src_gtomentella/${TASK}
# mkdir -p ${XSLURMOUT}
# sbatch \
# --output=${XSLURMOUT}/${SJOBNAME}.%j.out \
# --error=${XSLURMOUT}/${SJOBNAME}.%j.err.out \
# --job-name=${SJOBNAME} \
# ${PROJDIR}/${USER}/src_gtomentella/${TASK}/${SJOBNAME}.sh &> ${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}/sub_out.txt
##QUEUE job END


TASK=data
SJOBNAME=data_01_checkSums
PROJDIR=/home/labs/hudson_lab/gtomentella
DIR=${PROJDIR}/data/

cd ${DIR}
md5sum -c ./Gtom.md5 > ./ckE_Gtom.md5.txt