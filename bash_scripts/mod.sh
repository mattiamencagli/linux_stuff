#!/bin/bash

case $1 in
        2020)
                ver=2020;;
        2021)
                ver=2021;;
        2022)
                ver=2022;;
        *)
                ver=2021;;
esac

module purge
module load python/ hpc-sdk/${ver}--binary
module list
