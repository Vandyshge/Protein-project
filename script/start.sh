#!/bin/bash
#SBATCH --no-requeue
#SBATCH --job-name="protein"
#SBATCH --partition=RT
#SBATCH --get-user-env
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --comment="tscm"

TOKEN='5324740648:AAG7UIg5l8XWCQ-XIG_TdowGy8daCKFNIs0'
CHATID='432267327'

#mkdir -p data/log/
#mkdir -p data/rdf/
#mkdir -p data/msd/
#mkdir -p data/dump/
#mkdir -p data/figure/

T0=270
T1=320
step=10

curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHATID} -d text="Started tasks for Temp=($T0, $T1), step=$step"

for (( temp=$T0; temp <= $T1 ; temp=temp+$step ))
do
  sed "s/MyTEMP/$temp/g" /home/common/studtscm06/peptide/input/in.peptide > in.peptide_for_run
  #cat in.peptide_for_run
  srun -N 1 -p RT --ntasks-per-node=4 ~/bin/lmp_mpi -in in.peptide_for_run > /home/common/studtscm06/peptide/data/log/log.lammps_$temp
  rm in.peptide_for_run
  
  curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHATID} -d text="Finished task for T = $temp"
done

rm log.lammps