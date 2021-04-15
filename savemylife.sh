#!/bin/bash

set -v

source vivado_activation.sh

make clean && make && make program_fpga
sleep 20

for i in `seq 0 15`; do
#	make clean && make && make program_fpga
	sleep 20
	python script5.py $i
	sleep 20
done
