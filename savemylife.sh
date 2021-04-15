#!/bin/bash

source vivado_activation.sh

for i in `seq 0, 15`; do
	make clean && make && make program_fpga
	python script5.py $i
done