import os
import serial
import numpy as np
from numpy import log2
import time

for i in range(16):
	ser = serial.Serial('/dev/ttyUSB5', baudrate=115200)
	time.sleep(2)

	print "Opening file", i
	with open("signal"+str(i)+".txt") as f, open("filtered_signal"+str(i)+".txt","w") as out:
	    signal = np.loadtxt(f,dtype=int)

	    for j,sig in enumerate(signal):
			ser.write(chr(sig))
			d= ser.read()
			print "Completed", 100*j//signal.size, "%\r",
			out.write(str(ord(d))+"\n")
	ser.close() # close port
	print "Processed file :", i
