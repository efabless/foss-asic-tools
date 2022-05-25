import serial
import time



class Lamdba_GENH600_1_3:
	CMD_DELAY = 0.2
	TIMEOUT = 5.0

	def __init__(self, serialfd):
		#initalize USB serial 
		self.ser = serial.Serial(serialfd, 19200, timeout=1)
		#check identity of power supply 
		self.ser.write(b'ADR 6\r') #sometimes wakeup is needed?
		self.ser.flush()
		self.ser.write(b'RST\r') #reset supply
		self.ser.flush()
		self.ser.write(b'IDN?\r') #sometimes wakeup is needed?
		self.ser.flush()
		time.sleep(self.CMD_DELAY)
		self.ser.reset_input_buffer()
		time.sleep(self.CMD_DELAY)
		self.ser.flush()
		self.ser.write(b'IDN?\r')
		#time delay 
		time.sleep(self.CMD_DELAY)
		if (self.ser.in_waiting != 0):
			deviceID = self.ser.read(self.ser.in_waiting)
			if "LAMBDA,GEN600-1.3-USB" in deviceID.decode():

				self.connected = True
				self.fault = False
				return 
		self.connected = False
		self.fault = True
		return

	def sendCMD(self, cmd):
		self.ser.reset_input_buffer()
		self.ser.write(cmd+b'\r')
		#self.ser.flush()
		time.sleep(self.CMD_DELAY)
		if (self.ser.in_waiting != 0):
			rxVal = self.ser.read(self.ser.in_waiting)
			return rxVal
		else:
			return None

	def setVoltage(self, voltageVal):
		cmd = ('PV ' + "%.3f" % voltageVal).encode()
		self.sendCMD(cmd)

	def readVoltage(self):
		cmd = b'MV?'
		retVal = self.sendCMD(cmd)
		if retVal != None:
			return float(retVal)

	def setCurrent(self, currentVal):
		cmd = ('PC ' + "%.3f" % currentVal).encode()
		self.sendCMD(cmd)

	def readCurrent(self):
		cmd = b'MC?'
		retVal = self.sendCMD(cmd)
		if retVal != None:
			return float(retVal)

	def enableMaster(self):
		cmd = b'OUT 1'
		self.sendCMD(cmd)

	def disableMaster(self):
		cmd = b'OUT 0'
		self.sendCMD(cmd)



class IT8511B:
	CMD_DELAY = 0.2
	TIMEOUT = 5.0

	def __init__(self, serialfd):
		#initalize USB serial 
		self.ser = serial.Serial(serialfd, 9600, timeout=1)
		#check identity of power supply 
		self.ser.write(b'*IDN?\n') #sometimes wakeup is needed?
		self.ser.flush()
		self.ser.reset_input_buffer()
		time.sleep(self.CMD_DELAY)
		self.ser.flush()
		self.ser.write(b'*IDN?\n')
		#time delay 
		time.sleep(self.CMD_DELAY)
		if (self.ser.in_waiting != 0):
			deviceID = self.ser.read(self.ser.in_waiting)
			if "ITECH Ltd., IT8511B" in deviceID.decode():
				self.connected = True
				self.fault = False
				return 
		self.connected = False
		self.fault = True
		return

	def sendCMD(self, cmd):
		self.ser.reset_input_buffer()
		self.ser.write(cmd+b'\n')
		self.ser.flush()
		time.sleep(self.CMD_DELAY)
		if (self.ser.in_waiting != 0):
			rxVal = self.ser.read(self.ser.in_waiting)
			return rxVal
		else:
			return None

	def configVoltage(self):
		#lock control pannel
		cmd = b'SYST:REM'
		self.sendCMD(cmd)

		cmd = b'SOUR:INP 0'
		self.sendCMD(cmd)
		#set in voltage mode
		cmd = b'SOUR:FUNC VOLT'
		self.sendCMD(cmd)

	def configCurrent(self):
		#lock control pannel
		cmd = b'SYST:REM'
		self.sendCMD(cmd)

		cmd = b'SOUR:INP 0'
		self.sendCMD(cmd)
		#set in voltage mode
		cmd = b'SOUR:FUNC CURR'
		self.sendCMD(cmd)


	def setVoltage(self, voltage):
		cmd = ('SOUR:VOLT ' + "%.2f" % voltage).encode()
		self.sendCMD(cmd)

	def setCurrent(self, current):
		cmd = ('SOUR:CURR ' + "%.2f" % current).encode()
		self.sendCMD(cmd)

	def enableOutput(self):
		cmd = b'SOUR:INP 1'
		self.sendCMD(cmd)

	def disableOutput(self):
		cmd = b'SOUR:INP 0'
		self.sendCMD(cmd)

	def readVoltage(self):
		cmd = b'MEAS:VOLT?'
		retVal = self.sendCMD(cmd)
		if retVal != None:
			return float(retVal)

	def readCurrent(self):
		cmd = b'MEAS:CURR?'
		retVal = self.sendCMD(cmd)
		if retVal != None:
			return float(retVal)

	def readPower(self):
		cmd = b'MEAS:POW?'
		retVal = self.sendCMD(cmd)
		if retVal != None:
			return float(retVal)

class HMC8042:
	CMD_DELAY = 0.2
	TIMEOUT = 5.0

	def __init__(self, serialfd):
		#initalize USB serial 
		self.ser = serial.Serial(serialfd, 9600, timeout=1)
		#check identity of power supply 
		self.ser.write(b'*IDN?\n') #sometimes wakeup is needed?
		self.ser.flush()
		self.ser.reset_input_buffer()
		time.sleep(self.CMD_DELAY)
		self.ser.flush()
		self.ser.write(b'*IDN?\n')
		#time delay 
		time.sleep(self.CMD_DELAY)
		if (self.ser.in_waiting != 0):
			deviceID = self.ser.read(self.ser.in_waiting)
			if "Rohde&Schwarz,HMC8042" in deviceID.decode():
				self.connected = True
				self.fault = False
				return 
		self.connected = False
		self.fault = True
		return

	def sendCMD(self, cmd):
		self.ser.reset_input_buffer()
		self.ser.write(cmd+b'\n')
		#self.ser.flush()
		time.sleep(self.CMD_DELAY)
		if (self.ser.in_waiting != 0):
			rxVal = self.ser.read(self.ser.in_waiting)
			return rxVal
		else:
			return None

	def setCH1(self):
		cmd = b'INST OUT1'
		self.sendCMD(cmd)

	def setCH2(self):
		cmd = b'INST OUT2'
		self.sendCMD(cmd)

	def setCurrent(self, currentVal):
		cmd = ('SOUR:CURR ' + "%.3f" % currentVal).encode()
		self.sendCMD(cmd)

	def setVoltage(self, voltageVal):
		cmd = ('SOUR:VOLT ' + "%.3f" % voltageVal).encode()
		self.sendCMD(cmd)

	def enableChannel(self):
		cmd = b'OUTP:CHAN 1'
		self.sendCMD(cmd)

	def disableChannel(self):
		cmd = b'OUTP:CHAN 0'
		self.sendCMD(cmd)

	def enableMaster(self):
		cmd = b'OUTP:MAST 1'
		self.sendCMD(cmd)

	def disableMaster(self):
		cmd = b'OUTP:MAST 0'
		self.sendCMD(cmd)

	def readVoltage(self):
		cmd = b'MEAS:VOLT?'
		retVal = self.sendCMD(cmd)
		if retVal != None:
			return float(retVal)

	def setSeriesVoltage(self, voltageVal):
		self.setCH1()
		self.setVoltage(voltageVal/2.0)
		self.setCH2()
		self.setVoltage(voltageVal/2.0)

	def setSeriesCurrent(self, currentVal):
		self.setCH1()
		self.setCurrent(currentVal)
		self.setCH2()
		self.setCurrent(currentVal)


	def readCurrent(self):
		cmd = b'MEAS:CURR?'
		retVal = self.sendCMD(cmd)
		if retVal != None:
			return float(retVal)
