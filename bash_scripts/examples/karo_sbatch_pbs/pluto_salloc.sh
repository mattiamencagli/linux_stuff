#!/bin/bash

SALLOC="salloc --account DD-23-44 --partition qgpu --time 02:00:00 --nodes 1 --ntasks-per-node=128 --gres=gpu:8 --job-name=PLUTO"
echo $SALLOC
eval $SALLOC
