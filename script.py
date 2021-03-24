import os
import serial
import numpy as np
from numpy import log2
import time

def computeQ(y,taps):
    M = max(max(np.abs(taps)),max(np.abs(y)))
    Q = log2(127) - log2(M)
    return Q

def double_to_signed(a, Q):
    int_a = np.round(a*2**Q)
    signed = np.where(int_a >= 0, int_a, int_a + 256).astype(int)
    return signed

def signed_to_double(a,Q):
    signed = np.where(a >= 128, a-256, a)
    double_a = signed*2**(-Q)
    return double_a




ser = serial.Serial('/dev/ttyUSB5', baudrate=115200)


####### CHECK
taps = np.array([0.02856076, 0.14288273, 0.32855651, 0.32855651, 0.14288273, 0.02856076])



with open("signal.txt") as f, open("filtered_signal.txt", "w") as out:
    signal = np.loadtxt(f)
    Q = computeQ(signal,taps)

    for sig in signal:
	#print("Processing : "+str(100*i//signal.size)+"%", end='\r', flush=True)
      
	ser.write(chr(double_to_signed(sig,Q=Q)))
        print(sig)

	
	if(ser.inWaiting()>0):
	       	d = ser.read()
        	res = signed_to_double(ord(d),Q=Q)# * max(signal)
        
		out.write(str(res) + '\n' )
		time.sleep(0.01)
    f.close()
    out.close()
ser.close() # close port

