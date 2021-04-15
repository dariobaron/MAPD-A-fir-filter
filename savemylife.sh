#!/bin/bash

set -v

source vivado_activation.sh

for i in `seq 0 15`; do
	make clean && make && make program_fpga
	sleep 10
	python script5.py $i
	sleep 10
done
