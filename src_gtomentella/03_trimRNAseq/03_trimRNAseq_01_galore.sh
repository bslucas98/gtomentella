#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=40G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 4 #cpus-per-task
#SBATCH -p hudsonator 
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=03_trimRNAseq
# SJOBNAME=03_trimRNAseq_01_galore
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
module load Trim_Galore/0.6.5-IGB-gcc-4.9.4

# ----------------Set Variables--------------------
NUMCPU=4 
TASK=03_trimRNAseq
SJOBNAME=03_trimRNAseq_01_galore
PROJDIR=/home/labs/hudson_lab/gtomentella

FQDIR=${PROJDIR}/data/Gtom/RNAseq_data/raw_seqs
SAMPLELIST=/home/labs/hudson_lab/gtomentella/lucasb/data/list_Gtom_RNAseq.txt

# ----------------Run Command--------------------
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

while read SAMPLE; do
    trim_galore \
    --gzip \
    --fastqc \
    --retain_unpaired \
    --cores ${NUMCPU} \
    --paired ${FQDIR}/${SAMPLE}_R1_001.fastq.gz ${FQDIR}/${SAMPLE}_R2_001.fastq.gz &> out_${SAMPLE}.txt
done < ${SAMPLELIST}
