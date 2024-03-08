#!/bin/bash
#SBATCH --account cin_staff
#SBATCH --partition boost_usr_prod
#######SBATCH --qos boost_qos_dbg
#######SBATCH --qos boost_qos_bprod
#SBATCH --time 1:00:00            # format: HH:MM:SS
#SBATCH --nodes 64
#SBATCH --ntasks-per-node=4        # n tasks out of 32
#SBATCH --cpus-per-task=8          # 8 virtual cpu per task. So I use n physical core
#SBATCH --gres=gpu:4               # 1 gpus per node out of 4
#SBATCH --job-name=PLUTO_s
#SBATCH --mail-type=NONE
#SBATCH --mail-user=m.mencagli@cineca.it

## load needed modules on the node
source ${HOME}/modules_files/pluto_mod 23.11

## print GPUs node information
nvidia-smi

cd ${HOME}/programming/gpluto_cpp/Test_Problems/MHD/Blast
pwd

# se funge bene magari poi fatti anche 2 4 8 16 32
range=(64) 

cp -v ${HOME}/programming/gpluto_cpp/Src/main_nccl_mattia.cpp ${HOME}/programming/gpluto_cpp/Src/main.cpp
make -j -B > makeout_nccl 2>&1
for NN in "${range[@]}"; do 
	NG=$(( ${NN} * 4 ))
	echo "NCCL test with ${NG} GPUs"
	#nsys profile --trace=cuda,mpi,nvtx,openacc --force-overwrite true -o report_MHDBLAST_B3_640_nccl_${NG}GPUS_leo mpirun -np ${NG} ./pluto -maxsteps 100
	mpirun -np ${NG} nsys profile --trace=cuda,mpi,nvtx,openacc ./pluto -maxsteps 100
	cp -v pluto.0.log plutolog_nccl_${NG}
	cp -v report1.nsys-rep ../report_MHDBLAST_B3_2560_nccl_${NG}GPUS_leo.nsys-rep
	rm -v report*
done


cp -v ${HOME}/programming/gpluto_cpp/Src/main_mpi_mattia.cpp ${HOME}/programming/gpluto_cpp/Src/main.cpp
make -j -B > makeout_mpi 2>&1
for NN in "${range[@]}"; do 
	NG=$(( ${NN} * 4 ))
	echo "OPENMPI test with ${NG} GPUs"
	#nsys profile --trace=cuda,mpi,nvtx,openacc --force-overwrite true -o report_MHDBLAST_B3_640_mpi_${NG}GPUS_leo mpirun -np ${NG} ./pluto -maxsteps 100
	mpirun -np ${NG} nsys profile --trace=cuda,mpi,nvtx,openacc ./pluto -maxsteps 100
	cp -v pluto.0.log plutolog_mpi_${NG}
	cp -v report1.nsys-rep ../report_MHDBLAST_B3_2560_mpi_${NG}GPUS_leo.nsys-rep
	rm -v report*
done


cp -v ${HOME}/programming/gpluto_cpp/Src/main_nccl_mattia.cpp ${HOME}/programming/gpluto_cpp/Src/main.cpp
