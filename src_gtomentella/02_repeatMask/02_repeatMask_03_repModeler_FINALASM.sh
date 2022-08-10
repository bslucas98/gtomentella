#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=80G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 16 #cpus-per-task
#SBATCH -p hudsonator 
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=02_repeatMask
# SJOBNAME=02_repeatMask_03_repModeler_FINALASM
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
module load RepeatModeler/2.0.2a-IGB-gcc-4.9.4-Perl-5.24.1 

# ----------------Set Variables--------------------
NUMCPU=4 # each thread set in the command line will call for 4 cpus
TASK=02_repeatMask
SJOBNAME=02_repeatMask_03_repModeler_FINALASM
PROJDIR=/home/labs/hudson_lab/gtomentella
ASM=${PROJDIR}/data/Gtom/Glycine_tomentella.FINAL_ASM.fasta

# ----------------Build DATABASE AND RUN RepeatModeler/Masker--------------------

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

BuildDatabase \
-name "gtom_FINALASM" \
-engine ncbi ${ASM} > out_BuildDB.txt 2> err_out_BuildDB.txt

RepeatModeler \
-database ${DIR}/gtom_FINALASM \
-engine ncbi \
-LTRStruct -pa ${NUMCPU} > RMOD_out.log 2> RMOD_err.log

