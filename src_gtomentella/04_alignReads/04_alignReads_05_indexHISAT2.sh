#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=40G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 4 #cpus-per-task
#SBATCH -p virtualmatt
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=04_alignReads
# SJOBNAME=04_alignReads_05_indexHISAT2
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

# ----------------Set Variables--------------------
NUMCPU=4 # each thread set in the command line will call for 4 cpus
TASK=04_alignReads
SJOBNAME=04_alignReads_05_indexHISAT2
PROJDIR=/home/labs/hudson_lab/gtomentella
ASM=${PROJDIR}/analysis/02_repeatMask/02_repeatMask_04_repMasker_FINALASM/Glycine_tomentella.FINAL_ASM.fasta.masked

# ----------------Build INDEX--------------------
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

singularity exec ${PROJDIR}/containers/hisat2.sif hisat2-build \
-p ${NUMCPU} \
--large-index ${ASM} \
Gtom_genome_SoftMask \
> out_idxHISAT2.txt  2> err_out_idxHISAT2.txt



