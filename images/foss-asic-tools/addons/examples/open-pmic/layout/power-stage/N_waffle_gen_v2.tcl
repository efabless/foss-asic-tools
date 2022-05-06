proc shift_to_center {} {
	set res1 [box size]
	move [expr {-[lindex $res1 0] / 2}]i [expr {-[lindex $res1 1] / 2}]i
}
load temp
box 5.25um 5.25um 4.61um 4.61um
paint mvpdiffusion 
box 5.25um 5.25um 4.94um 4.94um
erase mvpdiffusion 
box 5.19um 5.19um 4.61um 4.61um
paint locali 
box 5.19um 5.19um 4.96um 4.96um
erase locali 
box 5.22um 5.22um 4.61um 4.61um
paint metal1 
box 5.22um 5.22um 4.94um 4.94um
erase metal1 
box 2.75um 5.5um 2.75um 5.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.25um 5.75um 4.61um 6.39um
paint mvpdiffusion 
box 5.25um 5.75um 4.94um 6.06um
erase mvpdiffusion 
box 5.19um 5.81um 4.61um 6.39um
paint locali 
box 5.19um 5.81um 4.96um 6.04um
erase locali 
box 5.22um 5.78um 4.61um 6.39um
paint metal1 
box 5.22um 5.78um 4.94um 6.06um
erase metal1 
box 5.25um 10.75um 4.61um 10.11um
paint mvpdiffusion 
box 5.25um 10.75um 4.94um 10.44um
erase mvpdiffusion 
box 5.19um 10.69um 4.61um 10.11um
paint locali 
box 5.19um 10.69um 4.96um 10.46um
erase locali 
box 5.22um 10.72um 4.61um 10.11um
paint metal1 
box 5.22um 10.72um 4.94um 10.44um
erase metal1 
box 2.75um 11um 2.75um 11um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.25um 11.25um 4.61um 11.89um
paint mvpdiffusion 
box 5.25um 11.25um 4.94um 11.56um
erase mvpdiffusion 
box 5.19um 11.31um 4.61um 11.89um
paint locali 
box 5.19um 11.31um 4.96um 11.54um
erase locali 
box 5.22um 11.28um 4.61um 11.89um
paint metal1 
box 5.22um 11.28um 4.94um 11.56um
erase metal1 
box 5.25um 16.25um 4.61um 15.61um
paint mvpdiffusion 
box 5.25um 16.25um 4.94um 15.94um
erase mvpdiffusion 
box 5.19um 16.19um 4.61um 15.61um
paint locali 
box 5.19um 16.19um 4.96um 15.96um
erase locali 
box 5.22um 16.22um 4.61um 15.61um
paint metal1 
box 5.22um 16.22um 4.94um 15.94um
erase metal1 
box 2.75um 16.5um 2.75um 16.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.25um 16.75um 4.61um 17.39um
paint mvpdiffusion 
box 5.25um 16.75um 4.94um 17.06um
erase mvpdiffusion 
box 5.19um 16.81um 4.61um 17.39um
paint locali 
box 5.19um 16.81um 4.96um 17.04um
erase locali 
box 5.22um 16.78um 4.61um 17.39um
paint metal1 
box 5.22um 16.78um 4.94um 17.06um
erase metal1 
box 5.25um 21.75um 4.61um 21.11um
paint mvpdiffusion 
box 5.25um 21.75um 4.94um 21.44um
erase mvpdiffusion 
box 5.19um 21.69um 4.61um 21.11um
paint locali 
box 5.19um 21.69um 4.96um 21.46um
erase locali 
box 5.22um 21.72um 4.61um 21.11um
paint metal1 
box 5.22um 21.72um 4.94um 21.44um
erase metal1 
box 2.75um 22um 2.75um 22um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.25um 22.25um 4.61um 22.89um
paint mvpdiffusion 
box 5.25um 22.25um 4.94um 22.56um
erase mvpdiffusion 
box 5.19um 22.31um 4.61um 22.89um
paint locali 
box 5.19um 22.31um 4.96um 22.54um
erase locali 
box 5.22um 22.28um 4.61um 22.89um
paint metal1 
box 5.22um 22.28um 4.94um 22.56um
erase metal1 
box 5.25um 27.25um 4.61um 26.61um
paint mvpdiffusion 
box 5.25um 27.25um 4.94um 26.94um
erase mvpdiffusion 
box 5.19um 27.19um 4.61um 26.61um
paint locali 
box 5.19um 27.19um 4.96um 26.96um
erase locali 
box 5.22um 27.22um 4.61um 26.61um
paint metal1 
box 5.22um 27.22um 4.94um 26.94um
erase metal1 
box 2.75um 27.5um 2.75um 27.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.25um 27.75um 4.61um 28.39um
paint mvpdiffusion 
box 5.25um 27.75um 4.94um 28.06um
erase mvpdiffusion 
box 5.19um 27.81um 4.61um 28.39um
paint locali 
box 5.19um 27.81um 4.96um 28.04um
erase locali 
box 5.22um 27.78um 4.61um 28.39um
paint metal1 
box 5.22um 27.78um 4.94um 28.06um
erase metal1 
box 5.5um 2.75um 5.5um 2.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 5.75um 5.25um 6.39um 4.61um
paint mvpdiffusion 
box 5.75um 5.25um 6.06um 4.94um
erase mvpdiffusion 
box 5.81um 5.19um 6.39um 4.61um
paint locali 
box 5.81um 5.19um 6.04um 4.96um
erase locali 
box 5.78um 5.22um 6.39um 4.61um
paint metal1 
box 5.78um 5.22um 6.06um 4.94um
erase metal1 
box 10.75um 5.25um 10.11um 4.61um
paint mvpdiffusion 
box 10.75um 5.25um 10.44um 4.94um
erase mvpdiffusion 
box 10.69um 5.19um 10.11um 4.61um
paint locali 
box 10.69um 5.19um 10.46um 4.96um
erase locali 
box 10.72um 5.22um 10.11um 4.61um
paint metal1 
box 10.72um 5.22um 10.44um 4.94um
erase metal1 
box 8.25um 5.5um 8.25um 5.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.5um 8.25um 5.5um 8.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 5.75um 5.75um 6.39um 6.39um
paint mvpdiffusion 
box 5.75um 5.75um 6.06um 6.06um
erase mvpdiffusion 
box 5.81um 5.81um 6.39um 6.39um
paint locali 
box 5.81um 5.81um 6.04um 6.04um
erase locali 
box 5.78um 5.78um 6.39um 6.39um
paint metal1 
box 5.78um 5.78um 6.06um 6.06um
erase metal1 
box 5.75um 10.75um 6.39um 10.11um
paint mvpdiffusion 
box 5.75um 10.75um 6.06um 10.44um
erase mvpdiffusion 
box 5.81um 10.69um 6.39um 10.11um
paint locali 
box 5.81um 10.69um 6.04um 10.46um
erase locali 
box 5.78um 10.72um 6.39um 10.11um
paint metal1 
box 5.78um 10.72um 6.06um 10.44um
erase metal1 
box 10.75um 5.75um 10.11um 6.39um
paint mvpdiffusion 
box 10.75um 5.75um 10.44um 6.06um
erase mvpdiffusion 
box 10.69um 5.81um 10.11um 6.39um
paint locali 
box 10.69um 5.81um 10.46um 6.04um
erase locali 
box 10.72um 5.78um 10.11um 6.39um
paint metal1 
box 10.72um 5.78um 10.44um 6.06um
erase metal1 
box 10.75um 10.75um 10.11um 10.11um
paint mvpdiffusion 
box 10.75um 10.75um 10.44um 10.44um
erase mvpdiffusion 
box 10.69um 10.69um 10.11um 10.11um
paint locali 
box 10.69um 10.69um 10.46um 10.46um
erase locali 
box 10.72um 10.72um 10.11um 10.11um
paint metal1 
box 10.72um 10.72um 10.44um 10.44um
erase metal1 
box 8.25um 11um 8.25um 11um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.5um 13.75um 5.5um 13.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 5.75um 11.25um 6.39um 11.89um
paint mvpdiffusion 
box 5.75um 11.25um 6.06um 11.56um
erase mvpdiffusion 
box 5.81um 11.31um 6.39um 11.89um
paint locali 
box 5.81um 11.31um 6.04um 11.54um
erase locali 
box 5.78um 11.28um 6.39um 11.89um
paint metal1 
box 5.78um 11.28um 6.06um 11.56um
erase metal1 
box 5.75um 16.25um 6.39um 15.61um
paint mvpdiffusion 
box 5.75um 16.25um 6.06um 15.94um
erase mvpdiffusion 
box 5.81um 16.19um 6.39um 15.61um
paint locali 
box 5.81um 16.19um 6.04um 15.96um
erase locali 
box 5.78um 16.22um 6.39um 15.61um
paint metal1 
box 5.78um 16.22um 6.06um 15.94um
erase metal1 
box 10.75um 11.25um 10.11um 11.89um
paint mvpdiffusion 
box 10.75um 11.25um 10.44um 11.56um
erase mvpdiffusion 
box 10.69um 11.31um 10.11um 11.89um
paint locali 
box 10.69um 11.31um 10.46um 11.54um
erase locali 
box 10.72um 11.28um 10.11um 11.89um
paint metal1 
box 10.72um 11.28um 10.44um 11.56um
erase metal1 
box 10.75um 16.25um 10.11um 15.61um
paint mvpdiffusion 
box 10.75um 16.25um 10.44um 15.94um
erase mvpdiffusion 
box 10.69um 16.19um 10.11um 15.61um
paint locali 
box 10.69um 16.19um 10.46um 15.96um
erase locali 
box 10.72um 16.22um 10.11um 15.61um
paint metal1 
box 10.72um 16.22um 10.44um 15.94um
erase metal1 
box 8.25um 16.5um 8.25um 16.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.5um 19.25um 5.5um 19.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 5.75um 16.75um 6.39um 17.39um
paint mvpdiffusion 
box 5.75um 16.75um 6.06um 17.06um
erase mvpdiffusion 
box 5.81um 16.81um 6.39um 17.39um
paint locali 
box 5.81um 16.81um 6.04um 17.04um
erase locali 
box 5.78um 16.78um 6.39um 17.39um
paint metal1 
box 5.78um 16.78um 6.06um 17.06um
erase metal1 
box 5.75um 21.75um 6.39um 21.11um
paint mvpdiffusion 
box 5.75um 21.75um 6.06um 21.44um
erase mvpdiffusion 
box 5.81um 21.69um 6.39um 21.11um
paint locali 
box 5.81um 21.69um 6.04um 21.46um
erase locali 
box 5.78um 21.72um 6.39um 21.11um
paint metal1 
box 5.78um 21.72um 6.06um 21.44um
erase metal1 
box 10.75um 16.75um 10.11um 17.39um
paint mvpdiffusion 
box 10.75um 16.75um 10.44um 17.06um
erase mvpdiffusion 
box 10.69um 16.81um 10.11um 17.39um
paint locali 
box 10.69um 16.81um 10.46um 17.04um
erase locali 
box 10.72um 16.78um 10.11um 17.39um
paint metal1 
box 10.72um 16.78um 10.44um 17.06um
erase metal1 
box 10.75um 21.75um 10.11um 21.11um
paint mvpdiffusion 
box 10.75um 21.75um 10.44um 21.44um
erase mvpdiffusion 
box 10.69um 21.69um 10.11um 21.11um
paint locali 
box 10.69um 21.69um 10.46um 21.46um
erase locali 
box 10.72um 21.72um 10.11um 21.11um
paint metal1 
box 10.72um 21.72um 10.44um 21.44um
erase metal1 
box 8.25um 22um 8.25um 22um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.5um 24.75um 5.5um 24.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 5.75um 22.25um 6.39um 22.89um
paint mvpdiffusion 
box 5.75um 22.25um 6.06um 22.56um
erase mvpdiffusion 
box 5.81um 22.31um 6.39um 22.89um
paint locali 
box 5.81um 22.31um 6.04um 22.54um
erase locali 
box 5.78um 22.28um 6.39um 22.89um
paint metal1 
box 5.78um 22.28um 6.06um 22.56um
erase metal1 
box 5.75um 27.25um 6.39um 26.61um
paint mvpdiffusion 
box 5.75um 27.25um 6.06um 26.94um
erase mvpdiffusion 
box 5.81um 27.19um 6.39um 26.61um
paint locali 
box 5.81um 27.19um 6.04um 26.96um
erase locali 
box 5.78um 27.22um 6.39um 26.61um
paint metal1 
box 5.78um 27.22um 6.06um 26.94um
erase metal1 
box 10.75um 22.25um 10.11um 22.89um
paint mvpdiffusion 
box 10.75um 22.25um 10.44um 22.56um
erase mvpdiffusion 
box 10.69um 22.31um 10.11um 22.89um
paint locali 
box 10.69um 22.31um 10.46um 22.54um
erase locali 
box 10.72um 22.28um 10.11um 22.89um
paint metal1 
box 10.72um 22.28um 10.44um 22.56um
erase metal1 
box 10.75um 27.25um 10.11um 26.61um
paint mvpdiffusion 
box 10.75um 27.25um 10.44um 26.94um
erase mvpdiffusion 
box 10.69um 27.19um 10.11um 26.61um
paint locali 
box 10.69um 27.19um 10.46um 26.96um
erase locali 
box 10.72um 27.22um 10.11um 26.61um
paint metal1 
box 10.72um 27.22um 10.44um 26.94um
erase metal1 
box 8.25um 27.5um 8.25um 27.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 5.5um 30.25um 5.5um 30.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 5.75um 27.75um 6.39um 28.39um
paint mvpdiffusion 
box 5.75um 27.75um 6.06um 28.06um
erase mvpdiffusion 
box 5.81um 27.81um 6.39um 28.39um
paint locali 
box 5.81um 27.81um 6.04um 28.04um
erase locali 
box 5.78um 27.78um 6.39um 28.39um
paint metal1 
box 5.78um 27.78um 6.06um 28.06um
erase metal1 
box 10.75um 27.75um 10.11um 28.39um
paint mvpdiffusion 
box 10.75um 27.75um 10.44um 28.06um
erase mvpdiffusion 
box 10.69um 27.81um 10.11um 28.39um
paint locali 
box 10.69um 27.81um 10.46um 28.04um
erase locali 
box 10.72um 27.78um 10.11um 28.39um
paint metal1 
box 10.72um 27.78um 10.44um 28.06um
erase metal1 
box 11um 2.75um 11um 2.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 11.25um 5.25um 11.89um 4.61um
paint mvpdiffusion 
box 11.25um 5.25um 11.56um 4.94um
erase mvpdiffusion 
box 11.31um 5.19um 11.89um 4.61um
paint locali 
box 11.31um 5.19um 11.54um 4.96um
erase locali 
box 11.28um 5.22um 11.89um 4.61um
paint metal1 
box 11.28um 5.22um 11.56um 4.94um
erase metal1 
box 16.25um 5.25um 15.61um 4.61um
paint mvpdiffusion 
box 16.25um 5.25um 15.94um 4.94um
erase mvpdiffusion 
box 16.19um 5.19um 15.61um 4.61um
paint locali 
box 16.19um 5.19um 15.96um 4.96um
erase locali 
box 16.22um 5.22um 15.61um 4.61um
paint metal1 
box 16.22um 5.22um 15.94um 4.94um
erase metal1 
box 13.75um 5.5um 13.75um 5.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 11um 8.25um 11um 8.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 11.25um 5.75um 11.89um 6.39um
paint mvpdiffusion 
box 11.25um 5.75um 11.56um 6.06um
erase mvpdiffusion 
box 11.31um 5.81um 11.89um 6.39um
paint locali 
box 11.31um 5.81um 11.54um 6.04um
erase locali 
box 11.28um 5.78um 11.89um 6.39um
paint metal1 
box 11.28um 5.78um 11.56um 6.06um
erase metal1 
box 11.25um 10.75um 11.89um 10.11um
paint mvpdiffusion 
box 11.25um 10.75um 11.56um 10.44um
erase mvpdiffusion 
box 11.31um 10.69um 11.89um 10.11um
paint locali 
box 11.31um 10.69um 11.54um 10.46um
erase locali 
box 11.28um 10.72um 11.89um 10.11um
paint metal1 
box 11.28um 10.72um 11.56um 10.44um
erase metal1 
box 16.25um 5.75um 15.61um 6.39um
paint mvpdiffusion 
box 16.25um 5.75um 15.94um 6.06um
erase mvpdiffusion 
box 16.19um 5.81um 15.61um 6.39um
paint locali 
box 16.19um 5.81um 15.96um 6.04um
erase locali 
box 16.22um 5.78um 15.61um 6.39um
paint metal1 
box 16.22um 5.78um 15.94um 6.06um
erase metal1 
box 16.25um 10.75um 15.61um 10.11um
paint mvpdiffusion 
box 16.25um 10.75um 15.94um 10.44um
erase mvpdiffusion 
box 16.19um 10.69um 15.61um 10.11um
paint locali 
box 16.19um 10.69um 15.96um 10.46um
erase locali 
box 16.22um 10.72um 15.61um 10.11um
paint metal1 
box 16.22um 10.72um 15.94um 10.44um
erase metal1 
box 13.75um 11um 13.75um 11um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 11um 13.75um 11um 13.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 11.25um 11.25um 11.89um 11.89um
paint mvpdiffusion 
box 11.25um 11.25um 11.56um 11.56um
erase mvpdiffusion 
box 11.31um 11.31um 11.89um 11.89um
paint locali 
box 11.31um 11.31um 11.54um 11.54um
erase locali 
box 11.28um 11.28um 11.89um 11.89um
paint metal1 
box 11.28um 11.28um 11.56um 11.56um
erase metal1 
box 11.25um 16.25um 11.89um 15.61um
paint mvpdiffusion 
box 11.25um 16.25um 11.56um 15.94um
erase mvpdiffusion 
box 11.31um 16.19um 11.89um 15.61um
paint locali 
box 11.31um 16.19um 11.54um 15.96um
erase locali 
box 11.28um 16.22um 11.89um 15.61um
paint metal1 
box 11.28um 16.22um 11.56um 15.94um
erase metal1 
box 16.25um 11.25um 15.61um 11.89um
paint mvpdiffusion 
box 16.25um 11.25um 15.94um 11.56um
erase mvpdiffusion 
box 16.19um 11.31um 15.61um 11.89um
paint locali 
box 16.19um 11.31um 15.96um 11.54um
erase locali 
box 16.22um 11.28um 15.61um 11.89um
paint metal1 
box 16.22um 11.28um 15.94um 11.56um
erase metal1 
box 16.25um 16.25um 15.61um 15.61um
paint mvpdiffusion 
box 16.25um 16.25um 15.94um 15.94um
erase mvpdiffusion 
box 16.19um 16.19um 15.61um 15.61um
paint locali 
box 16.19um 16.19um 15.96um 15.96um
erase locali 
box 16.22um 16.22um 15.61um 15.61um
paint metal1 
box 16.22um 16.22um 15.94um 15.94um
erase metal1 
box 13.75um 16.5um 13.75um 16.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 11um 19.25um 11um 19.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 11.25um 16.75um 11.89um 17.39um
paint mvpdiffusion 
box 11.25um 16.75um 11.56um 17.06um
erase mvpdiffusion 
box 11.31um 16.81um 11.89um 17.39um
paint locali 
box 11.31um 16.81um 11.54um 17.04um
erase locali 
box 11.28um 16.78um 11.89um 17.39um
paint metal1 
box 11.28um 16.78um 11.56um 17.06um
erase metal1 
box 11.25um 21.75um 11.89um 21.11um
paint mvpdiffusion 
box 11.25um 21.75um 11.56um 21.44um
erase mvpdiffusion 
box 11.31um 21.69um 11.89um 21.11um
paint locali 
box 11.31um 21.69um 11.54um 21.46um
erase locali 
box 11.28um 21.72um 11.89um 21.11um
paint metal1 
box 11.28um 21.72um 11.56um 21.44um
erase metal1 
box 16.25um 16.75um 15.61um 17.39um
paint mvpdiffusion 
box 16.25um 16.75um 15.94um 17.06um
erase mvpdiffusion 
box 16.19um 16.81um 15.61um 17.39um
paint locali 
box 16.19um 16.81um 15.96um 17.04um
erase locali 
box 16.22um 16.78um 15.61um 17.39um
paint metal1 
box 16.22um 16.78um 15.94um 17.06um
erase metal1 
box 16.25um 21.75um 15.61um 21.11um
paint mvpdiffusion 
box 16.25um 21.75um 15.94um 21.44um
erase mvpdiffusion 
box 16.19um 21.69um 15.61um 21.11um
paint locali 
box 16.19um 21.69um 15.96um 21.46um
erase locali 
box 16.22um 21.72um 15.61um 21.11um
paint metal1 
box 16.22um 21.72um 15.94um 21.44um
erase metal1 
box 13.75um 22um 13.75um 22um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 11um 24.75um 11um 24.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 11.25um 22.25um 11.89um 22.89um
paint mvpdiffusion 
box 11.25um 22.25um 11.56um 22.56um
erase mvpdiffusion 
box 11.31um 22.31um 11.89um 22.89um
paint locali 
box 11.31um 22.31um 11.54um 22.54um
erase locali 
box 11.28um 22.28um 11.89um 22.89um
paint metal1 
box 11.28um 22.28um 11.56um 22.56um
erase metal1 
box 11.25um 27.25um 11.89um 26.61um
paint mvpdiffusion 
box 11.25um 27.25um 11.56um 26.94um
erase mvpdiffusion 
box 11.31um 27.19um 11.89um 26.61um
paint locali 
box 11.31um 27.19um 11.54um 26.96um
erase locali 
box 11.28um 27.22um 11.89um 26.61um
paint metal1 
box 11.28um 27.22um 11.56um 26.94um
erase metal1 
box 16.25um 22.25um 15.61um 22.89um
paint mvpdiffusion 
box 16.25um 22.25um 15.94um 22.56um
erase mvpdiffusion 
box 16.19um 22.31um 15.61um 22.89um
paint locali 
box 16.19um 22.31um 15.96um 22.54um
erase locali 
box 16.22um 22.28um 15.61um 22.89um
paint metal1 
box 16.22um 22.28um 15.94um 22.56um
erase metal1 
box 16.25um 27.25um 15.61um 26.61um
paint mvpdiffusion 
box 16.25um 27.25um 15.94um 26.94um
erase mvpdiffusion 
box 16.19um 27.19um 15.61um 26.61um
paint locali 
box 16.19um 27.19um 15.96um 26.96um
erase locali 
box 16.22um 27.22um 15.61um 26.61um
paint metal1 
box 16.22um 27.22um 15.94um 26.94um
erase metal1 
box 13.75um 27.5um 13.75um 27.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 11um 30.25um 11um 30.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 11.25um 27.75um 11.89um 28.39um
paint mvpdiffusion 
box 11.25um 27.75um 11.56um 28.06um
erase mvpdiffusion 
box 11.31um 27.81um 11.89um 28.39um
paint locali 
box 11.31um 27.81um 11.54um 28.04um
erase locali 
box 11.28um 27.78um 11.89um 28.39um
paint metal1 
box 11.28um 27.78um 11.56um 28.06um
erase metal1 
box 16.25um 27.75um 15.61um 28.39um
paint mvpdiffusion 
box 16.25um 27.75um 15.94um 28.06um
erase mvpdiffusion 
box 16.19um 27.81um 15.61um 28.39um
paint locali 
box 16.19um 27.81um 15.96um 28.04um
erase locali 
box 16.22um 27.78um 15.61um 28.39um
paint metal1 
box 16.22um 27.78um 15.94um 28.06um
erase metal1 
box 16.5um 2.75um 16.5um 2.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 16.75um 5.25um 17.39um 4.61um
paint mvpdiffusion 
box 16.75um 5.25um 17.06um 4.94um
erase mvpdiffusion 
box 16.81um 5.19um 17.39um 4.61um
paint locali 
box 16.81um 5.19um 17.04um 4.96um
erase locali 
box 16.78um 5.22um 17.39um 4.61um
paint metal1 
box 16.78um 5.22um 17.06um 4.94um
erase metal1 
box 21.75um 5.25um 21.11um 4.61um
paint mvpdiffusion 
box 21.75um 5.25um 21.44um 4.94um
erase mvpdiffusion 
box 21.69um 5.19um 21.11um 4.61um
paint locali 
box 21.69um 5.19um 21.46um 4.96um
erase locali 
box 21.72um 5.22um 21.11um 4.61um
paint metal1 
box 21.72um 5.22um 21.44um 4.94um
erase metal1 
box 19.25um 5.5um 19.25um 5.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 16.5um 8.25um 16.5um 8.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 16.75um 5.75um 17.39um 6.39um
paint mvpdiffusion 
box 16.75um 5.75um 17.06um 6.06um
erase mvpdiffusion 
box 16.81um 5.81um 17.39um 6.39um
paint locali 
box 16.81um 5.81um 17.04um 6.04um
erase locali 
box 16.78um 5.78um 17.39um 6.39um
paint metal1 
box 16.78um 5.78um 17.06um 6.06um
erase metal1 
box 16.75um 10.75um 17.39um 10.11um
paint mvpdiffusion 
box 16.75um 10.75um 17.06um 10.44um
erase mvpdiffusion 
box 16.81um 10.69um 17.39um 10.11um
paint locali 
box 16.81um 10.69um 17.04um 10.46um
erase locali 
box 16.78um 10.72um 17.39um 10.11um
paint metal1 
box 16.78um 10.72um 17.06um 10.44um
erase metal1 
box 21.75um 5.75um 21.11um 6.39um
paint mvpdiffusion 
box 21.75um 5.75um 21.44um 6.06um
erase mvpdiffusion 
box 21.69um 5.81um 21.11um 6.39um
paint locali 
box 21.69um 5.81um 21.46um 6.04um
erase locali 
box 21.72um 5.78um 21.11um 6.39um
paint metal1 
box 21.72um 5.78um 21.44um 6.06um
erase metal1 
box 21.75um 10.75um 21.11um 10.11um
paint mvpdiffusion 
box 21.75um 10.75um 21.44um 10.44um
erase mvpdiffusion 
box 21.69um 10.69um 21.11um 10.11um
paint locali 
box 21.69um 10.69um 21.46um 10.46um
erase locali 
box 21.72um 10.72um 21.11um 10.11um
paint metal1 
box 21.72um 10.72um 21.44um 10.44um
erase metal1 
box 19.25um 11um 19.25um 11um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 16.5um 13.75um 16.5um 13.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 16.75um 11.25um 17.39um 11.89um
paint mvpdiffusion 
box 16.75um 11.25um 17.06um 11.56um
erase mvpdiffusion 
box 16.81um 11.31um 17.39um 11.89um
paint locali 
box 16.81um 11.31um 17.04um 11.54um
erase locali 
box 16.78um 11.28um 17.39um 11.89um
paint metal1 
box 16.78um 11.28um 17.06um 11.56um
erase metal1 
box 16.75um 16.25um 17.39um 15.61um
paint mvpdiffusion 
box 16.75um 16.25um 17.06um 15.94um
erase mvpdiffusion 
box 16.81um 16.19um 17.39um 15.61um
paint locali 
box 16.81um 16.19um 17.04um 15.96um
erase locali 
box 16.78um 16.22um 17.39um 15.61um
paint metal1 
box 16.78um 16.22um 17.06um 15.94um
erase metal1 
box 21.75um 11.25um 21.11um 11.89um
paint mvpdiffusion 
box 21.75um 11.25um 21.44um 11.56um
erase mvpdiffusion 
box 21.69um 11.31um 21.11um 11.89um
paint locali 
box 21.69um 11.31um 21.46um 11.54um
erase locali 
box 21.72um 11.28um 21.11um 11.89um
paint metal1 
box 21.72um 11.28um 21.44um 11.56um
erase metal1 
box 21.75um 16.25um 21.11um 15.61um
paint mvpdiffusion 
box 21.75um 16.25um 21.44um 15.94um
erase mvpdiffusion 
box 21.69um 16.19um 21.11um 15.61um
paint locali 
box 21.69um 16.19um 21.46um 15.96um
erase locali 
box 21.72um 16.22um 21.11um 15.61um
paint metal1 
box 21.72um 16.22um 21.44um 15.94um
erase metal1 
box 19.25um 16.5um 19.25um 16.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 16.5um 19.25um 16.5um 19.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 16.75um 16.75um 17.39um 17.39um
paint mvpdiffusion 
box 16.75um 16.75um 17.06um 17.06um
erase mvpdiffusion 
box 16.81um 16.81um 17.39um 17.39um
paint locali 
box 16.81um 16.81um 17.04um 17.04um
erase locali 
box 16.78um 16.78um 17.39um 17.39um
paint metal1 
box 16.78um 16.78um 17.06um 17.06um
erase metal1 
box 16.75um 21.75um 17.39um 21.11um
paint mvpdiffusion 
box 16.75um 21.75um 17.06um 21.44um
erase mvpdiffusion 
box 16.81um 21.69um 17.39um 21.11um
paint locali 
box 16.81um 21.69um 17.04um 21.46um
erase locali 
box 16.78um 21.72um 17.39um 21.11um
paint metal1 
box 16.78um 21.72um 17.06um 21.44um
erase metal1 
box 21.75um 16.75um 21.11um 17.39um
paint mvpdiffusion 
box 21.75um 16.75um 21.44um 17.06um
erase mvpdiffusion 
box 21.69um 16.81um 21.11um 17.39um
paint locali 
box 21.69um 16.81um 21.46um 17.04um
erase locali 
box 21.72um 16.78um 21.11um 17.39um
paint metal1 
box 21.72um 16.78um 21.44um 17.06um
erase metal1 
box 21.75um 21.75um 21.11um 21.11um
paint mvpdiffusion 
box 21.75um 21.75um 21.44um 21.44um
erase mvpdiffusion 
box 21.69um 21.69um 21.11um 21.11um
paint locali 
box 21.69um 21.69um 21.46um 21.46um
erase locali 
box 21.72um 21.72um 21.11um 21.11um
paint metal1 
box 21.72um 21.72um 21.44um 21.44um
erase metal1 
box 19.25um 22um 19.25um 22um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 16.5um 24.75um 16.5um 24.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 16.75um 22.25um 17.39um 22.89um
paint mvpdiffusion 
box 16.75um 22.25um 17.06um 22.56um
erase mvpdiffusion 
box 16.81um 22.31um 17.39um 22.89um
paint locali 
box 16.81um 22.31um 17.04um 22.54um
erase locali 
box 16.78um 22.28um 17.39um 22.89um
paint metal1 
box 16.78um 22.28um 17.06um 22.56um
erase metal1 
box 16.75um 27.25um 17.39um 26.61um
paint mvpdiffusion 
box 16.75um 27.25um 17.06um 26.94um
erase mvpdiffusion 
box 16.81um 27.19um 17.39um 26.61um
paint locali 
box 16.81um 27.19um 17.04um 26.96um
erase locali 
box 16.78um 27.22um 17.39um 26.61um
paint metal1 
box 16.78um 27.22um 17.06um 26.94um
erase metal1 
box 21.75um 22.25um 21.11um 22.89um
paint mvpdiffusion 
box 21.75um 22.25um 21.44um 22.56um
erase mvpdiffusion 
box 21.69um 22.31um 21.11um 22.89um
paint locali 
box 21.69um 22.31um 21.46um 22.54um
erase locali 
box 21.72um 22.28um 21.11um 22.89um
paint metal1 
box 21.72um 22.28um 21.44um 22.56um
erase metal1 
box 21.75um 27.25um 21.11um 26.61um
paint mvpdiffusion 
box 21.75um 27.25um 21.44um 26.94um
erase mvpdiffusion 
box 21.69um 27.19um 21.11um 26.61um
paint locali 
box 21.69um 27.19um 21.46um 26.96um
erase locali 
box 21.72um 27.22um 21.11um 26.61um
paint metal1 
box 21.72um 27.22um 21.44um 26.94um
erase metal1 
box 19.25um 27.5um 19.25um 27.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 16.5um 30.25um 16.5um 30.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 16.75um 27.75um 17.39um 28.39um
paint mvpdiffusion 
box 16.75um 27.75um 17.06um 28.06um
erase mvpdiffusion 
box 16.81um 27.81um 17.39um 28.39um
paint locali 
box 16.81um 27.81um 17.04um 28.04um
erase locali 
box 16.78um 27.78um 17.39um 28.39um
paint metal1 
box 16.78um 27.78um 17.06um 28.06um
erase metal1 
box 21.75um 27.75um 21.11um 28.39um
paint mvpdiffusion 
box 21.75um 27.75um 21.44um 28.06um
erase mvpdiffusion 
box 21.69um 27.81um 21.11um 28.39um
paint locali 
box 21.69um 27.81um 21.46um 28.04um
erase locali 
box 21.72um 27.78um 21.11um 28.39um
paint metal1 
box 21.72um 27.78um 21.44um 28.06um
erase metal1 
box 22um 2.75um 22um 2.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 22.25um 5.25um 22.89um 4.61um
paint mvpdiffusion 
box 22.25um 5.25um 22.56um 4.94um
erase mvpdiffusion 
box 22.31um 5.19um 22.89um 4.61um
paint locali 
box 22.31um 5.19um 22.54um 4.96um
erase locali 
box 22.28um 5.22um 22.89um 4.61um
paint metal1 
box 22.28um 5.22um 22.56um 4.94um
erase metal1 
box 27.25um 5.25um 26.61um 4.61um
paint mvpdiffusion 
box 27.25um 5.25um 26.94um 4.94um
erase mvpdiffusion 
box 27.19um 5.19um 26.61um 4.61um
paint locali 
box 27.19um 5.19um 26.96um 4.96um
erase locali 
box 27.22um 5.22um 26.61um 4.61um
paint metal1 
box 27.22um 5.22um 26.94um 4.94um
erase metal1 
box 24.75um 5.5um 24.75um 5.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 22um 8.25um 22um 8.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 22.25um 5.75um 22.89um 6.39um
paint mvpdiffusion 
box 22.25um 5.75um 22.56um 6.06um
erase mvpdiffusion 
box 22.31um 5.81um 22.89um 6.39um
paint locali 
box 22.31um 5.81um 22.54um 6.04um
erase locali 
box 22.28um 5.78um 22.89um 6.39um
paint metal1 
box 22.28um 5.78um 22.56um 6.06um
erase metal1 
box 22.25um 10.75um 22.89um 10.11um
paint mvpdiffusion 
box 22.25um 10.75um 22.56um 10.44um
erase mvpdiffusion 
box 22.31um 10.69um 22.89um 10.11um
paint locali 
box 22.31um 10.69um 22.54um 10.46um
erase locali 
box 22.28um 10.72um 22.89um 10.11um
paint metal1 
box 22.28um 10.72um 22.56um 10.44um
erase metal1 
box 27.25um 5.75um 26.61um 6.39um
paint mvpdiffusion 
box 27.25um 5.75um 26.94um 6.06um
erase mvpdiffusion 
box 27.19um 5.81um 26.61um 6.39um
paint locali 
box 27.19um 5.81um 26.96um 6.04um
erase locali 
box 27.22um 5.78um 26.61um 6.39um
paint metal1 
box 27.22um 5.78um 26.94um 6.06um
erase metal1 
box 27.25um 10.75um 26.61um 10.11um
paint mvpdiffusion 
box 27.25um 10.75um 26.94um 10.44um
erase mvpdiffusion 
box 27.19um 10.69um 26.61um 10.11um
paint locali 
box 27.19um 10.69um 26.96um 10.46um
erase locali 
box 27.22um 10.72um 26.61um 10.11um
paint metal1 
box 27.22um 10.72um 26.94um 10.44um
erase metal1 
box 24.75um 11um 24.75um 11um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 22um 13.75um 22um 13.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 22.25um 11.25um 22.89um 11.89um
paint mvpdiffusion 
box 22.25um 11.25um 22.56um 11.56um
erase mvpdiffusion 
box 22.31um 11.31um 22.89um 11.89um
paint locali 
box 22.31um 11.31um 22.54um 11.54um
erase locali 
box 22.28um 11.28um 22.89um 11.89um
paint metal1 
box 22.28um 11.28um 22.56um 11.56um
erase metal1 
box 22.25um 16.25um 22.89um 15.61um
paint mvpdiffusion 
box 22.25um 16.25um 22.56um 15.94um
erase mvpdiffusion 
box 22.31um 16.19um 22.89um 15.61um
paint locali 
box 22.31um 16.19um 22.54um 15.96um
erase locali 
box 22.28um 16.22um 22.89um 15.61um
paint metal1 
box 22.28um 16.22um 22.56um 15.94um
erase metal1 
box 27.25um 11.25um 26.61um 11.89um
paint mvpdiffusion 
box 27.25um 11.25um 26.94um 11.56um
erase mvpdiffusion 
box 27.19um 11.31um 26.61um 11.89um
paint locali 
box 27.19um 11.31um 26.96um 11.54um
erase locali 
box 27.22um 11.28um 26.61um 11.89um
paint metal1 
box 27.22um 11.28um 26.94um 11.56um
erase metal1 
box 27.25um 16.25um 26.61um 15.61um
paint mvpdiffusion 
box 27.25um 16.25um 26.94um 15.94um
erase mvpdiffusion 
box 27.19um 16.19um 26.61um 15.61um
paint locali 
box 27.19um 16.19um 26.96um 15.96um
erase locali 
box 27.22um 16.22um 26.61um 15.61um
paint metal1 
box 27.22um 16.22um 26.94um 15.94um
erase metal1 
box 24.75um 16.5um 24.75um 16.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 22um 19.25um 22um 19.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 22.25um 16.75um 22.89um 17.39um
paint mvpdiffusion 
box 22.25um 16.75um 22.56um 17.06um
erase mvpdiffusion 
box 22.31um 16.81um 22.89um 17.39um
paint locali 
box 22.31um 16.81um 22.54um 17.04um
erase locali 
box 22.28um 16.78um 22.89um 17.39um
paint metal1 
box 22.28um 16.78um 22.56um 17.06um
erase metal1 
box 22.25um 21.75um 22.89um 21.11um
paint mvpdiffusion 
box 22.25um 21.75um 22.56um 21.44um
erase mvpdiffusion 
box 22.31um 21.69um 22.89um 21.11um
paint locali 
box 22.31um 21.69um 22.54um 21.46um
erase locali 
box 22.28um 21.72um 22.89um 21.11um
paint metal1 
box 22.28um 21.72um 22.56um 21.44um
erase metal1 
box 27.25um 16.75um 26.61um 17.39um
paint mvpdiffusion 
box 27.25um 16.75um 26.94um 17.06um
erase mvpdiffusion 
box 27.19um 16.81um 26.61um 17.39um
paint locali 
box 27.19um 16.81um 26.96um 17.04um
erase locali 
box 27.22um 16.78um 26.61um 17.39um
paint metal1 
box 27.22um 16.78um 26.94um 17.06um
erase metal1 
box 27.25um 21.75um 26.61um 21.11um
paint mvpdiffusion 
box 27.25um 21.75um 26.94um 21.44um
erase mvpdiffusion 
box 27.19um 21.69um 26.61um 21.11um
paint locali 
box 27.19um 21.69um 26.96um 21.46um
erase locali 
box 27.22um 21.72um 26.61um 21.11um
paint metal1 
box 27.22um 21.72um 26.94um 21.44um
erase metal1 
box 24.75um 22um 24.75um 22um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 22um 24.75um 22um 24.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 22.25um 22.25um 22.89um 22.89um
paint mvpdiffusion 
box 22.25um 22.25um 22.56um 22.56um
erase mvpdiffusion 
box 22.31um 22.31um 22.89um 22.89um
paint locali 
box 22.31um 22.31um 22.54um 22.54um
erase locali 
box 22.28um 22.28um 22.89um 22.89um
paint metal1 
box 22.28um 22.28um 22.56um 22.56um
erase metal1 
box 22.25um 27.25um 22.89um 26.61um
paint mvpdiffusion 
box 22.25um 27.25um 22.56um 26.94um
erase mvpdiffusion 
box 22.31um 27.19um 22.89um 26.61um
paint locali 
box 22.31um 27.19um 22.54um 26.96um
erase locali 
box 22.28um 27.22um 22.89um 26.61um
paint metal1 
box 22.28um 27.22um 22.56um 26.94um
erase metal1 
box 27.25um 22.25um 26.61um 22.89um
paint mvpdiffusion 
box 27.25um 22.25um 26.94um 22.56um
erase mvpdiffusion 
box 27.19um 22.31um 26.61um 22.89um
paint locali 
box 27.19um 22.31um 26.96um 22.54um
erase locali 
box 27.22um 22.28um 26.61um 22.89um
paint metal1 
box 27.22um 22.28um 26.94um 22.56um
erase metal1 
box 27.25um 27.25um 26.61um 26.61um
paint mvpdiffusion 
box 27.25um 27.25um 26.94um 26.94um
erase mvpdiffusion 
box 27.19um 27.19um 26.61um 26.61um
paint locali 
box 27.19um 27.19um 26.96um 26.96um
erase locali 
box 27.22um 27.22um 26.61um 26.61um
paint metal1 
box 27.22um 27.22um 26.94um 26.94um
erase metal1 
box 24.75um 27.5um 24.75um 27.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 22um 30.25um 22um 30.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 22.25um 27.75um 22.89um 28.39um
paint mvpdiffusion 
box 22.25um 27.75um 22.56um 28.06um
erase mvpdiffusion 
box 22.31um 27.81um 22.89um 28.39um
paint locali 
box 22.31um 27.81um 22.54um 28.04um
erase locali 
box 22.28um 27.78um 22.89um 28.39um
paint metal1 
box 22.28um 27.78um 22.56um 28.06um
erase metal1 
box 27.25um 27.75um 26.61um 28.39um
paint mvpdiffusion 
box 27.25um 27.75um 26.94um 28.06um
erase mvpdiffusion 
box 27.19um 27.81um 26.61um 28.39um
paint locali 
box 27.19um 27.81um 26.96um 28.04um
erase locali 
box 27.22um 27.78um 26.61um 28.39um
paint metal1 
box 27.22um 27.78um 26.94um 28.06um
erase metal1 
box 27.5um 2.75um 27.5um 2.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 27.75um 5.25um 28.39um 4.61um
paint mvpdiffusion 
box 27.75um 5.25um 28.06um 4.94um
erase mvpdiffusion 
box 27.81um 5.19um 28.39um 4.61um
paint locali 
box 27.81um 5.19um 28.04um 4.96um
erase locali 
box 27.78um 5.22um 28.39um 4.61um
paint metal1 
box 27.78um 5.22um 28.06um 4.94um
erase metal1 
box 30.25um 5.5um 30.25um 5.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 27.5um 8.25um 27.5um 8.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 27.75um 5.75um 28.39um 6.39um
paint mvpdiffusion 
box 27.75um 5.75um 28.06um 6.06um
erase mvpdiffusion 
box 27.81um 5.81um 28.39um 6.39um
paint locali 
box 27.81um 5.81um 28.04um 6.04um
erase locali 
box 27.78um 5.78um 28.39um 6.39um
paint metal1 
box 27.78um 5.78um 28.06um 6.06um
erase metal1 
box 27.75um 10.75um 28.39um 10.11um
paint mvpdiffusion 
box 27.75um 10.75um 28.06um 10.44um
erase mvpdiffusion 
box 27.81um 10.69um 28.39um 10.11um
paint locali 
box 27.81um 10.69um 28.04um 10.46um
erase locali 
box 27.78um 10.72um 28.39um 10.11um
paint metal1 
box 27.78um 10.72um 28.06um 10.44um
erase metal1 
box 30.25um 11um 30.25um 11um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 27.5um 13.75um 27.5um 13.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 27.75um 11.25um 28.39um 11.89um
paint mvpdiffusion 
box 27.75um 11.25um 28.06um 11.56um
erase mvpdiffusion 
box 27.81um 11.31um 28.39um 11.89um
paint locali 
box 27.81um 11.31um 28.04um 11.54um
erase locali 
box 27.78um 11.28um 28.39um 11.89um
paint metal1 
box 27.78um 11.28um 28.06um 11.56um
erase metal1 
box 27.75um 16.25um 28.39um 15.61um
paint mvpdiffusion 
box 27.75um 16.25um 28.06um 15.94um
erase mvpdiffusion 
box 27.81um 16.19um 28.39um 15.61um
paint locali 
box 27.81um 16.19um 28.04um 15.96um
erase locali 
box 27.78um 16.22um 28.39um 15.61um
paint metal1 
box 27.78um 16.22um 28.06um 15.94um
erase metal1 
box 30.25um 16.5um 30.25um 16.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 27.5um 19.25um 27.5um 19.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 27.75um 16.75um 28.39um 17.39um
paint mvpdiffusion 
box 27.75um 16.75um 28.06um 17.06um
erase mvpdiffusion 
box 27.81um 16.81um 28.39um 17.39um
paint locali 
box 27.81um 16.81um 28.04um 17.04um
erase locali 
box 27.78um 16.78um 28.39um 17.39um
paint metal1 
box 27.78um 16.78um 28.06um 17.06um
erase metal1 
box 27.75um 21.75um 28.39um 21.11um
paint mvpdiffusion 
box 27.75um 21.75um 28.06um 21.44um
erase mvpdiffusion 
box 27.81um 21.69um 28.39um 21.11um
paint locali 
box 27.81um 21.69um 28.04um 21.46um
erase locali 
box 27.78um 21.72um 28.39um 21.11um
paint metal1 
box 27.78um 21.72um 28.06um 21.44um
erase metal1 
box 30.25um 22um 30.25um 22um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 27.5um 24.75um 27.5um 24.75um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 27.75um 22.25um 28.39um 22.89um
paint mvpdiffusion 
box 27.75um 22.25um 28.06um 22.56um
erase mvpdiffusion 
box 27.81um 22.31um 28.39um 22.89um
paint locali 
box 27.81um 22.31um 28.04um 22.54um
erase locali 
box 27.78um 22.28um 28.39um 22.89um
paint metal1 
box 27.78um 22.28um 28.06um 22.56um
erase metal1 
box 27.75um 27.25um 28.39um 26.61um
paint mvpdiffusion 
box 27.75um 27.25um 28.06um 26.94um
erase mvpdiffusion 
box 27.81um 27.19um 28.39um 26.61um
paint locali 
box 27.81um 27.19um 28.04um 26.96um
erase locali 
box 27.78um 27.22um 28.39um 26.61um
paint metal1 
box 27.78um 27.22um 28.06um 26.94um
erase metal1 
box 30.25um 27.5um 30.25um 27.5um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
rotate 90
shift_to_center
box 27.5um 30.25um 27.5um 30.25um
getcell sky130_fd_pr__pfet_g5v0d10v5_W4_38_L0_5.mag
shift_to_center
box 27.75um 27.75um 28.39um 28.39um
paint mvpdiffusion 
box 27.75um 27.75um 28.06um 28.06um
erase mvpdiffusion 
box 27.81um 27.81um 28.39um 28.39um
paint locali 
box 27.81um 27.81um 28.04um 28.04um
erase locali 
box 27.78um 27.78um 28.39um 28.39um
paint metal1 
box 27.78um 27.78um 28.06um 28.06um
erase metal1 
box 0.51um 0.51um 4.99um 4.99um
paint metal1 
box 1um 1um 4.5um 4.5um
paint metal2 
box 1.1um 1.1um 4.4um 4.4um
paint m2contact 
wire segment metal3 2.2um 0um 5.5um 5.5um 0um -noendcap 
wire segment metal4 2.2um 0um 5.5um 5.5um 0um -noendcap 
wire segment metal5 2.2um 0um 5.5um 5.5um 0um -noendcap 
box 2.15um 2.15um 3.35um 3.35um
paint via4 
paint via3 
paint m3contact 
box 0.51um 6.01um 4.99um 10.49um
paint metal1 
box 1um 6.5um 4.5um 10um
paint metal2 
box 1.1um 6.6um 4.4um 9.9um
paint m2contact 
wire segment metal3 2.2um 0um 11um 5.5um 5.5um -noendcap 
wire segment metal4 2.2um 0um 11um 5.5um 5.5um -noendcap 
wire segment metal5 2.2um 0um 11um 5.5um 5.5um -noendcap 
box 2.15um 7.65um 3.35um 8.85um
paint via4 
paint via3 
paint m3contact 
box 0.51um 11.51um 4.99um 15.99um
paint metal1 
box 1um 12um 4.5um 15.5um
paint metal2 
box 1.1um 12.1um 4.4um 15.4um
paint m2contact 
wire segment metal3 2.2um 0um 16.5um 5.5um 11um -noendcap 
wire segment metal4 2.2um 0um 16.5um 5.5um 11um -noendcap 
wire segment metal5 2.2um 0um 16.5um 5.5um 11um -noendcap 
box 2.15um 13.15um 3.35um 14.35um
paint via4 
paint via3 
paint m3contact 
box 0.51um 17.01um 4.99um 21.49um
paint metal1 
box 1um 17.5um 4.5um 21um
paint metal2 
box 1.1um 17.6um 4.4um 20.9um
paint m2contact 
wire segment metal3 2.2um 0um 22um 5.5um 16.5um -noendcap 
wire segment metal4 2.2um 0um 22um 5.5um 16.5um -noendcap 
wire segment metal5 2.2um 0um 22um 5.5um 16.5um -noendcap 
box 2.15um 18.65um 3.35um 19.85um
paint via4 
paint via3 
paint m3contact 
box 0.51um 22.51um 4.99um 26.99um
paint metal1 
box 1um 23um 4.5um 26.5um
paint metal2 
box 1.1um 23.1um 4.4um 26.4um
paint m2contact 
wire segment metal3 2.2um 0um 27.5um 5.5um 22um -noendcap 
wire segment metal4 2.2um 0um 27.5um 5.5um 22um -noendcap 
wire segment metal5 2.2um 0um 27.5um 5.5um 22um -noendcap 
box 2.15um 24.15um 3.35um 25.35um
paint via4 
paint via3 
paint m3contact 
box 0.51um 28.01um 4.99um 32.49um
paint metal1 
box 1um 28.5um 4.5um 32um
paint metal2 
box 1.1um 28.6um 4.4um 31.9um
paint m2contact 
wire segment metal3 2.2um 0um 33um 5.5um 27.5um -noendcap 
wire segment metal4 2.2um 0um 33um 5.5um 27.5um -noendcap 
wire segment metal5 2.2um 0um 33um 5.5um 27.5um -noendcap 
box 2.15um 29.65um 3.35um 30.85um
paint via4 
paint via3 
paint m3contact 
box 6.01um 0.51um 10.49um 4.99um
paint metal1 
box 6.5um 1um 10um 4.5um
paint metal2 
box 6.6um 1.1um 9.9um 4.4um
paint m2contact 
wire segment metal3 2.2um 5.5um 5.5um 11um 0um -noendcap 
wire segment metal4 2.2um 5.5um 5.5um 11um 0um -noendcap 
wire segment metal5 2.2um 5.5um 5.5um 11um 0um -noendcap 
box 7.65um 2.15um 8.85um 3.35um
paint via4 
paint via3 
paint m3contact 
box 6.01um 6.01um 10.49um 10.49um
paint metal1 
box 6.5um 6.5um 10um 10um
paint metal2 
box 6.6um 6.6um 9.9um 9.9um
paint m2contact 
wire segment metal3 2.2um 5.5um 11um 11um 5.5um -noendcap 
wire segment metal4 2.2um 5.5um 11um 11um 5.5um -noendcap 
wire segment metal5 2.2um 5.5um 11um 11um 5.5um -noendcap 
box 7.65um 7.65um 8.85um 8.85um
paint via4 
paint via3 
paint m3contact 
box 6.01um 11.51um 10.49um 15.99um
paint metal1 
box 6.5um 12um 10um 15.5um
paint metal2 
box 6.6um 12.1um 9.9um 15.4um
paint m2contact 
wire segment metal3 2.2um 5.5um 16.5um 11um 11um -noendcap 
wire segment metal4 2.2um 5.5um 16.5um 11um 11um -noendcap 
wire segment metal5 2.2um 5.5um 16.5um 11um 11um -noendcap 
box 7.65um 13.15um 8.85um 14.35um
paint via4 
paint via3 
paint m3contact 
box 6.01um 17.01um 10.49um 21.49um
paint metal1 
box 6.5um 17.5um 10um 21um
paint metal2 
box 6.6um 17.6um 9.9um 20.9um
paint m2contact 
wire segment metal3 2.2um 5.5um 22um 11um 16.5um -noendcap 
wire segment metal4 2.2um 5.5um 22um 11um 16.5um -noendcap 
wire segment metal5 2.2um 5.5um 22um 11um 16.5um -noendcap 
box 7.65um 18.65um 8.85um 19.85um
paint via4 
paint via3 
paint m3contact 
box 6.01um 22.51um 10.49um 26.99um
paint metal1 
box 6.5um 23um 10um 26.5um
paint metal2 
box 6.6um 23.1um 9.9um 26.4um
paint m2contact 
wire segment metal3 2.2um 5.5um 27.5um 11um 22um -noendcap 
wire segment metal4 2.2um 5.5um 27.5um 11um 22um -noendcap 
wire segment metal5 2.2um 5.5um 27.5um 11um 22um -noendcap 
box 7.65um 24.15um 8.85um 25.35um
paint via4 
paint via3 
paint m3contact 
box 6.01um 28.01um 10.49um 32.49um
paint metal1 
box 6.5um 28.5um 10um 32um
paint metal2 
box 6.6um 28.6um 9.9um 31.9um
paint m2contact 
wire segment metal3 2.2um 5.5um 33um 11um 27.5um -noendcap 
wire segment metal4 2.2um 5.5um 33um 11um 27.5um -noendcap 
wire segment metal5 2.2um 5.5um 33um 11um 27.5um -noendcap 
box 7.65um 29.65um 8.85um 30.85um
paint via4 
paint via3 
paint m3contact 
box 11.51um 0.51um 15.99um 4.99um
paint metal1 
box 12um 1um 15.5um 4.5um
paint metal2 
box 12.1um 1.1um 15.4um 4.4um
paint m2contact 
wire segment metal3 2.2um 11um 5.5um 16.5um 0um -noendcap 
wire segment metal4 2.2um 11um 5.5um 16.5um 0um -noendcap 
wire segment metal5 2.2um 11um 5.5um 16.5um 0um -noendcap 
box 13.15um 2.15um 14.35um 3.35um
paint via4 
paint via3 
paint m3contact 
box 11.51um 6.01um 15.99um 10.49um
paint metal1 
box 12um 6.5um 15.5um 10um
paint metal2 
box 12.1um 6.6um 15.4um 9.9um
paint m2contact 
wire segment metal3 2.2um 11um 11um 16.5um 5.5um -noendcap 
wire segment metal4 2.2um 11um 11um 16.5um 5.5um -noendcap 
wire segment metal5 2.2um 11um 11um 16.5um 5.5um -noendcap 
box 13.15um 7.65um 14.35um 8.85um
paint via4 
paint via3 
paint m3contact 
box 11.51um 11.51um 15.99um 15.99um
paint metal1 
box 12um 12um 15.5um 15.5um
paint metal2 
box 12.1um 12.1um 15.4um 15.4um
paint m2contact 
wire segment metal3 2.2um 11um 16.5um 16.5um 11um -noendcap 
wire segment metal4 2.2um 11um 16.5um 16.5um 11um -noendcap 
wire segment metal5 2.2um 11um 16.5um 16.5um 11um -noendcap 
box 13.15um 13.15um 14.35um 14.35um
paint via4 
paint via3 
paint m3contact 
box 11.51um 17.01um 15.99um 21.49um
paint metal1 
box 12um 17.5um 15.5um 21um
paint metal2 
box 12.1um 17.6um 15.4um 20.9um
paint m2contact 
wire segment metal3 2.2um 11um 22um 16.5um 16.5um -noendcap 
wire segment metal4 2.2um 11um 22um 16.5um 16.5um -noendcap 
wire segment metal5 2.2um 11um 22um 16.5um 16.5um -noendcap 
box 13.15um 18.65um 14.35um 19.85um
paint via4 
paint via3 
paint m3contact 
box 11.51um 22.51um 15.99um 26.99um
paint metal1 
box 12um 23um 15.5um 26.5um
paint metal2 
box 12.1um 23.1um 15.4um 26.4um
paint m2contact 
wire segment metal3 2.2um 11um 27.5um 16.5um 22um -noendcap 
wire segment metal4 2.2um 11um 27.5um 16.5um 22um -noendcap 
wire segment metal5 2.2um 11um 27.5um 16.5um 22um -noendcap 
box 13.15um 24.15um 14.35um 25.35um
paint via4 
paint via3 
paint m3contact 
box 11.51um 28.01um 15.99um 32.49um
paint metal1 
box 12um 28.5um 15.5um 32um
paint metal2 
box 12.1um 28.6um 15.4um 31.9um
paint m2contact 
wire segment metal3 2.2um 11um 33um 16.5um 27.5um -noendcap 
wire segment metal4 2.2um 11um 33um 16.5um 27.5um -noendcap 
wire segment metal5 2.2um 11um 33um 16.5um 27.5um -noendcap 
box 13.15um 29.65um 14.35um 30.85um
paint via4 
paint via3 
paint m3contact 
box 17.01um 0.51um 21.49um 4.99um
paint metal1 
box 17.5um 1um 21um 4.5um
paint metal2 
box 17.6um 1.1um 20.9um 4.4um
paint m2contact 
wire segment metal3 2.2um 16.5um 5.5um 22um 0um -noendcap 
wire segment metal4 2.2um 16.5um 5.5um 22um 0um -noendcap 
wire segment metal5 2.2um 16.5um 5.5um 22um 0um -noendcap 
box 18.65um 2.15um 19.85um 3.35um
paint via4 
paint via3 
paint m3contact 
box 17.01um 6.01um 21.49um 10.49um
paint metal1 
box 17.5um 6.5um 21um 10um
paint metal2 
box 17.6um 6.6um 20.9um 9.9um
paint m2contact 
wire segment metal3 2.2um 16.5um 11um 22um 5.5um -noendcap 
wire segment metal4 2.2um 16.5um 11um 22um 5.5um -noendcap 
wire segment metal5 2.2um 16.5um 11um 22um 5.5um -noendcap 
box 18.65um 7.65um 19.85um 8.85um
paint via4 
paint via3 
paint m3contact 
box 17.01um 11.51um 21.49um 15.99um
paint metal1 
box 17.5um 12um 21um 15.5um
paint metal2 
box 17.6um 12.1um 20.9um 15.4um
paint m2contact 
wire segment metal3 2.2um 16.5um 16.5um 22um 11um -noendcap 
wire segment metal4 2.2um 16.5um 16.5um 22um 11um -noendcap 
wire segment metal5 2.2um 16.5um 16.5um 22um 11um -noendcap 
box 18.65um 13.15um 19.85um 14.35um
paint via4 
paint via3 
paint m3contact 
box 17.01um 17.01um 21.49um 21.49um
paint metal1 
box 17.5um 17.5um 21um 21um
paint metal2 
box 17.6um 17.6um 20.9um 20.9um
paint m2contact 
wire segment metal3 2.2um 16.5um 22um 22um 16.5um -noendcap 
wire segment metal4 2.2um 16.5um 22um 22um 16.5um -noendcap 
wire segment metal5 2.2um 16.5um 22um 22um 16.5um -noendcap 
box 18.65um 18.65um 19.85um 19.85um
paint via4 
paint via3 
paint m3contact 
box 17.01um 22.51um 21.49um 26.99um
paint metal1 
box 17.5um 23um 21um 26.5um
paint metal2 
box 17.6um 23.1um 20.9um 26.4um
paint m2contact 
wire segment metal3 2.2um 16.5um 27.5um 22um 22um -noendcap 
wire segment metal4 2.2um 16.5um 27.5um 22um 22um -noendcap 
wire segment metal5 2.2um 16.5um 27.5um 22um 22um -noendcap 
box 18.65um 24.15um 19.85um 25.35um
paint via4 
paint via3 
paint m3contact 
box 17.01um 28.01um 21.49um 32.49um
paint metal1 
box 17.5um 28.5um 21um 32um
paint metal2 
box 17.6um 28.6um 20.9um 31.9um
paint m2contact 
wire segment metal3 2.2um 16.5um 33um 22um 27.5um -noendcap 
wire segment metal4 2.2um 16.5um 33um 22um 27.5um -noendcap 
wire segment metal5 2.2um 16.5um 33um 22um 27.5um -noendcap 
box 18.65um 29.65um 19.85um 30.85um
paint via4 
paint via3 
paint m3contact 
box 22.51um 0.51um 26.99um 4.99um
paint metal1 
box 23um 1um 26.5um 4.5um
paint metal2 
box 23.1um 1.1um 26.4um 4.4um
paint m2contact 
wire segment metal3 2.2um 22um 5.5um 27.5um 0um -noendcap 
wire segment metal4 2.2um 22um 5.5um 27.5um 0um -noendcap 
wire segment metal5 2.2um 22um 5.5um 27.5um 0um -noendcap 
box 24.15um 2.15um 25.35um 3.35um
paint via4 
paint via3 
paint m3contact 
box 22.51um 6.01um 26.99um 10.49um
paint metal1 
box 23um 6.5um 26.5um 10um
paint metal2 
box 23.1um 6.6um 26.4um 9.9um
paint m2contact 
wire segment metal3 2.2um 22um 11um 27.5um 5.5um -noendcap 
wire segment metal4 2.2um 22um 11um 27.5um 5.5um -noendcap 
wire segment metal5 2.2um 22um 11um 27.5um 5.5um -noendcap 
box 24.15um 7.65um 25.35um 8.85um
paint via4 
paint via3 
paint m3contact 
box 22.51um 11.51um 26.99um 15.99um
paint metal1 
box 23um 12um 26.5um 15.5um
paint metal2 
box 23.1um 12.1um 26.4um 15.4um
paint m2contact 
wire segment metal3 2.2um 22um 16.5um 27.5um 11um -noendcap 
wire segment metal4 2.2um 22um 16.5um 27.5um 11um -noendcap 
wire segment metal5 2.2um 22um 16.5um 27.5um 11um -noendcap 
box 24.15um 13.15um 25.35um 14.35um
paint via4 
paint via3 
paint m3contact 
box 22.51um 17.01um 26.99um 21.49um
paint metal1 
box 23um 17.5um 26.5um 21um
paint metal2 
box 23.1um 17.6um 26.4um 20.9um
paint m2contact 
wire segment metal3 2.2um 22um 22um 27.5um 16.5um -noendcap 
wire segment metal4 2.2um 22um 22um 27.5um 16.5um -noendcap 
wire segment metal5 2.2um 22um 22um 27.5um 16.5um -noendcap 
box 24.15um 18.65um 25.35um 19.85um
paint via4 
paint via3 
paint m3contact 
box 22.51um 22.51um 26.99um 26.99um
paint metal1 
box 23um 23um 26.5um 26.5um
paint metal2 
box 23.1um 23.1um 26.4um 26.4um
paint m2contact 
wire segment metal3 2.2um 22um 27.5um 27.5um 22um -noendcap 
wire segment metal4 2.2um 22um 27.5um 27.5um 22um -noendcap 
wire segment metal5 2.2um 22um 27.5um 27.5um 22um -noendcap 
box 24.15um 24.15um 25.35um 25.35um
paint via4 
paint via3 
paint m3contact 
box 22.51um 28.01um 26.99um 32.49um
paint metal1 
box 23um 28.5um 26.5um 32um
paint metal2 
box 23.1um 28.6um 26.4um 31.9um
paint m2contact 
wire segment metal3 2.2um 22um 33um 27.5um 27.5um -noendcap 
wire segment metal4 2.2um 22um 33um 27.5um 27.5um -noendcap 
wire segment metal5 2.2um 22um 33um 27.5um 27.5um -noendcap 
box 24.15um 29.65um 25.35um 30.85um
paint via4 
paint via3 
paint m3contact 
box 28.01um 0.51um 32.49um 4.99um
paint metal1 
box 28.5um 1um 32um 4.5um
paint metal2 
box 28.6um 1.1um 31.9um 4.4um
paint m2contact 
wire segment metal3 2.2um 27.5um 5.5um 33um 0um -noendcap 
wire segment metal4 2.2um 27.5um 5.5um 33um 0um -noendcap 
wire segment metal5 2.2um 27.5um 5.5um 33um 0um -noendcap 
box 29.65um 2.15um 30.85um 3.35um
paint via4 
paint via3 
paint m3contact 
box 28.01um 6.01um 32.49um 10.49um
paint metal1 
box 28.5um 6.5um 32um 10um
paint metal2 
box 28.6um 6.6um 31.9um 9.9um
paint m2contact 
wire segment metal3 2.2um 27.5um 11um 33um 5.5um -noendcap 
wire segment metal4 2.2um 27.5um 11um 33um 5.5um -noendcap 
wire segment metal5 2.2um 27.5um 11um 33um 5.5um -noendcap 
box 29.65um 7.65um 30.85um 8.85um
paint via4 
paint via3 
paint m3contact 
box 28.01um 11.51um 32.49um 15.99um
paint metal1 
box 28.5um 12um 32um 15.5um
paint metal2 
box 28.6um 12.1um 31.9um 15.4um
paint m2contact 
wire segment metal3 2.2um 27.5um 16.5um 33um 11um -noendcap 
wire segment metal4 2.2um 27.5um 16.5um 33um 11um -noendcap 
wire segment metal5 2.2um 27.5um 16.5um 33um 11um -noendcap 
box 29.65um 13.15um 30.85um 14.35um
paint via4 
paint via3 
paint m3contact 
box 28.01um 17.01um 32.49um 21.49um
paint metal1 
box 28.5um 17.5um 32um 21um
paint metal2 
box 28.6um 17.6um 31.9um 20.9um
paint m2contact 
wire segment metal3 2.2um 27.5um 22um 33um 16.5um -noendcap 
wire segment metal4 2.2um 27.5um 22um 33um 16.5um -noendcap 
wire segment metal5 2.2um 27.5um 22um 33um 16.5um -noendcap 
box 29.65um 18.65um 30.85um 19.85um
paint via4 
paint via3 
paint m3contact 
box 28.01um 22.51um 32.49um 26.99um
paint metal1 
box 28.5um 23um 32um 26.5um
paint metal2 
box 28.6um 23.1um 31.9um 26.4um
paint m2contact 
wire segment metal3 2.2um 27.5um 27.5um 33um 22um -noendcap 
wire segment metal4 2.2um 27.5um 27.5um 33um 22um -noendcap 
wire segment metal5 2.2um 27.5um 27.5um 33um 22um -noendcap 
box 29.65um 24.15um 30.85um 25.35um
paint via4 
paint via3 
paint m3contact 
box 28.01um 28.01um 32.49um 32.49um
paint metal1 
box 28.5um 28.5um 32um 32um
paint metal2 
box 28.6um 28.6um 31.9um 31.9um
paint m2contact 
wire segment metal3 2.2um 27.5um 33um 33um 27.5um -noendcap 
wire segment metal4 2.2um 27.5um 33um 33um 27.5um -noendcap 
wire segment metal5 2.2um 27.5um 33um 33um 27.5um -noendcap 
box 29.65um 29.65um 30.85um 30.85um
paint via4 
paint via3 
paint m3contact 
box -0.25um -0.25um 0.25um 33.25um
paint poly 
paint metal2 
box 5.25um -0.25um 5.75um 33.25um
paint poly 
paint metal2 
box 10.75um -0.25um 11.25um 33.25um
paint poly 
paint metal2 
box 16.25um -0.25um 16.75um 33.25um
paint poly 
paint metal2 
box 21.75um -0.25um 22.25um 33.25um
paint poly 
paint metal2 
box 27.25um -0.25um 27.75um 33.25um
paint poly 
paint metal2 
box 32.75um -0.25um 33.25um 33.25um
paint poly 
paint metal2 
box -0.25um -0.25um 33.25um 0.25um
paint poly 
paint metal2 
box -0.25um 5.25um 33.25um 5.75um
paint poly 
paint metal2 
box -0.25um 10.75um 33.25um 11.25um
paint poly 
paint metal2 
box -0.25um 16.25um 33.25um 16.75um
paint poly 
paint metal2 
box -0.25um 21.75um 33.25um 22.25um
paint poly 
paint metal2 
box -0.25um 27.25um 33.25um 27.75um
paint poly 
paint metal2 
box -0.25um 32.75um 33.25um 33.25um
paint poly 
paint metal2 
box -0.25um -0.25um 0.25um 0.25um
paint locali 
paint metal1 
paint metal2 
box -0.17um -0.17um 0.17um 0.17um
paint pcontact 
paint viali 
paint m2contact 
box -0.25um 5.25um 0.25um 5.75um
paint locali 
paint metal1 
paint metal2 
box -0.17um 5.33um 0.17um 5.67um
paint pcontact 
paint viali 
paint m2contact 
box -0.25um 10.75um 0.25um 11.25um
paint locali 
paint metal1 
paint metal2 
box -0.17um 10.83um 0.17um 11.17um
paint pcontact 
paint viali 
paint m2contact 
box -0.25um 16.25um 0.25um 16.75um
paint locali 
paint metal1 
paint metal2 
box -0.17um 16.33um 0.17um 16.67um
paint pcontact 
paint viali 
paint m2contact 
box -0.25um 21.75um 0.25um 22.25um
paint locali 
paint metal1 
paint metal2 
box -0.17um 21.83um 0.17um 22.17um
paint pcontact 
paint viali 
paint m2contact 
box -0.25um 27.25um 0.25um 27.75um
paint locali 
paint metal1 
paint metal2 
box -0.17um 27.33um 0.17um 27.67um
paint pcontact 
paint viali 
paint m2contact 
box -0.25um 32.75um 0.25um 33.25um
paint locali 
paint metal1 
paint metal2 
box -0.17um 32.83um 0.17um 33.17um
paint pcontact 
paint viali 
paint m2contact 
box 5.25um -0.25um 5.75um 0.25um
paint locali 
paint metal1 
paint metal2 
box 5.33um -0.17um 5.67um 0.17um
paint pcontact 
paint viali 
paint m2contact 
box 5.25um 5.25um 5.75um 5.75um
paint locali 
paint metal1 
paint metal2 
box 5.33um 5.33um 5.67um 5.67um
paint pcontact 
paint viali 
paint m2contact 
box 5.25um 10.75um 5.75um 11.25um
paint locali 
paint metal1 
paint metal2 
box 5.33um 10.83um 5.67um 11.17um
paint pcontact 
paint viali 
paint m2contact 
box 5.25um 16.25um 5.75um 16.75um
paint locali 
paint metal1 
paint metal2 
box 5.33um 16.33um 5.67um 16.67um
paint pcontact 
paint viali 
paint m2contact 
box 5.25um 21.75um 5.75um 22.25um
paint locali 
paint metal1 
paint metal2 
box 5.33um 21.83um 5.67um 22.17um
paint pcontact 
paint viali 
paint m2contact 
box 5.25um 27.25um 5.75um 27.75um
paint locali 
paint metal1 
paint metal2 
box 5.33um 27.33um 5.67um 27.67um
paint pcontact 
paint viali 
paint m2contact 
box 5.25um 32.75um 5.75um 33.25um
paint locali 
paint metal1 
paint metal2 
box 5.33um 32.83um 5.67um 33.17um
paint pcontact 
paint viali 
paint m2contact 
box 10.75um -0.25um 11.25um 0.25um
paint locali 
paint metal1 
paint metal2 
box 10.83um -0.17um 11.17um 0.17um
paint pcontact 
paint viali 
paint m2contact 
box 10.75um 5.25um 11.25um 5.75um
paint locali 
paint metal1 
paint metal2 
box 10.83um 5.33um 11.17um 5.67um
paint pcontact 
paint viali 
paint m2contact 
box 10.75um 10.75um 11.25um 11.25um
paint locali 
paint metal1 
paint metal2 
box 10.83um 10.83um 11.17um 11.17um
paint pcontact 
paint viali 
paint m2contact 
box 10.75um 16.25um 11.25um 16.75um
paint locali 
paint metal1 
paint metal2 
box 10.83um 16.33um 11.17um 16.67um
paint pcontact 
paint viali 
paint m2contact 
box 10.75um 21.75um 11.25um 22.25um
paint locali 
paint metal1 
paint metal2 
box 10.83um 21.83um 11.17um 22.17um
paint pcontact 
paint viali 
paint m2contact 
box 10.75um 27.25um 11.25um 27.75um
paint locali 
paint metal1 
paint metal2 
box 10.83um 27.33um 11.17um 27.67um
paint pcontact 
paint viali 
paint m2contact 
box 10.75um 32.75um 11.25um 33.25um
paint locali 
paint metal1 
paint metal2 
box 10.83um 32.83um 11.17um 33.17um
paint pcontact 
paint viali 
paint m2contact 
box 16.25um -0.25um 16.75um 0.25um
paint locali 
paint metal1 
paint metal2 
box 16.33um -0.17um 16.67um 0.17um
paint pcontact 
paint viali 
paint m2contact 
box 16.25um 5.25um 16.75um 5.75um
paint locali 
paint metal1 
paint metal2 
box 16.33um 5.33um 16.67um 5.67um
paint pcontact 
paint viali 
paint m2contact 
box 16.25um 10.75um 16.75um 11.25um
paint locali 
paint metal1 
paint metal2 
box 16.33um 10.83um 16.67um 11.17um
paint pcontact 
paint viali 
paint m2contact 
box 16.25um 16.25um 16.75um 16.75um
paint locali 
paint metal1 
paint metal2 
box 16.33um 16.33um 16.67um 16.67um
paint pcontact 
paint viali 
paint m2contact 
box 16.25um 21.75um 16.75um 22.25um
paint locali 
paint metal1 
paint metal2 
box 16.33um 21.83um 16.67um 22.17um
paint pcontact 
paint viali 
paint m2contact 
box 16.25um 27.25um 16.75um 27.75um
paint locali 
paint metal1 
paint metal2 
box 16.33um 27.33um 16.67um 27.67um
paint pcontact 
paint viali 
paint m2contact 
box 16.25um 32.75um 16.75um 33.25um
paint locali 
paint metal1 
paint metal2 
box 16.33um 32.83um 16.67um 33.17um
paint pcontact 
paint viali 
paint m2contact 
box 21.75um -0.25um 22.25um 0.25um
paint locali 
paint metal1 
paint metal2 
box 21.83um -0.17um 22.17um 0.17um
paint pcontact 
paint viali 
paint m2contact 
box 21.75um 5.25um 22.25um 5.75um
paint locali 
paint metal1 
paint metal2 
box 21.83um 5.33um 22.17um 5.67um
paint pcontact 
paint viali 
paint m2contact 
box 21.75um 10.75um 22.25um 11.25um
paint locali 
paint metal1 
paint metal2 
box 21.83um 10.83um 22.17um 11.17um
paint pcontact 
paint viali 
paint m2contact 
box 21.75um 16.25um 22.25um 16.75um
paint locali 
paint metal1 
paint metal2 
box 21.83um 16.33um 22.17um 16.67um
paint pcontact 
paint viali 
paint m2contact 
box 21.75um 21.75um 22.25um 22.25um
paint locali 
paint metal1 
paint metal2 
box 21.83um 21.83um 22.17um 22.17um
paint pcontact 
paint viali 
paint m2contact 
box 21.75um 27.25um 22.25um 27.75um
paint locali 
paint metal1 
paint metal2 
box 21.83um 27.33um 22.17um 27.67um
paint pcontact 
paint viali 
paint m2contact 
box 21.75um 32.75um 22.25um 33.25um
paint locali 
paint metal1 
paint metal2 
box 21.83um 32.83um 22.17um 33.17um
paint pcontact 
paint viali 
paint m2contact 
box 27.25um -0.25um 27.75um 0.25um
paint locali 
paint metal1 
paint metal2 
box 27.33um -0.17um 27.67um 0.17um
paint pcontact 
paint viali 
paint m2contact 
box 27.25um 5.25um 27.75um 5.75um
paint locali 
paint metal1 
paint metal2 
box 27.33um 5.33um 27.67um 5.67um
paint pcontact 
paint viali 
paint m2contact 
box 27.25um 10.75um 27.75um 11.25um
paint locali 
paint metal1 
paint metal2 
box 27.33um 10.83um 27.67um 11.17um
paint pcontact 
paint viali 
paint m2contact 
box 27.25um 16.25um 27.75um 16.75um
paint locali 
paint metal1 
paint metal2 
box 27.33um 16.33um 27.67um 16.67um
paint pcontact 
paint viali 
paint m2contact 
box 27.25um 21.75um 27.75um 22.25um
paint locali 
paint metal1 
paint metal2 
box 27.33um 21.83um 27.67um 22.17um
paint pcontact 
paint viali 
paint m2contact 
box 27.25um 27.25um 27.75um 27.75um
paint locali 
paint metal1 
paint metal2 
box 27.33um 27.33um 27.67um 27.67um
paint pcontact 
paint viali 
paint m2contact 
box 27.25um 32.75um 27.75um 33.25um
paint locali 
paint metal1 
paint metal2 
box 27.33um 32.83um 27.67um 33.17um
paint pcontact 
paint viali 
paint m2contact 
box 32.75um -0.25um 33.25um 0.25um
paint locali 
paint metal1 
paint metal2 
box 32.83um -0.17um 33.17um 0.17um
paint pcontact 
paint viali 
paint m2contact 
box 32.75um 5.25um 33.25um 5.75um
paint locali 
paint metal1 
paint metal2 
box 32.83um 5.33um 33.17um 5.67um
paint pcontact 
paint viali 
paint m2contact 
box 32.75um 10.75um 33.25um 11.25um
paint locali 
paint metal1 
paint metal2 
box 32.83um 10.83um 33.17um 11.17um
paint pcontact 
paint viali 
paint m2contact 
box 32.75um 16.25um 33.25um 16.75um
paint locali 
paint metal1 
paint metal2 
box 32.83um 16.33um 33.17um 16.67um
paint pcontact 
paint viali 
paint m2contact 
box 32.75um 21.75um 33.25um 22.25um
paint locali 
paint metal1 
paint metal2 
box 32.83um 21.83um 33.17um 22.17um
paint pcontact 
paint viali 
paint m2contact 
box 32.75um 27.25um 33.25um 27.75um
paint locali 
paint metal1 
paint metal2 
box 32.83um 27.33um 33.17um 27.67um
paint pcontact 
paint viali 
paint m2contact 
box 32.75um 32.75um 33.25um 33.25um
paint locali 
paint metal1 
paint metal2 
box 32.83um 32.83um 33.17um 33.17um
paint pcontact 
paint viali 
paint m2contact 
box 0.54um 0.54um 4.96um 4.96um
paint mvpdiffusion 
box 1.1um 1.1um 4.4um 4.4um
paint mvnsubdiff 
paint viali 
box 1.22um 1.22um 4.28um 4.28um
paint mvnsubdiffcont 
box 0.48um 0.48um 5.02um 5.02um
paint locali 
box 0.54um 11.54um 4.96um 15.96um
paint mvpdiffusion 
box 1.1um 12.1um 4.4um 15.4um
paint mvnsubdiff 
paint viali 
box 1.22um 12.22um 4.28um 15.28um
paint mvnsubdiffcont 
box 0.48um 11.48um 5.02um 16.02um
paint locali 
box 0.54um 22.54um 4.96um 26.96um
paint mvpdiffusion 
box 1.1um 23.1um 4.4um 26.4um
paint mvnsubdiff 
paint viali 
box 1.22um 23.22um 4.28um 26.28um
paint mvnsubdiffcont 
box 0.48um 22.48um 5.02um 27.02um
paint locali 
box 6.04um 6.04um 10.46um 10.46um
paint mvpdiffusion 
box 6.6um 6.6um 9.9um 9.9um
paint mvnsubdiff 
paint viali 
box 6.72um 6.72um 9.78um 9.78um
paint mvnsubdiffcont 
box 5.98um 5.98um 10.52um 10.52um
paint locali 
box 6.04um 17.04um 10.46um 21.46um
paint mvpdiffusion 
box 6.6um 17.6um 9.9um 20.9um
paint mvnsubdiff 
paint viali 
box 6.72um 17.72um 9.78um 20.78um
paint mvnsubdiffcont 
box 5.98um 16.98um 10.52um 21.52um
paint locali 
box 6.04um 28.04um 10.46um 32.46um
paint mvpdiffusion 
box 6.6um 28.6um 9.9um 31.9um
paint mvnsubdiff 
paint viali 
box 6.72um 28.72um 9.78um 31.78um
paint mvnsubdiffcont 
box 5.98um 27.98um 10.52um 32.52um
paint locali 
box 11.54um 0.54um 15.96um 4.96um
paint mvpdiffusion 
box 12.1um 1.1um 15.4um 4.4um
paint mvnsubdiff 
paint viali 
box 12.22um 1.22um 15.28um 4.28um
paint mvnsubdiffcont 
box 11.48um 0.48um 16.02um 5.02um
paint locali 
box 11.54um 11.54um 15.96um 15.96um
paint mvpdiffusion 
box 12.1um 12.1um 15.4um 15.4um
paint mvnsubdiff 
paint viali 
box 12.22um 12.22um 15.28um 15.28um
paint mvnsubdiffcont 
box 11.48um 11.48um 16.02um 16.02um
paint locali 
box 11.54um 22.54um 15.96um 26.96um
paint mvpdiffusion 
box 12.1um 23.1um 15.4um 26.4um
paint mvnsubdiff 
paint viali 
box 12.22um 23.22um 15.28um 26.28um
paint mvnsubdiffcont 
box 11.48um 22.48um 16.02um 27.02um
paint locali 
box 17.04um 6.04um 21.46um 10.46um
paint mvpdiffusion 
box 17.6um 6.6um 20.9um 9.9um
paint mvnsubdiff 
paint viali 
box 17.72um 6.72um 20.78um 9.78um
paint mvnsubdiffcont 
box 16.98um 5.98um 21.52um 10.52um
paint locali 
box 17.04um 17.04um 21.46um 21.46um
paint mvpdiffusion 
box 17.6um 17.6um 20.9um 20.9um
paint mvnsubdiff 
paint viali 
box 17.72um 17.72um 20.78um 20.78um
paint mvnsubdiffcont 
box 16.98um 16.98um 21.52um 21.52um
paint locali 
box 17.04um 28.04um 21.46um 32.46um
paint mvpdiffusion 
box 17.6um 28.6um 20.9um 31.9um
paint mvnsubdiff 
paint viali 
box 17.72um 28.72um 20.78um 31.78um
paint mvnsubdiffcont 
box 16.98um 27.98um 21.52um 32.52um
paint locali 
box 22.54um 0.54um 26.96um 4.96um
paint mvpdiffusion 
box 23.1um 1.1um 26.4um 4.4um
paint mvnsubdiff 
paint viali 
box 23.22um 1.22um 26.28um 4.28um
paint mvnsubdiffcont 
box 22.48um 0.48um 27.02um 5.02um
paint locali 
box 22.54um 11.54um 26.96um 15.96um
paint mvpdiffusion 
box 23.1um 12.1um 26.4um 15.4um
paint mvnsubdiff 
paint viali 
box 23.22um 12.22um 26.28um 15.28um
paint mvnsubdiffcont 
box 22.48um 11.48um 27.02um 16.02um
paint locali 
box 22.54um 22.54um 26.96um 26.96um
paint mvpdiffusion 
box 23.1um 23.1um 26.4um 26.4um
paint mvnsubdiff 
paint viali 
box 23.22um 23.22um 26.28um 26.28um
paint mvnsubdiffcont 
box 22.48um 22.48um 27.02um 27.02um
paint locali 
box 28.04um 6.04um 32.46um 10.46um
paint mvpdiffusion 
box 28.6um 6.6um 31.9um 9.9um
paint mvnsubdiff 
paint viali 
box 28.72um 6.72um 31.78um 9.78um
paint mvnsubdiffcont 
box 27.98um 5.98um 32.52um 10.52um
paint locali 
box 28.04um 17.04um 32.46um 21.46um
paint mvpdiffusion 
box 28.6um 17.6um 31.9um 20.9um
paint mvnsubdiff 
paint viali 
box 28.72um 17.72um 31.78um 20.78um
paint mvnsubdiffcont 
box 27.98um 16.98um 32.52um 21.52um
paint locali 
box 28.04um 28.04um 32.46um 32.46um
paint mvpdiffusion 
box 28.6um 28.6um 31.9um 31.9um
paint mvnsubdiff 
paint viali 
box 28.72um 28.72um 31.78um 31.78um
paint mvnsubdiffcont 
box 27.98um 27.98um 32.52um 32.52um
paint locali 
box -6um -6um 39um 39um
paint nwell 
box -5um -5um 38um -2um
paint mvnsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvnsubdiffcont 
paint viali 
box -5um 35um 38um 38um
paint mvnsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvnsubdiffcont 
paint viali 
box -5um -5um -2um 38um
paint mvnsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvnsubdiffcont 
paint viali 
box 35um -5um 38um 38um
paint mvnsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvnsubdiffcont 
paint viali 
box -24um -24um 57um -6um
paint pwell 
box -24um 39um 57um 57um
paint pwell 
box -24um -24um -6um 57um
paint pwell 
box 39um -24um 57um 57um
paint pwell 
box -20um -20um 53um -10um
paint mvpsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvpsubdiffcont 
paint viali 
box -20um -20um 53um -10um
paint mvpsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvpsubdiffcont 
paint viali 
box -20um 43um 53um 53um
paint mvpsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvpsubdiffcont 
paint viali 
box -20um -20um -10um 53um
paint mvpsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvpsubdiffcont 
paint viali 
box 43um -20um 53um 53um
paint mvpsubdiff 
paint locali 
paint metal1 
box shrink center 0.12um 
paint mvpsubdiffcont 
paint viali 
flatten mos_grid
load mos_grid
save
load temp2
box 0um 0um 0um 0um
getcell mos_grid
shift_to_center
move 16.5um 16.5um
box -5um 3.16782um 0.777817um 6.27782um
paint metal3 
paint metal4 
box -5um 3.16782um 0.777817um 6.27782um
paint metal5 
box -5um 8.66782um 0.777817um 11.7778um
paint metal3 
paint metal4 
box -5um 8.66782um 0.777817um 11.7778um
paint metal5 
box -5um 14.1678um 0.777817um 17.2778um
paint metal3 
paint metal4 
box -5um 14.1678um 0.777817um 17.2778um
paint metal5 
box -5um 19.6678um 0.777817um 22.7778um
paint metal3 
paint metal4 
box -5um 19.6678um 0.777817um 22.7778um
paint metal5 
box -5um 25.1678um 0.777817um 28.2778um
paint metal3 
paint metal4 
box -5um 25.1678um 0.777817um 28.2778um
paint metal5 
box -5um 30.6678um 0.777817um 33.7778um
paint metal3 
paint metal4 
box -5um 30.6678um 0.777817um 33.7778um
paint metal5 
box 3.16782um -5um 6.27782um 0.777817um
paint metal3 
paint metal4 
box 3.16782um -5um 6.27782um 0.777817um
paint metal5 
box 8.66782um -5um 11.7778um 0.777817um
paint metal3 
paint metal4 
box 8.66782um -5um 11.7778um 0.777817um
paint metal5 
box 14.1678um -5um 17.2778um 0.777817um
paint metal3 
paint metal4 
box 14.1678um -5um 17.2778um 0.777817um
paint metal5 
box 19.6678um -5um 22.7778um 0.777817um
paint metal3 
paint metal4 
box 19.6678um -5um 22.7778um 0.777817um
paint metal5 
box 25.1678um -5um 28.2778um 0.777817um
paint metal3 
paint metal4 
box 25.1678um -5um 28.2778um 0.777817um
paint metal5 
box 30.6678um -5um 33.7778um 0.777817um
paint metal3 
paint metal4 
box 30.6678um -5um 33.7778um 0.777817um
paint metal5 
box -0.777817um 32.2222um 2.33218um 38um
paint metal3 
paint metal4 
box -0.777817um 32.2222um 2.33218um 38um
paint metal5 
box 4.72218um 32.2222um 7.83218um 38um
paint metal3 
paint metal4 
box 4.72218um 32.2222um 7.83218um 38um
paint metal5 
box 10.2222um 32.2222um 13.3322um 38um
paint metal3 
paint metal4 
box 10.2222um 32.2222um 13.3322um 38um
paint metal5 
box 15.7222um 32.2222um 18.8322um 38um
paint metal3 
paint metal4 
box 15.7222um 32.2222um 18.8322um 38um
paint metal5 
box 21.2222um 32.2222um 24.3322um 38um
paint metal3 
paint metal4 
box 21.2222um 32.2222um 24.3322um 38um
paint metal5 
box 26.7222um 32.2222um 29.8322um 38um
paint metal3 
paint metal4 
box 26.7222um 32.2222um 29.8322um 38um
paint metal5 
box 32.2222um -0.777817um 38um 2.33218um
paint metal3 
paint metal4 
box 32.2222um -0.777817um 38um 2.33218um
paint metal5 
box 32.2222um 4.72218um 38um 7.83218um
paint metal3 
paint metal4 
box 32.2222um 4.72218um 38um 7.83218um
paint metal5 
box 32.2222um 10.2222um 38um 13.3322um
paint metal3 
paint metal4 
box 32.2222um 10.2222um 38um 13.3322um
paint metal5 
box 32.2222um 15.7222um 38um 18.8322um
paint metal3 
paint metal4 
box 32.2222um 15.7222um 38um 18.8322um
paint metal5 
box 32.2222um 21.2222um 38um 24.3322um
paint metal3 
paint metal4 
box 32.2222um 21.2222um 38um 24.3322um
paint metal5 
box 32.2222um 26.7222um 38um 29.8322um
paint metal3 
paint metal4 
box 32.2222um 26.7222um 38um 29.8322um
paint metal5 
box -3.5um 4.72282um -3.5um 4.72282um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box -3.5um 15.7228um -3.5um 15.7228um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box -3.5um 26.7228um -3.5um 26.7228um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 4.72282um -3.5um 4.72282um -3.5um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 15.7228um -3.5um 15.7228um -3.5um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 26.7228um -3.5um 26.7228um -3.5um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 36.5um 6.27718um 36.5um 6.27718um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 36.5um 17.2772um 36.5um 17.2772um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 36.5um 28.2772um 36.5um 28.2772um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 6.27718um 36.5um 6.27718um 36.5um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 17.2772um 36.5um 17.2772um 36.5um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box 28.2772um 36.5um 28.2772um 36.5um
box grow center 0.5um
paint m2contact 
paint m3contact 
paint via3 
box grow center 0.1um
paint metal2 
box -10um 8.66782um -5um 11.7778um
paint metal3 
paint metal4 
box -10um 8.66782um -5um 11.7778um
paint metal5 
box -10um 19.6678um -5um 22.7778um
paint metal3 
paint metal4 
box -10um 19.6678um -5um 22.7778um
paint metal5 
box -10um 30.6678um -5um 33.7778um
paint metal3 
paint metal4 
box -10um 30.6678um -5um 33.7778um
paint metal5 
box -0.777817um 38um 2.33218um 43um
paint metal3 
paint metal4 
box -0.777817um 38um 2.33218um 43um
paint metal5 
box 10.2222um 38um 13.3322um 43um
paint metal3 
paint metal4 
box 10.2222um 38um 13.3322um 43um
paint metal5 
box 21.2222um 38um 24.3322um 43um
paint metal3 
paint metal4 
box 21.2222um 38um 24.3322um 43um
paint metal5 
box 3.16782um -10um 6.27782um -5um
paint metal3 
paint metal4 
box 3.16782um -10um 6.27782um -5um
paint metal5 
box 14.1678um -10um 17.2778um -5um
paint metal3 
paint metal4 
box 14.1678um -10um 17.2778um -5um
paint metal5 
box 25.1678um -10um 28.2778um -5um
paint metal3 
paint metal4 
box 25.1678um -10um 28.2778um -5um
paint metal5 
box 38um 4.72218um 43um 7.83218um
paint metal3 
paint metal4 
box 38um 4.72218um 43um 7.83218um
paint metal5 
box 38um 15.7222um 43um 18.8322um
paint metal3 
paint metal4 
box 38um 15.7222um 43um 18.8322um
paint metal5 
box 38um 26.7222um 43um 29.8322um
paint metal3 
paint metal4 
box 38um 26.7222um 43um 29.8322um
paint metal5 
box -20um 43um 33um 53um
paint metal3 
paint metal4 
paint metal5 
box -20um 16.5um -10um 53um
paint metal3 
paint metal4 
paint metal5 
box 43um -20um 53um 33um
paint metal3 
paint metal4 
paint metal5 
box 0um -20um 53um -10um
paint metal3 
paint metal4 
paint metal5 
box -2um -2um 35um 0um
paint metal2 
box 33um -2um 35um 35um
paint metal2 
box -2um -2um 0um 35um
paint metal2 
box -2um 33um 35um 35um
paint metal2 
flatten waffle_testb
load waffle_testb
