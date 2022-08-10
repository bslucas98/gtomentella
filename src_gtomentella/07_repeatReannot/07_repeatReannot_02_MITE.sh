#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=90G
#SBATCH -n 1 
#SBATCH -N 1 
#SBATCH -c 3
#SBATCH -p hudsonator 
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE

# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=07_repeatReannot
# SJOBNAME=07_repeatReannot_02_MITE
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
NUMCPU=3
TASK=07_repeatReannot
SJOBNAME=07_repeatReannot_02_MITE
PROJDIR=/home/labs/hudson_lab/gtomentella
GENOME=${PROJDIR}/data/Gtom/Glycine_tomentella.FINAL_ASM.fasta

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}
mkdir results
cd results
mkdir 07_repeatReannot_02_MITE
touch 07_repeatReannot_02_MITE/out.log
cd ..

# ----------------Run-MITE_Tracker--------------------
singularity exec -B $PWD/results:/usr/MITE-Tracker/results ${PROJDIR}/containers/mite_track.sif python3.8 /usr/MITE-Tracker/MITETracker.py \
-g ${GENOME} -j ${SJOBNAME} -w 3 > out_mite.txt 2> err_out_mite.txt