v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1100 -660 1100 -640 {lab=VSS}
N 1080 -660 1080 -600 {lab=CMFBin}
N 1060 -380 1060 -370 {lab=VSS}
N 920 -440 970 -440 {lab=CMFBout}
N 1200 -420 1415 -420 {lab=VOUTN}
N 1200 -460 1360 -460 {lab=VOUTP}
N 1060 -520 1060 -500 {lab=VDD}
N 1110 -520 1110 -500 {lab=VREF}
N 1110 -380 1110 -320 {lab=I_N}
N 980 -690 1000 -690 {lab=VNout}
N 980 -790 1000 -790 {lab=VPout}
N 1230 -1020 1250 -1020 {lab=I_N}
N 1415 -720 1585 -720 {lab=VOUTN}
N 980 -710 1000 -710 {lab=VNin}
N 980 -770 1000 -770 {lab=VPin}
N 1230 -1050 1250 -1050 {lab=I_P}
N 1100 -840 1100 -820 {lab=VDD}
N 1100 -840 1170 -840 {lab=VDD}
N 1080 -870 1080 -820 {lab=I_P}
N 1360 -760 1585 -760 {lab=VOUTP}
N 1200 -760 1360 -760 {lab=VOUTP}
N 1200 -720 1415 -720 {lab=VOUTN}
N 1430 -930 1490 -930 {lab=VDD}
N 1430 -900 1490 -900 {lab=VSS}
N 1080 -1110 1080 -1090 {lab=VDD}
N 1080 -970 1080 -950 {lab=VSS}
N 980 -730 1000 -730 {lab=VN}
N 980 -750 1000 -750 {lab=VP}
N 1415 -720 1415 -420 {lab=VOUTN}
N 1360 -760 1360 -460 {lab=VOUTP}
C {lab_wire.sym} 1170 -840 2 0 {name=p10 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1060 -520 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1080 -1110 0 1 {name=p2 sig_type=std_logic lab=VDD}
C {lab_wire.sym} 1110 -320 2 0 {name=p13 sig_type=std_logic lab=I_N}
C {lab_wire.sym} 1250 -1020 0 1 {name=p16 sig_type=std_logic lab=I_N}
C {lab_wire.sym} 1100 -640 2 0 {name=p1 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1060 -370 2 0 {name=p4 sig_type=std_logic lab=VSS}
C {lab_wire.sym} 1080 -950 2 0 {name=p20 sig_type=std_logic lab=VSS}
C {ipin.sym} 980 -750 0 0 {name=p21 lab=VP}
C {ipin.sym} 980 -730 0 0 {name=p7 lab=VN}
C {opin.sym} 1585 -720 0 0 {name=p8 lab=VOUTP}
C {opin.sym} 1585 -760 0 0 {name=p22 lab=VOUTN}
C {ipin.sym} 980 -770 0 0 {name=p6 lab=VPin}
C {ipin.sym} 980 -710 0 0 {name=p9 lab=VNin}
C {opin.sym} 980 -790 2 0 {name=p12 lab=VPout}
C {opin.sym} 980 -690 2 0 {name=p18 lab=VNout}
C {iopin.sym} 1430 -930 2 0 {name=p19 lab=VDD}
C {iopin.sym} 1430 -900 2 0 {name=p23 lab=VSS}
C {iopin.sym} 1110 -520 0 0 {name=p11 lab=VREF}
C {lab_wire.sym} 1250 -1050 0 1 {name=p24 sig_type=std_logic lab=I_P}
C {lab_wire.sym} 1080 -870 0 0 {name=p25 sig_type=std_logic lab=I_P}
C {ipin.sym} 1080 -600 0 0 {name=p3 lab=CMFBin}
C {opin.sym} 920 -440 2 0 {name=p14 lab=CMFBout}
C {OTA_Telescopic_currentRef.sym} 1080 -1030 0 0 {name=x3}
C {OTA_Telescopic_CMFB.sym} 1120 -440 0 1 {name=x2}
C {OTA_Telescopic_FB.sym} 1090 -740 0 0 {name=x1}
