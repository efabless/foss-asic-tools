import subprocess
import os
import base64
import multiprocessing
import time
import pandas
import numpy as np

INPUT_NETLIST = os.path.expanduser("~/.xschem/simulations/full_system_tb.spice")
BUILD_DIRECTORY = "./build/"

VOLTAGE_SWEEP = [3.3]
#RLOAD_SWEEP = [10, 1000]
power_vals = np.linspace(0.6, 0.05, 16)
RLOAD_SWEEP = 1.8**2/power_vals

TEMP_SWEEP = [70]
PROCESS_CORNER_SWEEP = ['ss']



def make_netlist(old_netlist, sub_values):
	output_netlist = [] 
	for index in range(len(old_netlist)):
		oldline = old_netlist[index]
		nextline = oldline
		if ".param VIN" in oldline :
			nextline = ".param VIN = %2f \n" % (sub_values[0])
		if ".param RL" in oldline :
			nextline = ".param RL = %2f \n" % (sub_values[1])
		if ".option temp" in oldline :
			nextline = ".option temp = %2f \n" % (sub_values[2])
		if ".lib" in oldline  and "sky130.lib.spice " in oldline:
			lib_index = oldline.find("sky130.lib.spice ")
			nextline = oldline[:(lib_index+len("sky130.lib.spice "))] + sub_values[3] + "\n"
		if "write full_system_tb.raw" in oldline:
			nextline = "\n"
		if ".endc" in oldline:
			nextline = "quit\n.endc\n"


		output_netlist.append(nextline)

	return output_netlist

def parse_logval(log_lines, variable):
	for log_line in log_lines:
		if variable in log_line:
			return float(log_line.split()[2])

def run_sim(eval_point):
	print("starting: ")
	print(eval_point)

	fin = open(INPUT_NETLIST, 'r')
	input_netlist = fin.readlines()
	fin.close()

	instance_name = base64.urlsafe_b64encode(str(eval_point).encode('ascii')).decode("ascii")
	netlist_name = BUILD_DIRECTORY+instance_name+".net"
	log_name = BUILD_DIRECTORY+instance_name+".log"

	eval_netlist = make_netlist(input_netlist, eval_point)

	fout = open(netlist_name, "w")
	fout.writelines(eval_netlist)
	fout.close()

	subprocess.run(["ngspice", "-o", log_name, netlist_name], stdout=subprocess.DEVNULL)

	flog = open(log_name, "r")
	logtext = flog.readlines()

	Iin = parse_logval(logtext, "iin_avg") * -1
	Iout = parse_logval(logtext, "iload_avg")
	Ibias = parse_logval(logtext, "iaux_avg") * -1 
	V_ss_max = parse_logval(logtext, "vout_max")
	V_ss_min = parse_logval(logtext, "vout_min")
	V_tran_max = parse_logval(logtext, "vout_tran_max")
	Il_max = parse_logval(logtext, "il_max")
	Il_min = parse_logval(logtext, "il_min")
	Eff = (Iout**2 * eval_point[1])/(eval_point[0]*(Iin+Ibias)) 
	print(eval_point + [Iin, Iout, Ibias, V_ss_max, V_ss_min, V_tran_max, Il_max, Il_min, Eff])
	return(eval_point + [Iin, Iout, Ibias, V_ss_max, V_ss_min, V_tran_max, Il_max, Il_min, Eff])


if __name__ == '__main__':
	start_time = time.time()
	EVAL_POINTS = []
	#list of all process points
	for voltage_val in VOLTAGE_SWEEP:
		for rload_val in RLOAD_SWEEP:
			for temp_val in TEMP_SWEEP:
				for process_corner in PROCESS_CORNER_SWEEP:
					EVAL_POINTS.append([voltage_val, rload_val, temp_val, process_corner])

	pool = multiprocessing.Pool(8)
	results_ = []
	r = pool.map_async(run_sim, EVAL_POINTS, callback=results_.append)
	r.wait()
	print(results_)
	res = pandas.DataFrame(results_[0], columns=['Vin', 'Rload', 'Temp', 'Process Corner', 'Iin', 'Iout', 'Ibias', 'Vmax', 'Vmin', 'Vpeak', 'IL_Max', 'Il_Min', "Eff"])
	res.to_csv("results.csv", index=False)

	print("--- %s seconds ---" % (time.time() - start_time))










