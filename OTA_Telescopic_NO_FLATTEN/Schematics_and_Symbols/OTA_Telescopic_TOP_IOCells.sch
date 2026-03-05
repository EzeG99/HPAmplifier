v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 465 -760 465 -700 {lab=VDD}
N 465 -520 465 -460 {lab=VSS}
N 910 -965 940 -965 {
lab=VP}
N 850 -1025 910 -1025 {
lab=VP}
N 910 -1025 910 -965 {
lab=VP}
N 870 -965 910 -965 {
lab=VP}
N 1180 -965 1350 -965 {
lab=vp}
N 910 -835 940 -835 {
lab=VN}
N 850 -895 910 -895 {
lab=VN}
N 910 -895 910 -835 {
lab=VN}
N 870 -835 910 -835 {
lab=VN}
N 1180 -835 1350 -835 {
lab=vn}
N 1480 -625 1510 -625 {
lab=VOUTP}
N 1510 -685 1570 -685 {
lab=VOUTP}
N 1510 -685 1510 -625 {
lab=VOUTP}
N 1510 -625 1550 -625 {
lab=VOUTP}
N 1080 -625 1240 -625 {
lab=voutp}
N 1480 -495 1510 -495 {
lab=VOUTN}
N 1510 -555 1570 -555 {
lab=VOUTN}
N 1510 -555 1510 -495 {
lab=VOUTN}
N 1510 -495 1550 -495 {
lab=VOUTN}
N 1080 -495 1240 -495 {
lab=voutn}
N 910 -1085 940 -1085 {
lab=VREF}
N 850 -1145 910 -1145 {
lab=VREF}
N 910 -1145 910 -1085 {
lab=VREF}
N 870 -1085 910 -1085 {
lab=VREF}
N 1180 -1085 1360 -1085 {
lab=vref}
N 1220 -315 1240 -315 {
lab=VSS}
N 1220 -515 1240 -515 {
lab=VSS}
N 1220 -645 1240 -645 {
lab=VSS}
N 1080 -475 1240 -475 {
lab=VSS}
N 1080 -465 1240 -465 {
lab=VDD}
N 1080 -605 1240 -605 {
lab=VSS}
N 1080 -595 1240 -595 {
lab=VDD}
N 1180 -815 1340 -815 {
lab=VSS}
N 1180 -805 1340 -805 {
lab=VDD}
N 1180 -945 1340 -945 {
lab=VSS}
N 1180 -935 1340 -935 {
lab=VDD}
N 1180 -1065 1340 -1065 {
lab=VSS}
N 1180 -1055 1340 -1055 {
lab=VDD}
N 1180 -855 1220 -855 {
lab=VSS}
N 1180 -865 1200 -865 {
lab=VDD}
N 1180 -985 1220 -985 {
lab=VSS}
N 1180 -995 1200 -995 {
lab=VDD}
N 1180 -1105 1220 -1105 {
lab=VSS}
N 1180 -1115 1200 -1115 {
lab=VDD}
N 1200 -325 1240 -325 {
lab=VDD}
N 1070 -275 1240 -275 {
lab=VSS}
N 1070 -265 1240 -265 {
lab=VDD}
N 1220 -515 1220 -315 {
lab=VSS}
N 1200 -525 1240 -525 {
lab=VDD}
N 1200 -525 1200 -325 {
lab=VDD}
N 1200 -655 1200 -525 {
lab=VDD}
N 1200 -655 1240 -655 {
lab=VDD}
N 1220 -645 1220 -515 {
lab=VSS}
N 1200 -865 1200 -655 {
lab=VDD}
N 1220 -855 1220 -645 {
lab=VSS}
N 1220 -985 1220 -855 {
lab=VSS}
N 1220 -1105 1220 -985 {
lab=VSS}
N 1200 -995 1200 -865 {
lab=VDD}
N 1200 -1115 1200 -995 {
lab=VDD}
N 1200 -185 1200 -125 {lab=VDD}
N 1220 -135 1240 -135 {
lab=VSS}
N 1220 -175 1220 -135 {lab=VSS}
N 1200 -125 1240 -125 {
lab=VDD}
N 1070 -125 1200 -125 {
lab=VDD}
N 1070 -135 1220 -135 {
lab=VSS}
N 1220 -175 1240 -175 {lab=VSS}
N 1220 -315 1220 -175 {lab=VSS}
N 1200 -185 1240 -185 {lab=VDD}
N 1200 -325 1200 -185 {lab=VDD}
N 615 -620 665 -620 {lab=voutp}
N 615 -600 665 -600 {lab=voutn}
N 275 -670 315 -670 {lab=vp}
N 275 -550 315 -550 {lab=vn}
N 235 -650 315 -650 {lab=VPout}
N 235 -570 315 -570 {lab=VNout}
N 235 -630 315 -630 {lab=VPin}
N 235 -590 315 -590 {lab=VNin}
N 555 -520 555 -460 {lab=CMFBout}
N 510 -520 510 -460 {lab=CMFBin}
N 430 -760 430 -700 {lab=vref}
C {ipin.sym} 235 -630 0 0 {name=p6 lab=VPin}
C {ipin.sym} 235 -590 0 0 {name=p9 lab=VNin}
C {iopin.sym} 465 -760 3 0 {name=p19 lab=VDD}
C {iopin.sym} 465 -460 1 0 {name=p23 lab=VSS}
C {ipin.sym} 510 -460 3 0 {name=p3 lab=CMFBin}
C {opin.sym} 555 -460 1 0 {name=p14 lab=CMFBout}
C {ipin.sym} 855 -1025 0 0 {name=p26 lab=VP}
C {sg13g2_pr/bondpad.sym} 830 -965 3 0 {name=X5
model=bondpad
spiceprefix=X
size=80u
shape=0
padtype=0
}
C {lab_wire.sym} 1350 -965 0 1 {name=p28 sig_type=std_logic lab=vp}
C {ipin.sym} 855 -895 0 0 {name=p21 lab=VN}
C {sg13g2_pr/bondpad.sym} 830 -835 3 0 {name=X7
model=bondpad
spiceprefix=X
size=80u
shape=0
padtype=0
}
C {lab_wire.sym} 1350 -835 0 1 {name=p29 sig_type=std_logic lab=vn}
C {sg13g2_pr/bondpad.sym} 1590 -625 1 1 {name=X9
model=bondpad
spiceprefix=X
size=80u
shape=0
padtype=0
}
C {lab_wire.sym} 1080 -625 0 0 {name=p31 sig_type=std_logic lab=voutp}
C {sg13g2_pr/bondpad.sym} 1590 -495 1 1 {name=X11
model=bondpad
spiceprefix=X
size=80u
shape=0
padtype=0
}
C {opin.sym} 1565 -685 0 0 {name=p8 lab=VOUTP}
C {opin.sym} 1565 -555 0 0 {name=p22 lab=VOUTN}
C {lab_wire.sym} 665 -600 0 1 {name=p30 sig_type=std_logic lab=voutn}
C {lab_wire.sym} 665 -620 0 1 {name=p33 sig_type=std_logic lab=voutp}
C {lab_wire.sym} 1080 -495 0 0 {name=p37 sig_type=std_logic lab=voutn}
C {opin.sym} 235 -650 2 0 {name=p12 lab=VPout}
C {opin.sym} 235 -570 2 0 {name=p18 lab=VNout}
C {sg13g2_pr/bondpad.sym} 830 -1085 3 0 {name=X13
model=bondpad
spiceprefix=X
size=80u
shape=0
padtype=0
}
C {lab_wire.sym} 1360 -1085 0 1 {name=p34 sig_type=std_logic lab=vref}
C {lab_wire.sym} 430 -760 0 0 {name=p11 sig_type=std_logic lab=vref}
C {IOCells/sg13g2_IOPadAnalog.sym} 1060 -1085 0 1 {name=x1}
C {IOCells/sg13g2_IOPadAnalog.sym} 1060 -965 0 1 {name=x4}
C {IOCells/sg13g2_IOPadAnalog.sym} 1060 -835 0 1 {name=x6}
C {IOCells/sg13g2_IOPadAnalog.sym} 1360 -625 0 0 {name=x8}
C {IOCells/sg13g2_IOPadAnalog.sym} 1360 -495 0 0 {name=x10}
C {lab_wire.sym} 1070 -275 0 0 {name=p42 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1070 -265 2 1 {name=p43 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1080 -475 0 0 {name=p48 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1080 -465 2 1 {name=p49 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1080 -605 0 0 {name=p50 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1080 -595 2 1 {name=p51 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1340 -815 0 1 {name=p52 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1340 -805 2 0 {name=p53 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1340 -945 0 1 {name=p54 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1340 -935 2 0 {name=p55 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1340 -1065 0 1 {name=p56 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1340 -1055 2 0 {name=p57 sig_type=std_logic lab=VDD}
C {sg13g2_IOPadIOVdd.sym} 1360 -295 0 0 {name=x15}
C {sg13g2_IOPadIOVss.sym} 1360 -155 0 0 {name=x12}
C {lab_wire.sym} 1070 -135 0 0 {name=p32 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1070 -125 2 1 {name=p36 sig_type=std_logic lab=VDD}
C {iopin.sym} 850 -1145 0 1 {name=p35 lab=VREF}
C {OTA_Telescopic_TOP_wp.sym} 465 -610 0 0 {name=x16}
C {lab_wire.sym} 275 -670 0 0 {name=p38 sig_type=std_logic lab=vp}
C {lab_wire.sym} 275 -550 0 0 {name=p39 sig_type=std_logic lab=vn}
