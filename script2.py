import os
import serial
import numpy as np
from numpy import log2
import time

ser = serial.Serial('/dev/ttyUSB5', baudrate=115200)
time.sleep(2)




####### CHECK
#taps = np.array([0.02856076, 0.14288273, 0.32855651, 0.32855651, 0.14288273, 0.02856076])

countout=0
count=0
with open("signal2.txt") as f, open("filtered_signal2.txt","w") as out:
    signal = np.loadtxt(f,dtype=int)

    for sig in signal:
	ser.write(chr(sig))
        
	count+=1
	print(count)
	
	d= ser.read()
	countout+=1
	
	print(ord(d))
	out.write(str(ord(d))+"\n")
	
    f.close()
    out.close()
ser.close() # close port
print(count,countout)
