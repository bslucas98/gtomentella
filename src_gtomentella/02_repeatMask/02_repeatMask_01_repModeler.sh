#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=400G
#SBATCH -n 40 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 1 #cpus-per-task
#SBATCH -p hudsonator 
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
module load RepeatModeler/2.0.2a-IGB-gcc-4.9.4-Perl-5.24.1 
module load RepeatMasker/4.1.1-IGB-gcc-4.9.4-Perl-5.24.1

# ----------------Set Variables--------------------
NUMCPU=1
TASK=02_repeatMask
SJOBNAME=02_repeatMask_01_repModeler
PROJDIR=/home/labs/hudson_lab/gtomentella
ASM=${PROJDIR}/data/Gtom/Glycine_tomentella.CHROMOSOMES.fasta

# ----------------Build DATABASE AND RUN RepeatModeler/Masker--------------------

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

BuildDatabase -name "gtom" -engine rmblast ${ASM} > out_BuildDB.txt 2> err_out_BuildDB.txt

RepeatModeler -database ${DIR}/gtom -pa 10 > out_RepMod.txt 2> err_out_RepMod.txt

