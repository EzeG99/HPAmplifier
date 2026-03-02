v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {dc 0.9 pwl(0 0.8 0.005u 0.8 0.005u 0.9 0.15m 0.9 0.15m 0)} -325 360 0 0 0.4 0.4 {}
N -35 210 -35 230 {lab=GND}
N 485 140 485 170 {lab=GND}
N 585 140 585 170 {lab=GND}
N 585 0 585 80 {lab=Vout2}
N 395 -20 485 -20 {lab=Vout1}
N 485 -20 485 80 {lab=Vout1}
N 395 0 585 0 {lab=Vout2}
N 245 80 245 90 {lab=GND}
N 210 -120 210 -100 {lab=VREF}
N 245 -120 245 -100 {lab=VDD}
N -275 295 -275 315 {lab=GND}
N -275 175 -275 235 {lab=VDD}
N -185 295 -185 315 {lab=GND}
N -185 175 -185 235 {lab=VREF}
N 1105 285 1105 305 {lab=GND}
N 1105 175 1105 225 {lab=#net1}
N 1105 175 1145 175 {lab=#net1}
N 1075 175 1105 175 {lab=#net1}
N -35 50 -35 150 {lab=#net2}
N -35 -70 95 -70 {lab=#net2}
N -35 50 95 50 {lab=#net2}
N -35 -15 -35 50 {lab=#net2}
N 0 10 95 10 {lab=#net2}
N 0 10 0 30 {lab=#net2}
N 0 30 10 30 {lab=#net2}
N 70 30 95 30 {lab=#net3}
N 70 -50 95 -50 {lab=#net4}
N 0 -50 10 -50 {lab=#net2}
N 0 -50 0 -30 {lab=#net2}
N 0 -30 95 -30 {lab=#net2}
N 290 80 290 130 {lab=vf1}
N 335 80 335 105 {lab=vr1}
N 335 105 350 105 {lab=vr1}
N 350 105 350 130 {lab=vr1}
N 760 215 760 235 {lab=GND}
N 1280 145 1280 175 {lab=GND}
N 1380 145 1380 175 {lab=GND}
N 1380 5 1380 85 {lab=V2}
N 1190 -15 1280 -15 {lab=V1}
N 1280 -15 1280 85 {lab=V1}
N 1190 5 1380 5 {lab=V2}
N 1040 85 1040 95 {lab=GND}
N 1005 -115 1005 -95 {lab=VREF}
N 1040 -115 1040 -95 {lab=VDD}
N 760 55 760 155 {lab=#net5}
N 760 -65 890 -65 {lab=#net5}
N 760 55 890 55 {lab=#net5}
N 760 -10 760 55 {lab=#net5}
N 795 15 890 15 {lab=#net5}
N 795 15 795 35 {lab=#net5}
N 795 35 805 35 {lab=#net5}
N 865 35 890 35 {lab=#net6}
N 865 -45 890 -45 {lab=#net7}
N 795 -45 805 -45 {lab=#net5}
N 795 -45 795 -25 {lab=#net5}
N 795 -25 890 -25 {lab=#net5}
N 1085 85 1085 135 {lab=#net8}
N 1130 85 1130 135 {lab=#net9}
N 995 135 1085 135 {lab=#net8}
N 995 135 995 175 {lab=#net8}
N 995 175 1015 175 {lab=#net8}
N 1130 135 1225 135 {lab=#net9}
N 1225 135 1225 175 {lab=#net9}
N 1205 175 1225 175 {lab=#net9}
N 0 -15 -0 10 {lab=#net2}
N 795 -10 795 15 {lab=#net5}
N 760 -10 795 -10 {lab=#net5}
N 760 -65 760 -10 {lab=#net5}
N 795 -25 795 -10 {lab=#net5}
N -35 -15 0 -15 {lab=#net2}
N -35 -70 -35 -15 {lab=#net2}
N 0 -30 0 -15 {lab=#net2}
C {vsource.sym} -35 180 0 0 {name=V7 value=1.25 savecurrent=false}
C {gnd.sym} -35 230 0 0 {name=l5 lab=GND}
C {capa-2.sym} 485 110 0 0 {name=C1
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 485 170 0 0 {name=l10 lab=GND}
C {capa-2.sym} 585 110 0 0 {name=C2
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 585 170 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 585 0 0 0 {name=p19 sig_type=std_logic lab=Vout2}
C {lab_wire.sym} 485 40 0 0 {name=p18 sig_type=std_logic lab=Vout1}
C {gnd.sym} 245 90 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 210 -120 0 0 {name=p2 sig_type=std_logic lab=VREF}
C {lab_wire.sym} 245 -120 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {vsource.sym} -275 265 0 0 {name=V6 value=1.8 savecurrent=false}
C {gnd.sym} -275 315 0 0 {name=l8 lab=GND}
C {lab_wire.sym} -275 175 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {vsource.sym} -185 265 0 0 {name=V8 value=0.9 savecurrent=false}
C {gnd.sym} -185 315 0 0 {name=l9 lab=GND}
C {lab_wire.sym} -185 175 0 0 {name=p6 sig_type=std_logic lab=VREF}
C {devices/code.sym} -335 -320.390625 0 0 {name=TT_MODELS1
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.temp 65
"
}
C {devices/launcher.sym} -195 -400 0 0 {name=h1
descr="save, netlist & simulate"
tclcommand="xschem save; xschem netlist; xschem simulate"
value="
.param wx=5u lx=0.13u vbx=0
.save all
.save @n.xm1.nsg13_lv_nmos[gm]
.save @n.xm1.nsg13_lv_nmos[ids]
.save @n.xm1.nsg13_lv_nmos[sid]
.save @n.xm1.nsg13_lv_nmos[sfl]

.control
set wr_vecnames
op
noise v(n) vg dec 10 1 1e11 1
noise v(n) vg lin  1 1 1 1
echo $plots
write noisetest_sg13g2_lv_nmos.raw noise1.all

setplot noise3
print onoise_spectrum
print onoise_n.xm1.nsg13_lv_nmos_flicker
print onoise_n.xm1.nsg13_lv_nmos_idid
print sqrt(@n.xm1.nsg13_lv_nmos[sfl])
print sqrt(@n.xm1.nsg13_lv_nmos[sid])
.endc
"}
C {code.sym} -325 -185 0 0 {name=save1 only_toplevel=false value="
.op

.save all
*OTA
.save @m.x1.xm1.msky130_fd_pr__nfet_01v8_lvt[id]
.save @m.x1.xm1.msky130_fd_pr__nfet_01v8_lvt[gm]
.save @m.x1.xm2.msky130_fd_pr__nfet_01v8_lvt[id]
.save @m.x1.xm2.msky130_fd_pr__nfet_01v8_lvt[gm]

.save @m.x1.xm9.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x1.xm9.msky130_fd_pr__pfet_01v8_lvt[gm]
.save @m.x1.xm10.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x1.xm10.msky130_fd_pr__pfet_01v8_lvt[gm]

.save @m.x1.xm0.msky130_fd_pr__nfet_01v8_lvt[id]

.save @m.x1.xm1.msky130_fd_pr__nfet_01v8_lvt[vdssat]


.save @m.x1.xm13.msky130_fd_pr__nfet_01v8_lvt[id]
.save @m.x1.xm14.msky130_fd_pr__nfet_01v8_lvt[id]
.save @m.x1.xm15.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x1.xm16.msky130_fd_pr__nfet_01v8_lvt[id]
.save @m.x1.xm17.msky130_fd_pr__nfet_01v8_lvt[id]

.save @m.x1.xm18.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x1.xm19.msky130_fd_pr__nfet_01v8_lvt[id]

*CMFB
.save @m.x2.xm0.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x2.xm1.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x2.xm1.msky130_fd_pr__pfet_01v8_lvt[gm]
.save @m.x2.xm2.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x2.xm2.msky130_fd_pr__pfet_01v8_lvt[gm]
.save @m.x2.xm3.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x2.xm3.msky130_fd_pr__pfet_01v8_lvt[gm]
.save @m.x2.xm4.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x2.xm4.msky130_fd_pr__pfet_01v8_lvt[gm]
.save @m.x2.xm5.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x2.xm5.msky130_fd_pr__pfet_01v8_lvt[gm]
.save @m.x2.xm6.msky130_fd_pr__pfet_01v8_lvt[id]
.save @m.x2.xm6.msky130_fd_pr__pfet_01v8_lvt[gm]

.save @m.x2.xm7.msky130_fd_pr__nfet_01v8_lvt[id]
.save @m.x2.xm7.msky130_fd_pr__nfet_01v8_lvt[gm]
.save @m.x2.xm8.msky130_fd_pr__nfet_01v8_lvt[id]
.save @m.x2.xm8.msky130_fd_pr__nfet_01v8_lvt[gm]



.control

let vdssat_M1 = @m.x1.xm1.msky130_fd_pr__nfet_01v8_lvt[vdsat]
let vdssat_M3 = @m.x1.xm3.msky130_fd_pr__nfet_01v8_lvt[vdsat]
let vdssat_M5 = @m.x1.xm5.msky130_fd_pr__pfet_01v8_lvt[vdsat]
let vdssat_M7 = @m.x1.xm7.msky130_fd_pr__pfet_01v8_lvt[vdsat]
let vdssat_M0 = @m.x1.xm0.msky130_fd_pr__nfet_01v8_lvt[vdsat]

let vdssat_M9 = @m.x1.xm9.msky130_fd_pr__pfet_01v8_lvt[vdsat]
let vdssat_M11 = @m.x1.xm11.msky130_fd_pr__nfet_01v8_lvt[vdsat]

print vdssat_M1
print vdssat_M3
print vdssat_M5
print vdssat_M7
print vdssat_M0
print vdssat_M9
print vdssat_M11

let ro_M1 = 1/@m.x1.xm1.msky130_fd_pr__nfet_01v8_lvt[gds]
let ro_M3 = 1/@m.x1.xm3.msky130_fd_pr__nfet_01v8_lvt[gds]
let ro_M5 = 1/@m.x1.xm5.msky130_fd_pr__pfet_01v8_lvt[gds]
let ro_M7 = 1/@m.x1.xm7.msky130_fd_pr__pfet_01v8_lvt[gds]
let ro_M0 = 1/@m.x1.xm0.msky130_fd_pr__nfet_01v8_lvt[gds]

print ro_M1
print ro_M3
print ro_M5
print ro_M7
print ro_M0

let gm_M1 = @m.x1.xm1.msky130_fd_pr__nfet_01v8_lvt[gm]
let gm_M3 = @m.x1.xm3.msky130_fd_pr__nfet_01v8_lvt[gm]
let gm_M5 = @m.x1.xm5.msky130_fd_pr__pfet_01v8_lvt[gm]
let gm_M7 = @m.x1.xm7.msky130_fd_pr__pfet_01v8_lvt[gm]
let gm_M0 = @m.x1.xm0.msky130_fd_pr__nfet_01v8_lvt[gm]

print gm_M1
print gm_M3
print gm_M5
print gm_M7
print gm_M0

let gmb_M3 = @m.x1.xm3.msky130_fd_pr__nfet_01v8_lvt[gmbs]
let gmb_M5 = @m.x1.xm5.msky130_fd_pr__pfet_01v8_lvt[gmbs]

print gmb_M3
print gmb_M5


let cgg_M0 = @m.x1.xm0.msky130_fd_pr__nfet_01v8_lvt[cgg]
print cgg_M0


*CMFB

let x2_vdssat_M0 = @m.x2.xm0.msky130_fd_pr__pfet_01v8_lvt[vdsat]
let x2_vth_M0 = @m.x2.xm0.msky130_fd_pr__pfet_01v8_lvt[vth]

print x2_vdssat_M0
print x2_vth_M0

.endc

"
spice_ignore=true}
C {devices/vsource.sym} 320 130 1 0 {name=Vtest1 value="dc 0 ac 1"}
C {ammeter.sym} 1045 175 1 0 {name=Vif1 savecurrent=true spice_ignore=0}
C {ammeter.sym} 1175 175 1 0 {name=Vir1 savecurrent=true spice_ignore=0}
C {isource.sym} 1105 255 2 0 {name=Itest1 value="dc 0 ac 1"}
C {devices/gnd.sym} 1105 305 0 0 {name=l21 lab=GND}
C {code.sym} -205 -180 0 0 {name=STB
only_toplevel=true
value="

.options savecurrents reltol=1e-3 abstol=1e-12 gmin=1e-15
.control
save all
set color0 = white

* Operating Point Analysis
op
remzerovec
let cgg_M0 = @m.x1.xm0.msky130_fd_pr__nfet_01v8_lvt[cgg]
print cgg_M0
write OTA_Telescopic_TOP_TB_CMFB.raw
set appendwrite

* AC Analysis
ac dec 10 1 5G
remzerovec
write Middlebrook.raw
set appendwrite

* Middlebrook's Method
let tv=-v(vr1)/v(vf1)
let ti=-i(vir1)/i(vif1)
let tmb=(tv*ti - 1)/(tv + ti + 2)

let Av = db(tmb)
meas ac Ao MAX Av
let ABW = Ao-3
meas ac BW WHEN Av=ABW
meas ac UGBW WHEN Av=0

* Phase margin (PM)
let phase_vec= 180/pi*cph(tmb)
meas ac phase FIND phase_vec WHEN frequency=UGBW
let PM = phase+180
print PM

* Gain margin (GM)
meas ac freq180 FIND frequency WHEN phase_vec=-180
meas ac gain FIND Av WHEN frequency=freq180
let GM = 0-gain
print GM

plot Av ylabel 'Magnitude - Middlebrook'
plot phase_vec ylabel 'Phase - Middlebrook'

write Middlebrook_.raw

wrdata STB_Av_ Av
wrdata STB_ph_ phase_vec

*quit

.endc
"
}
C {res.sym} 40 -50 1 0 {name=R3
value=10G
footprint=1206
device=resistor
m=1
}
C {res.sym} 40 30 1 0 {name=R4
value=10G
footprint=1206
device=resistor
m=1
}
C {vsource.sym} 760 185 0 0 {name=V1 value=1.25 savecurrent=false}
C {gnd.sym} 760 235 0 0 {name=l2 lab=GND}
C {capa-2.sym} 1280 115 0 0 {name=C3
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 1280 175 0 0 {name=l3 lab=GND}
C {capa-2.sym} 1380 115 0 0 {name=C4
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 1380 175 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 1380 5 0 0 {name=p1 sig_type=std_logic lab=V2}
C {lab_wire.sym} 1280 45 0 0 {name=p4 sig_type=std_logic lab=V1}
C {gnd.sym} 1040 95 0 0 {name=l6 lab=GND}
C {lab_wire.sym} 1005 -115 0 0 {name=p7 sig_type=std_logic lab=VREF}
C {lab_wire.sym} 1040 -115 0 0 {name=p8 sig_type=std_logic lab=VDD}
C {res.sym} 835 -45 1 0 {name=R1
value=10G
footprint=1206
device=resistor
m=1
}
C {res.sym} 835 35 1 0 {name=R2
value=10G
footprint=1206
device=resistor
m=1
}
C {lab_wire.sym} 350 130 2 0 {name=p13 sig_type=std_logic lab=vr1}
C {lab_wire.sym} 290 130 0 0 {name=p12 sig_type=std_logic lab=vf1}
C {OTA_Telescopic_TOP_wp.sym} 245 -10 0 0 {name=x1}
C {OTA_Telescopic_TOP_wp.sym} 1040 -5 0 0 {name=x2}
