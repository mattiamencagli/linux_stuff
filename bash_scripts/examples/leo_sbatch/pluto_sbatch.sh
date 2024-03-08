#!/bin/bash
#SBATCH --account cin_staff
#SBATCH --partition boost_usr_prod
###########SBATCH --qos boost_qos_bprod
#SBATCH --time 12:00:00            # format: HH:MM:SS
#SBATCH --nodes 32
#SBATCH --ntasks-per-node=4       # n tasks out of 32
#SBATCH --cpus-per-task=8    # 4 virtual cpu per task. So I use n physical core
#SBATCH --gres=gpu:4               # 1 gpus per node out of 4
#SBATCH --job-name=PLUTO
#SBATCH --mail-type=NONE
#SBATCH --mail-user=m.mencagli@cineca.it

## load needed modules on the node
source ${HOME}/modules_files/pluto_mod 23.11

## print GPUs node information
nvidia-smi

## run the pluto tests
#cd gpluto_cpp/
#python3 test_pluto.py --auto-update 
#time python3 test_pluto.py --start-from 0:0 


## custom run
#module purge
#module load openmpi/4.1.4--gcc--11.3.0-cuda-11.8
#ml

#cd ${HOME}/programming/gpluto_cpp/Test_Problems/MHD/Blast
#pluto_select 3  #build number + mpi
#time make -j -B > makeout_prova 2>&1
#nsys profile --trace=cuda,mpi,nvtx,openacc --force-overwrite true -o report_MHD_highorder_BLAST_B1_gpu4_leo mpirun -np 4 ./pluto
#nsys profile --force-overwrite true -o report_MHD_BLAST_B3_304cube_leo_o2 ./pluto -maxsteps 10 -xres 304
#ncu --target-processes all -k regex:Particles_LP_UpdateSpectra_325 --set=full --import-source=yes --launch-count 1 --launch-skip 100 -f -o NCUreport_MM_leo ./pluto -xres 304

#cd /leonardo_work/cin_staff/mmencag1/gpluto_cpp/Test_Problems/MHD/Blast
#cd ${HOME}/programming/gpluto_cpp/Test_Problems/MHD/Blast
cd ${HOME}/programming/gpluto_cpp/Test_Problems/ResRMHD/Kelvin_Helmholtz
#cd ${HOME}/programming/gpluto_cpp_particles/buildi
#cd ${HOME}/programming/gpluto_cpp/Test_Problems/MHD/Orszag_Tang
#cd /leonardo_scratch/large/userinternal/mmencag1/new_test_marco/first_gpluto/gpluto_cpp/Test_Problems/MHD/Orszag_Tang
pwd

#make -j -B > makeout_prova 2>&1
#nsys profile --trace=cuda,mpi,nvtx,openacc --force-overwrite true -o report_nsys_MM_leo ./pluto
#ncu --target-processes all -k regex:Particles_LP_UpdateSpectra_323 --set=full --import-source=yes --launch-count 1 --launch-skip 194 -f true -o NCUreport_MM2_leo "./pluto" -no-write
#ncu --kernel-name Particles_LP_UpdateSpectra_323 --set=full --import-source=yes --launch-skip 194 --launch-count 1 "./pluto" -no-write
#./pluto -no-write



cp -v pluto_small.ini pluto.ini
dir1=$(tail pluto.ini -n 12 | head -n 1 | awk '{print $2}')
mkdir -v ${dir1}
cp -v pluto.ini ${dir1}
make -j -B > ${dir1}makeout_prova 2>&1
mpirun -np 128 ./pluto
cp *.dat ${dir1}

cp -v pluto_medium.ini pluto.ini
dir2=$(tail pluto.ini -n 12 | head -n 1 | awk '{print $2}')
mkdir -v ${dir2}
cp -v pluto.ini ${dir2}
make -j -B > ${dir2}makeout_prova 2>&1
mpirun -np 128 ./pluto
cp *.dat ${dir2}



#dir=/leonardo_scratch/large/userinternal/mmencag1/test_256_512_256_new_rk2/
#mkdir -v ${dir}
#cp -v pluto_medium.ini pluto.ini
#cp -v pluto.ini ${dir}
#make -j -B > ${dir}makeout_prova 2>&1
#mpirun -np 128 ./pluto
#cp *.dat ${dir}


#nsys profile --trace=cuda,mpi,nvtx,openacc -f true -o report_leo_ResMHD_KH mpirun -np 4 ./pluto -maxsteps 5
#mpirun -np 256 nsys profile --trace=cuda,mpi,nvtx,openacc ./pluto -maxsteps 5
#mv pluto.0.log plutolog_nccl_test2
#mpirun -np 4 nsys profile --trace=cuda,openacc,mpi,nvtx ./pluto -maxsteps 10
#mv pluto.0.log plutolog_nccl_test4


