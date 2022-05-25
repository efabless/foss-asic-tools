import Equipment
import time
import getch
import csv
import numpy as np

POWERSUPPLY_FD = "/dev/serial/by-id/usb-Rohde_Schwarz_HMC8042_VCP039964504-if00"
LOAD_FD = "/dev/ttyUSB1"

LOG_DATA = True
LOG_FILENAME = "eff_test1.csv"

VIN = 3.3
I_IN = 0.8

I_start = 0.0
I_stop = 0.5
I_step = 10E-3

#


#open log file
if LOG_DATA:
	logFile = open(LOG_FILENAME, 'w')
	results_writer = csv.writer(logFile, delimiter=',', quotechar='"')
	results_writer.writerow(["Vin", "Iin", "Pin", "Vout", "Iout", "Pout"])


#activate equipment
Load = Equipment.IT8511B(LOAD_FD)
PowerSupply = Equipment.HMC8042(POWERSUPPLY_FD)

if((Load.fault == True) or (PowerSupply.fault == True)):
	print("Connection Fault")
	print((Load.fault, PowerSupply.fault))
	while True:
		pass

#bring to known state
PowerSupply.disableMaster()
PowerSupply.setCH1()
PowerSupply.setVoltage(5.0)
PowerSupply.setCurrent(0.1)
PowerSupply.enableChannel()

PowerSupply.setCH2()
PowerSupply.setVoltage(VIN)
PowerSupply.setCurrent(I_IN)
PowerSupply.disableChannel()


Load.disableOutput()
Load.configCurrent()
Load.setCurrent(0.0)

PowerSupply.enableMaster()
time.sleep(1)
PowerSupply.setCH2()
PowerSupply.enableChannel()


Load.enableOutput()


for i_out in np.arange(I_start, I_stop, I_step):
	Load.setCurrent(i_out)
	time.sleep(1)

	PowerSupply.setCH2()
	v_in_val = 0.0 
	i_in_val = 0.0 
	v_out_val = 0.0 
	i_out_val = 0.0 

	for x in range(8):
		v_in_val = v_in_val + PowerSupply.readVoltage()/8.0
		i_in_val = i_in_val + PowerSupply.readCurrent()/8.0

		v_out_val = v_out_val + Load.readVoltage()/8.0
		i_out_val = i_out_val + Load.readCurrent()/8.0



	print([v_in_val, i_in_val, v_in_val*i_in_val, v_out_val, i_out_val, v_out_val*i_out_val])
	results_writer.writerow([v_in_val, i_in_val, v_in_val*i_in_val, v_out_val, i_out_val, v_out_val*i_out_val])

Load.disableOutput()
PowerSupply.disableMaster()