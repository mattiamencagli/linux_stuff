#!/bin/bash

if [ -n "$1" ]; then
	t=$1
else
	t=02:00
fi

SRUN="srun --account cin_staff --partition boost_usr_prod --time ${t}:00 --nodes 1 --ntasks-per-node=4 --cpus-per-task=4 --gres=gpu:4 --job-name=OPENACC_TEST --pty /bin/bash"
echo $SRUN
eval $SRUN
