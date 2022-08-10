#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=32G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 1 #cpus-per-task
#SBATCH -p hudsonator #queue//another option: virtualmatt
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=01_asmStats
# SJOBNAME=01_asmStats_01_abyss-fac
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
module load abyss/2.2.5-IGB-gcc-8.2.0

# ----------------Set Variables--------------------
NUMCPU=1
TASK=01_asmStats
SJOBNAME=01_asmStats_01_abyss-fac
PROJDIR=/home/labs/hudson_lab/gtomentella
ASM=${PROJDIR}/data/Gtom/Glycine_tomentella.CHROMOSOMES.softMasked.fasta

# ----------------Build DATABASE AND RUN RepeatModeler--------------------

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

abyss-fac ${ASM} > out_abyss_fac.txt 2> err_out_abyss_fac.txt