#!/bin/bash
### innanzitutto: PORCODDIO PBS
#PBS -A DD-23-44
#PBS -q qgpu
#PBS -l select=1
##PBS -l select=1:cores=1
#PBS -l walltime=00:20:00
#PBS -N PLUTO
#PBS -m n
#PBS -M m.mencagli@cineca.it

## load modules
source ${HOME}/modules_files/pluto_mod

## print gpu info
nvidia-smi

## run the pluto tests
cd gpluto_cpp/
python3 test_pluto.py --auto-update
python3 test_pluto.py --start-from 0:0

## run custom
#cd Test_Problems/HD/Sod
# kernel launches and data transfers (check https://juser.fz-juelich.de/record/902543/files/3-Debugging--TH.pdf)
#NV_ACC_NOTIFY=3 ./pluto
