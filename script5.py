
import sys
import os
import serial
import numpy as np
from numpy import log2
import time

ser = serial.Serial('/dev/ttyUSB5', baudrate=115200, timeout=2)
time.sleep(2)




####### CHECK
#taps = np.array([0.02856076, 0.14288273, 0.32855651, 0.32855651, 0.14288273, 0.02856076])

countout=0
count=0
with open("signal"+sys.argv[1]+".txt") as f, open("filtered_signal"+sys.argv[1]+".txt","w") as out:
	signal = np.loadtxt(f,dtype=int)

	for sig in signal:
		check = True
		while check:
			bytes = ser.write(chr(sig))
        		d = ser.read(bytes)
			print(bytes, d)
			check = (len(d)==0)
		count+=1
#		print(count)
		countout+=1
	
		print(ord(d))
		out.write(str(ord(d))+"\n")
	
ser.close() # close port
print count, countout, sys.argv[1]
