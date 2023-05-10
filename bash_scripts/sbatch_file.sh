#!/bin/bash
#SBATCH --account cin_staff
#SBATCH --partition prod
##SBATCH --qos=leo_qos_dbg
#SBATCH --time 00:20:00     # format: HH:MM:SS
#SBATCH --nodes 1                # 1 node
#SBATCH --ntasks-per-node=1 # 8 tasks out of 128
##SBATCH --gres=gpu:1        # 1 gpus per node out of 4
#SBATCH --job-name=PLUTO
#SBATCH --mail-type=NONE
#SBATCH --mail-user=m.mencagli@cineca.it

## load needed modules on the node
source ${HOME}/modules_files/pluto_mod

## print GPUs node information
nvidia-smi

## run the pluto tests
cd gpluto_cpp/
python3 test_pluto.py --auto-update
python3 test_pluto.py --start-from 0:0
