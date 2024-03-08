#!/bin/bash

SALLOC="salloc --account cin_staff --partition boost_usr_prod --qos boost_qos_dbg --time 01:00:00 --nodes 1 --ntasks-per-node=4 --cpus-per-task=8 --gres=gpu:4 --job-name=PLUTO"
echo $SALLOC
eval $SALLOC
