#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=240G
#SBATCH -n 1 
#SBATCH -N 1 
#SBATCH -c 18 
#SBATCH -p hudsonator 
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE

# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=
# SJOBNAME=
# PROJDIR=/home/labs/hudson_lab/gtomentella
# XSLURMOUT=${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}
# cd ${PROJDIR}/${USER}/src_gtomentella/${TASK}
# mkdir -p ${XSLURMOUT}
# sbatch \
# --output=${XSLURMOUT}/${SJOBNAME}.out \
# --error=${XSLURMOUT}/${SJOBNAME}.err.out \
# --job-name=${SJOBNAME} \
# ${PROJDIR}/${USER}/src_gtomentella/${TASK}/${SJOBNAME}.sh &> ${PROJDIR}/xslurm_out/${TASK}/${SJOBNAME}/sub_out.txt
###QUEUE job END

# ----------------Load-Modules--------------------
module load singularity/3.4.1

# ----------------Set-Variables--------------------
NUMCPU=18
TASK=
SJOBNAME=
PROJDIR=/home/labs/hudson_lab/gtomentella

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}
