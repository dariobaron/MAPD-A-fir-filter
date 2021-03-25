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
    int_a = int(a*2**Q)
    signed =0
    if int_a >= 0: signed = int_a
    if int_a <0: signed= int_a + 256
    return signed

def signed_to_double(a,Q):
    signed=0
    if a>= 128 : signed = a-256
    if a<128 : signed = a

    double_a = signed*2**(-Q)
    return double_a




ser = serial.Serial('/dev/ttyUSB5', baudrate=115200)
time.sleep(4)

ser.reset_input_buffer()
ser.reset_output_buffer()

####### CHECK
taps = np.array([0.02856076, 0.14288273, 0.32855651, 0.32855651, 0.14288273, 0.02856076])

countout=0
count=0
with open("signal.txt") as f, open("filtered_signal2.txt","w") as out:
    signal = np.loadtxt(f)
    Q = computeQ(signal,taps)

    for sig in signal:
	input = (double_to_signed(sig,Q=Q))
	ser.write(chr(input))
        
	count+=1
	print(count)
	time.sleep(0.8)
    
	if(ser.in_waiting>0):
	#print(ser.in_waiting)	
		d= ser.read(1)
		res=signed_to_double(ord(d),Q=Q)*max(signal)
		countout+=1
	
		print(countout)
		out.write(str(res)+"\n")
	
		time.sleep(0.3)
		
    time.sleep(5)
    f.close()
    out.close()
ser.close() # close port
print(count,countout)
