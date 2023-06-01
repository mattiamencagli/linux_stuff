#!/bin/bash

pwd

cp -v definitions_0${1}.hpp definitions.hpp
cp -v pluto_0${1}.ini pluto.ini

case $2 in
	mpi) 
		cp -v DATA_0${1}/makefile_mpicc_acc makefile ;;
	*)
		cp -v DATA_0${1}/makefile_nvc_acc makefile ;;
esac

# find -name "report*" -exec cp {} ~/tests/pluto_tests/nvhpc23.3/ ";"
