v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 600 -760 600 -740 { lab=iosc}
N 600 -680 600 -640 { lab=vss}
N 360 -680 360 -640 { lab=vss}
N 360 -760 360 -740 { lab=timeout}
C {devices/iopin.sym} 140 -760 0 0 {name=p3 lab=IOSC
}
C {devices/iopin.sym} 140 -740 0 0 {name=p4 lab=TIMEOUT
}
C {devices/iopin.sym} 150 -670 0 0 {name=p1 lab=VDD
}
C {devices/iopin.sym} 150 -640 0 0 {name=p2 lab=VSS
}
C {res_generic_m2.sym} 360 -710 0 0 {name=R1
W=1
L=1
model=res_generic_m2
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 360 -760 0 0 {name=l1 sig_type=std_logic lab=timeout}
C {res_generic_m2.sym} 600 -710 0 0 {name=R2
W=1
L=1
model=res_generic_m2
spiceprefix=R
mult=1}
C {devices/lab_wire.sym} 600 -760 0 0 {name=l2 sig_type=std_logic lab=iosc}
C {devices/lab_wire.sym} 360 -640 0 0 {name=l3 sig_type=std_logic lab=vss}
C {devices/lab_wire.sym} 600 -640 0 0 {name=l4 sig_type=std_logic lab=vss}
