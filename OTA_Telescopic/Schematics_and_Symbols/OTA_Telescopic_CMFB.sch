v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {W=9u (changed because LVS) 8.995u
W=30u (changed because LVS) 29.97u} -670 100 0 0 0.4 0.4 {}
T {133.27uA} -670 -340 0 0 0.4 0.4 {}
T {385.59uA} -170 -340 0 0 0.4 0.4 {}
T {385.59uA} 240 -340 0 0 0.4 0.4 {}
N -240 -100 -240 -80 {lab=V1}
N -120 -100 0 -100 {lab=V1}
N 0 -100 0 -80 {lab=V1}
N 160 -100 160 -80 {lab=V2}
N 290 -100 400 -100 {lab=V2}
N 400 -100 400 -80 {lab=V2}
N -110 -300 290 -300 {lab=VDD}
N 80 0 160 0 {lab=#net1}
N 160 -20 160 0 {lab=#net1}
N 80 35 80 50 {lab=#net1}
N 440 -50 480 -50 {lab=VINN}
N -650 -100 -650 10 {lab=IBIAS}
N -650 -100 -590 -100 {lab=IBIAS}
N -240 -100 -120 -100 {lab=V1}
N -320 -50 -280 -50 {lab=VINP}
N -680 10 -650 10 {lab=IBIAS}
N -590 -190 -590 -100 {lab=IBIAS}
N -650 -160 -650 -100 {lab=IBIAS}
N -610 -190 -590 -190 {lab=IBIAS}
N -660 -300 -650 -300 {lab=VDD}
N -660 -190 -650 -190 {lab=VDD}
N -240 -20 -240 190 {lab=CMFB}
N 400 -20 400 190 {lab=CMFB}
N 80 110 80 140 {lab=VSS}
N 80 80 90 80 {lab=VSS}
N 90 80 90 140 {lab=VSS}
N -120 -300 -120 -220 {lab=VDD}
N -120 -160 -120 -100 {lab=V1}
N 290 -170 290 -100 {lab=V2}
N 290 -300 290 -230 {lab=VDD}
N 0 -20 0 0 {lab=#net1}
N 160 -50 400 -50 {lab=VDD}
N -240 -50 0 -50 {lab=VDD}
N -650 -300 -120 -300 {lab=VDD}
N -590 300 -260 300 {lab=VSS}
N -120 -190 -110 -190 {lab=VDD}
N -110 -300 -110 -190 {lab=VDD}
N 290 -200 300 -200 {lab=VDD}
N 300 -300 300 -200 {lab=VDD}
N 290 -300 300 -300 {lab=VDD}
N 160 -200 250 -200 {lab=IBIAS}
N -240 190 -240 220 {lab=CMFB}
N -180 190 400 190 {lab=CMFB}
N 90 140 170 140 {lab=VSS}
N -260 250 -240 250 {lab=VSS}
N -260 250 -260 300 {lab=VSS}
N -260 300 -240 300 {lab=VSS}
N -240 280 -240 300 {lab=VSS}
N -200 250 -180 250 {lab=CMFB}
N -650 -300 -650 -220 {lab=VDD}
N -660 -300 -660 -190 {lab=VDD}
N -590 -190 -160 -190 {lab=IBIAS}
N 400 190 460 190 {lab=CMFB}
N 10 80 40 80 {lab=#net1}
N -180 190 -180 250 {lab=CMFB}
N 10 35 10 80 {lab=#net1}
N 10 35 80 35 {lab=#net1}
N 0 0 80 0 {lab=#net1}
N 160 -100 290 -100 {lab=V2}
N 80 140 90 140 {lab=VSS}
N -120 -300 -110 -300 {lab=VDD}
N -680 -300 -660 -300 {lab=VDD}
N -240 190 -180 190 {lab=CMFB}
N 80 0 80 35 {lab=#net1}
N 80 -50 120 -50 {lab=VREF}
N 80 -130 80 -50 {lab=VREF}
N 40 -50 80 -50 {lab=VREF}
C {iopin.sym} -680 -300 0 1 {name=p1 lab=VDD}
C {iopin.sym} -590 300 0 1 {name=p2 lab=VSS}
C {opin.sym} 455 190 0 0 {name=p7 lab=CMFB}
C {ipin.sym} 80 -130 0 0 {name=p5 lab=VREF}
C {iopin.sym} -680 10 0 1 {name=p3 lab=IBIAS}
C {ipin.sym} -320 -50 0 0 {name=p9 lab=VINP}
C {ipin.sym} 480 -50 0 1 {name=p10 lab=VINN}
C {lab_wire.sym} -160 -100 0 0 {name=p17 sig_type=std_logic lab=V1}
C {lab_wire.sym} 210 -100 0 0 {name=p11 sig_type=std_logic lab=V2}
C {lab_wire.sym} -110 -50 0 0 {name=p4 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 290 -50 0 0 {name=p6 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 160 -200 0 0 {name=p12 sig_type=std_logic lab=IBIAS}
C {lab_wire.sym} 150 140 0 1 {name=p13 sig_type=std_logic lab=VSS}
C {sg13g2_pr/sg13_lv_pmos.sym} -630 -190 0 1 {name=M0
l=0.7u
w=6u
ng=6
m=8
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -140 -190 0 0 {name=M1
l=0.7u
w=6u
ng=6
m=24
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 270 -200 0 0 {name=M2
l=0.7u
w=6u
ng=6
m=24
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -260 -50 0 0 {name=M3
l=0.35u
w=8.995u
ng=7
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 20 -50 0 1 {name=M4
l=0.35u
w=8.995u
ng=7
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 140 -50 0 0 {name=M5
l=0.35u
w=8.995u
ng=7
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 420 -50 0 1 {name=M6
l=0.35u
w=8.995u
ng=7
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 60 80 0 0 {name=M7
l=0.20u
w=29.97u
ng=9
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -220 250 0 1 {name=M8
l=0.20u
w=29.97u
ng=9
m=1
model=sg13_lv_nmos
spiceprefix=X
}
