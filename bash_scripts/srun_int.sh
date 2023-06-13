#!/bin/bash

if [ -n "$1" ]; then
	t=$1
else
    t=01:00
fi

echo="ATTENTO! Su alcuni cluster srun non seleziona bene le CPUs"

SRUN="srun --account cin_staff --partition prod --time ${t}:00 --nodes 1 --ntasks-per-node=1 --job-name=PLUTO --pty /bin/bash"

echo $SRUN
eval $SRUN
