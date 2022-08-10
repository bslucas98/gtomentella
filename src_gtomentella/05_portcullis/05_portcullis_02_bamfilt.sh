#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=100G
#SBATCH -n 1 
#SBATCH -N 1 
#SBATCH -c 1
#SBATCH -p hudsonator 
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE

# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=05_portcullis
# SJOBNAME=05_portcullis_02_bamfilt
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
TASK=05_portcullis
SJOBNAME=05_portcullis_02_bamfilt
PROJDIR=/home/labs/hudson_lab/gtomentella
JUNCTIONS=${PROJDIR}/analysis/${TASK}/05_portcullis_01_star/portcullis_out_STAR/3-filt/portcullis_filtered.pass.junctions.tab
ALGMS_DIR=${PROJDIR}/analysis/04_alignReads/04_alignReads_04_merge

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

singularity exec -B $PWD ${PROJDIR}/containers/portcullis.sif portcullis \
bamfilt --verbose \
--output Gtom_allTissues.merged.filt.bam \
${JUNCTIONS} \
${ALGMS_DIR}/Gtom_allTissues.merged.bam > out_filtering.txt  2> err_out_filtering.txt