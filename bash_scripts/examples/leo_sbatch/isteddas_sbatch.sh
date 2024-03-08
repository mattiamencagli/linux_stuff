#!/bin/bash
#SBATCH --account cin_staff
#SBATCH --partition boost_usr_prod
#######SBATCH --qos boost_qos_dbg
#SBATCH --time 01:00:00            # format: HH:MM:SS
#SBATCH --nodes 1
#SBATCH --ntasks-per-node=32       # n tasks out of 32
#SBATCH --cpus-per-task=1    # 4 virtual cpu per task. So I use n physical core
#SBATCH --gres=gpu:4               # 1 gpus per node out of 4
#SBATCH --job-name=ISTEDDAS
#SBATCH --mail-type=NONE
#SBATCH --mail-user=m.mencagli@cineca.it

#export OMPI_MCA_btl="^openib"

## load needed modules on the node
source $HOME/modules_files/isteddas_mod
IST_DIR=$HOME/programming/isteddas

## run setting
NGPUS=4

FILE=$IST_DIR/input/stelle_2048_nobin.dat
MSCALE=1322.380429

TIME=1.0
DT_D=0.125
DT_S=5.0


## run the pluto tests
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ BUILD $NGPUS GPUS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
cd $IST_DIR/build/bin
RUN="mpirun -np $SLURM_NNODES ./isteddas.x  -diagnostic Diagnostic -dt_diag $DT_D -dt_snap $DT_S -integrator Hermite-6th -ioname HDF5_std -mass_scale $MSCALE -max_threads 512 -nsname Neighborscheme_H6 -neigh_max 64 -neighoptimizator ANN_CXX -ngpus $NGPUS -printcols_diag t:DE:e:K:U:DL:vr:IP:NP -printcols_opt  -regularization ARChain -len_scale 1.0 -istars $FILE -tot_time $TIME -tsname BlockTimeSteps -sevn_Mthreshold 3.0"
echo $RUN
eval $RUN

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ BUILD $((${NGPUS}/2)) GPUS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
cd $IST_DIR/build2/bin
RUN="mpirun -np $SLURM_NNODES ./isteddas.x  -diagnostic Diagnostic -dt_diag $DT_D -dt_snap $DT_S -integrator Hermite-6th -ioname HDF5_std -mass_scale $MSCALE -max_threads 512 -nsname Neighborscheme_H6 -neigh_max 64 -neighoptimizator
ANN_CXX -ngpus $((${NGPUS}/2)) -printcols_diag t:DE:e:K:U:DL:vr:IP:NP -printcols_opt  -regularization ARChain -len_scale 1.0 -istars $FILE -tot_time $TIME -tsname BlockTimeSteps -sevn_Mthreshold 3.0"
echo $RUN
eval $RUN

#time make -j -B > makeout_prova 2>&1
#nsys profile --trace=cuda,mpi,nvtx,openacc --force-overwrite true -o report_MHD_highorder_BLAST_B1_gpu4_leo mpirun -np 4 ./pluto
#nsys profile --force-overwrite true -o report_MHD_BLAST_B3_304cube_leo_o2 ./pluto -maxsteps 10 -xres 304
#ncu --target-processes all -k regex:Roe_Solver -f -o NCUreport_MHD_BLAST_B3_304cube_leo ./pluto -maxsteps 2 -xres 304
#mpirun -np 32 ./pluto
