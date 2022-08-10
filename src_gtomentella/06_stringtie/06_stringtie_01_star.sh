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
# TASK=06_stringtie
# SJOBNAME=06_stringtie_01_star
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
module load stringtie/2.1.1-IGB-gcc-4.9.4

# ----------------Set-Variables--------------------
NUMCPU=18
TASK=06_stringtie
SJOBNAME=06_stringtie_01_star
PROJDIR=/home/labs/hudson_lab/gtomentella
BAM=${PROJDIR}/analysis/05_portcullis/05_portcullis_02_bamfilt/Gtom_allTissues.merged.filt.bam

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

stringtie \
${BAM} \
-j 5 --rf -p ${NUMCPU} -v \
-o Gtom_Alltissues_stringtieTranscripts.gtf > out_stingtie.txt 2> err_out_stingtie.txt
