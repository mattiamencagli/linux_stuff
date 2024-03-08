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
TIME=10.0
DT_D=0.125
DT_S=100.0 #NO SNAPSHOOTS (quindi questo non serve)

## NGPUS = 1 2 4 8 
## NSTARS = 2048 4096 8192 16384 32768 65536 131072 262144 

## run the pluto tests
for NG in 1; do
	for NS in 2048; do

		mkdir -p $IST_DIR/build_gpu${NG}_stars$NS
		cd $IST_DIR/build_gpu${NG}_stars$NS
		rm * -rf
		cmake .. > CMAKEOUT.out 2>&1
		make -j -B > MAKEOUT.out 2>&1
		cd $IST_DIR/build_gpu${NG}_stars$NS/bin
		
		SOUT=IO_standard
		NN=$(($NG/4))
		if [ $NN -eq 0 ]; then
			SOUT=HDF5_std
			NN=1
		fi
		
		NGn=$NG
		if [ $NG -gt 4 ]; then
			NGn=4
		fi

		FILE=$IST_DIR/input/stelle_${NS}_nobin.dat
		MSCALE=$(awk -v ns=_$NS '{ if($1==ns) print $2 }' $HOME/sbatch_files/.mscale.txt)

		RUN="mpirun -np $NN ./isteddas.x -diagnostic Diagnostic -dt_diag $DT_D -dt_snap $DT_S -NO_snap 1 -integrator Hermite-6th -ioname $SOUT -mass_scale $MSCALE -max_threads 512 -nsname Neighborscheme_H6 -neigh_max 64 -neighoptimizator ANN_CXX -ngpus $NGn -printcols_diag t:DE:e:K:U:DL:vr:IP:NP -printcols_opt -regularization ARChain -len_scale 1.0 -istars $FILE -tot_time $TIME -tsname BlockTimeSteps -sevn_Mthreshold 3.0"
	
		echo " *** --- ######################################################## --- ***"
		echo "          NG=$NG  ;  NS=$NS  ;  NN=$NN  ;  MSCALE=$MSCALE"
		echo " *** --- ######################################################## --- ***"	
		echo $RUN
		eval $RUN

	done
done

