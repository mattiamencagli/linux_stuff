#!/bin/bash

if [ -n "$1" ]; then
    ver=$1
else
    ver=11.8
fi

dir="/leonardo_scratch/large/userinternal/mmencag1/spack/opt/spack/linux-rhel8-icelake/gcc-8.5.0/nvhpc-23.5-phcjyst3mxjqquncpni2ksmqhhj7j7gu/Linux_x86_64/23.5"

ln -sfn ${dir}/cuda/${ver}/bin ${dir}/cuda/bin
ln -sfn ${dir}/cuda/${ver}/include ${dir}/cuda/include
ln -sfn ${dir}/cuda/${ver}/lib64 ${dir}/cuda/lib64
ln -sfn ${dir}/cuda/${ver}/nvvm ${dir}/cuda/nvvm

ln -sfn ${dir}/comm_lib/${ver}/nccl ${dir}/comm_lib/nccl
ln -sfn ${dir}/comm_lib/${ver}/nvshmem ${dir}/comm_lib/nvshmem

ln -sfn ${dir}/math_libs/${ver}/include ${dir}/math_libs/include
ln -sfn ${dir}/math_libs/${ver}/lib64 ${dir}/math_libs/lib64

