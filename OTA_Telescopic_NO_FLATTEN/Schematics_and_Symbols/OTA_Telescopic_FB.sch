v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1100 -660 1100 -640 {lab=VSS}
N 1110 -1020 1320 -1020 {lab=VOUTP}
N 1100 -440 1320 -440 {lab=VOUTN}
N 780 -640 800 -640 {lab=VNout}
N 780 -820 800 -820 {lab=VPout}
N 980 -700 1000 -700 {lab=VNin}
N 980 -780 1000 -780 {lab=VPin}
N 780 -1020 780 -820 {lab=VPout}
N 1320 -1020 1320 -760 {lab=VOUTP}
N 1100 -840 1100 -820 {lab=VDD}
N 1100 -840 1170 -840 {lab=VDD}
N 1080 -870 1080 -820 {lab=I_P}
N 760 -640 780 -640 {lab=VNout}
N 760 -820 780 -820 {lab=VPout}
N 1200 -760 1320 -760 {lab=VOUTP}
N 1200 -720 1320 -720 {lab=VOUTN}
N 655 -745 715 -745 {lab=VDD}
N 655 -715 715 -715 {lab=VSS}
N 645 -640 700 -640 {lab=VN}
N 645 -820 700 -820 {lab=VP}
N 1320 -760 1585 -760 {lab=VOUTP}
N 1320 -720 1585 -720 {lab=VOUTN}
N 780 -640 780 -440 {lab=VNout}
N 1320 -720 1320 -440 {lab=VOUTN}
N 780 -440 1040 -440 {lab=VNout}
N 780 -1020 1050 -1020 {lab=VPout}
N 1080 -660 1080 -610 {lab=CMFBin}
C {lab_wire.sym} 1170 -840 2 0 {name=p10 sig_type=std_logic lab=VDD}
C {OTA_Telescopic_core.sym} 1080 -740 0 0 {name=x1}
C {lab_wire.sym} 1100 -640 2 0 {name=p1 sig_type=std_logic lab=VSS}
C {ipin.sym} 645 -820 0 0 {name=p21 lab=VP}
C {ipin.sym} 645 -640 0 0 {name=p7 lab=VN}
C {opin.sym} 1585 -760 0 0 {name=p8 lab=VOUTP}
C {opin.sym} 1585 -720 0 0 {name=p22 lab=VOUTN}
C {ipin.sym} 980 -780 0 0 {name=p6 lab=VPin}
C {ipin.sym} 980 -700 0 0 {name=p9 lab=VNin}
C {opin.sym} 800 -820 0 0 {name=p12 lab=VPout}
C {opin.sym} 800 -640 0 0 {name=p18 lab=VNout}
C {iopin.sym} 655 -745 2 0 {name=p19 lab=VDD}
C {iopin.sym} 655 -715 2 0 {name=p23 lab=VSS}
C {ipin.sym} 1080 -610 0 0 {name=p3 lab=CMFBin}
C {sg13g2_pr/rppd.sym} 730 -640 1 0 {name=R3
w=0.6e-6
l=6.73e-6
model=rppd
body=VSS
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} 730 -820 3 0 {name=R4
w=0.6e-6
l=6.73e-6
model=rppd
body=VSS
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} 1080 -1020 3 0 {name=R5
w=0.6e-6
l=15.4e-6
model=rppd
body=VSS
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} 1070 -440 3 0 {name=R2
w=0.6e-6
l=15.4e-6
model=rppd
body=VSS
spiceprefix=X
b=0
m=1
}
C {ipin.sym} 1080 -870 0 0 {name=p2 lab=IB}
