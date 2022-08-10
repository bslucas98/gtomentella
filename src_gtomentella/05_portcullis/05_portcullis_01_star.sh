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
# TASK=05_portcullis
# SJOBNAME=05_portcullis_01_star
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
TASK=05_portcullis
SJOBNAME=05_portcullis_01_star
PROJDIR=/home/labs/hudson_lab/gtomentella
ALGMS_DIR=${PROJDIR}/analysis/04_alignReads/04_alignReads_04_merge
ASM=${PROJDIR}/analysis/02_repeatMask/02_repeatMask_04_repMasker_FINALASM/Glycine_tomentella.FINAL_ASM.fasta.masked

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

singularity exec -B $PWD ${PROJDIR}/containers/portcullis.sif portcullis \
full --threads ${NUMCPU} --verbose --exon_gff --intron_gff \
--output portcullis_out_STAR --orientation FR --strandedness firststrand ${ASM} \
${ALGMS_DIR}/Gtom_allTissues.merged.bam > out_portcullis.txt  2> err_out_portcullis.txt