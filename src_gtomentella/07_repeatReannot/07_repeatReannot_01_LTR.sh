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
# TASK=07_repeatReannot
# SJOBNAME=07_repeatReannot_01_LTR
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
TASK=07_repeatReannot
SJOBNAME=07_repeatReannot_01_LTR
PROJDIR=/home/labs/hudson_lab/gtomentella
GENOME=${PROJDIR}/data/Gtom/Glycine_tomentella.FINAL_ASM.fasta
IDX=Gtom.FINAL_ASM

DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
#mkdir -p ${DIR}
cd ${DIR}

# ----------------Run-LTR_Finder--------------------
# singularity exec -B $PWD ${PROJDIR}/containers/ltr.sif LTR_FINDER_parallel \
# -seq ${GENOME} -threads ${NUMCPU} -harvest_out -size 1000000 -time 300 \
# > out_finder.txt 2> err_out_finder.txt

# mv *.finder.combine.scn ${IDX}.finder.scn

# ----------------Run-LTR_harvest--------------------
# singularity exec -B $PWD ${PROJDIR}/containers/ltr.sif gt suffixerator \
# -db ${GENOME} -indexname ${IDX} -tis -suf -lcp -des -ssp -sds -dna \
# > out_index.txt 2> err_out_index.txt

# singularity exec -B $PWD ${PROJDIR}/containers/ltr.sif gt ltrharvest \
# -index ${IDX} -minlenltr 100 -maxlenltr 7000 -mintsd 4 -maxtsd 6 -motif TGCA \
# -motifmis 1 -similar 85 -vic 10 -seed 20 -seqids yes > ${IDX}.harvest.scn 2> err_out_harvest.txt

# ----------------Run-LTR_Retriever--------------------
mkdir ltr_retriever
cd ltr_retriever
singularity exec -B $PWD ${PROJDIR}/containers/ltr_retriever.sif /LTR_retriever/LTR_retriever \
-genome ${GENOME} -inharvest ../${IDX}.harvest.scn -infinder ../${IDX}.finder.scn -threads ${NUMCPU} \
> out_retriever.txt 2> err_out_retriever.txt
