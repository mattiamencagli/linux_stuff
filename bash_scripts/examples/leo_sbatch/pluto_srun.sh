#!/bin/bash

echo "ATTENTO! a volte su m100 usando srun dava problemi strani con l'allocazione delle risorse CPU, potrebbe esserci lo stesso problema qui..."

if [ -n "$1" ]; then
	t=$1
else
	t=02:00
fi

SRUN="srun --account cin_staff --partition boost_usr_prod --time ${t}:00 --nodes 1 --ntasks-per-node=4 --cpus-per-task=8 --gres=gpu:4 --job-name=PLUTO --pty /bin/bash"
echo $SRUN
eval $SRUN
