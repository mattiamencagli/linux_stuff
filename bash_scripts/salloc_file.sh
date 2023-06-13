#!/bin/bash

SALLOC="salloc --account cin_staff --partition boost_usr_prod --time 02:00:00 --nodes 1 --ntasks-per-node=4 --cpus-per-task=4 --gres=gpu:4 --job-name=PLUTO"
echo $SALLOC
eval $SALLOC
