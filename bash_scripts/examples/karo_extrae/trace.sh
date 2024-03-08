#!/bin/bash

source /mnt/proj3/dd-23-44/pop-tools/tools-karolina-openmpi-4.1.4-gcc12/install/EXTRAE/4.0.4/etc/extrae.sh

export EXTRAE_CONFIG_FILE=../extrae.xml
#export LD_PRELOAD=${EXTRAE_HOME}/lib/libmpitrace.so # For C apps
export LD_PRELOAD=${EXTRAE_HOME}/lib/libmpitracef.so # For Fortran apps

## Run the desired program
$*

