#!/bin/bash

# ----------------SLURM Parameters----------------
#SBATCH --mem=80G
#SBATCH -n 1 #process/task
#SBATCH -N 1 #nodes
#SBATCH -c 8 #cpus-per-task
#SBATCH -p virtualmatt
#SBATCH --mail-user=lucasb@illinois.edu
#SBATCH --mail-type=NONE
# ----------------SLURM Parameters END----------------

###QUEUE job
# TASK=04_alignReads
# SJOBNAME=04_alignReads_08_mergeHISAT
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

# ----------------Set Variables--------------------
NUMCPU=8
TASK=04_alignReads
SJOBNAME=04_alignReads_08_mergeHISAT
PROJDIR=/home/labs/hudson_lab/gtomentella

ASM=${PROJDIR}/analysis/02_repeatMask/02_repeatMask_04_repMasker_FINALASM/Glycine_tomentella.FINAL_ASM.fasta.masked

# ----------------Run Code--------------------
DIR=${PROJDIR}/analysis/${TASK}/${SJOBNAME}
mkdir -p ${DIR}
cd ${DIR}

ls -1 ${PROJDIR}/analysis/${TASK}/04_alignReads_07_sortHISAT/{1_Leaves,2_Shoots,3_Stems,4_Flowers,5_Pods,6_Roots,7_Senesce,8_Crown}/sorted_* > list_SortedBAM_gtom_tissues.txt

singularity exec ${PROJDIR}/containers/samtools_1.15.sif samtools merge \
-@ ${NUMCPU} \
--reference ${ASM} \
-o Gtom_allTissues_HISAT2.merged.bam \
--output-fmt BAM \
-b list_SortedBAM_gtom_tissues.txt \
> out_merge.txt 2> err_out_merge.txt

singularity exec ${PROJDIR}/containers/samtools_1.15.sif samtools index \
Gtom_allTissues_HISAT2.merged.bam > out_mergeidx.txt 2> err_out_mergeidx.txt


