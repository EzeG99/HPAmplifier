v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {dc 0.9 pwl(0 0.8 0.005u 0.8 0.005u 0.9 0.15m 0.9 0.15m 0)} 160 -100 0 0 0.4 0.4 {}
N 670 -270 670 -250 {lab=GND}
N 1190 -340 1190 -310 {lab=GND}
N 1290 -340 1290 -310 {lab=GND}
N 1290 -480 1290 -400 {lab=Vout2}
N 1100 -500 1190 -500 {lab=Vout1}
N 1190 -500 1190 -400 {lab=Vout1}
N 1100 -480 1290 -480 {lab=Vout2}
N 950 -400 950 -390 {lab=GND}
N 915 -600 915 -580 {lab=VREF}
N 950 -600 950 -580 {lab=VDD}
N 240 -185 240 -165 {lab=GND}
N 240 -305 240 -245 {lab=VDD}
N 670 -430 670 -330 {lab=#net1}
N 670 -550 800 -550 {lab=#net1}
N 670 -430 800 -430 {lab=#net1}
N 705 -470 800 -470 {lab=#net1}
N 705 -470 705 -450 {lab=#net1}
N 705 -450 715 -450 {lab=#net1}
N 775 -450 800 -450 {lab=#net2}
N 775 -530 800 -530 {lab=#net3}
N 705 -530 705 -510 {lab=#net4}
N 705 -510 800 -510 {lab=#net4}
N 600 -530 600 -520 {lab=#net4}
N 705 -530 715 -530 {lab=#net4}
N 600 -530 705 -530 {lab=#net4}
N 600 -460 600 -450 {lab=#net1}
N 600 -450 670 -450 {lab=#net1}
N 670 -550 670 -450 {lab=#net1}
N 670 -450 705 -450 {lab=#net1}
N 320 -185 320 -165 {lab=GND}
N 320 -305 320 -245 {lab=VREF}
N 995 -400 1040 -400 {lab=#net5}
N 670 -450 670 -430 {lab=#net1}
C {vsource.sym} 670 -300 0 0 {name=V7 value=1.25 savecurrent=false}
C {gnd.sym} 670 -250 0 0 {name=l5 lab=GND}
C {capa-2.sym} 1190 -370 0 0 {name=C1
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 1190 -310 0 0 {name=l10 lab=GND}
C {capa-2.sym} 1290 -370 0 0 {name=C2
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 1290 -310 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 1290 -480 0 0 {name=p19 sig_type=std_logic lab=Vout2}
C {lab_wire.sym} 1190 -440 0 0 {name=p18 sig_type=std_logic lab=Vout1}
C {gnd.sym} 950 -390 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 915 -600 0 0 {name=p2 sig_type=std_logic lab=VREF}
C {lab_wire.sym} 950 -600 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {vsource.sym} 240 -215 0 0 {name=V6 value=1.62 savecurrent=false}
C {gnd.sym} 240 -165 0 0 {name=l8 lab=GND}
C {lab_wire.sym} 240 -305 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {res.sym} 745 -530 1 0 {name=R3
value=10G
footprint=1206
device=resistor
m=1
}
C {res.sym} 745 -450 1 0 {name=R4
value=10G
footprint=1206
device=resistor
m=1
}
C {vsource.sym} 600 -490 0 0 {name=V1 value="0 AC 1" savecurrent=false}
C {devices/code.sym} 225 -810.390625 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib cornerMOSlv.lib mos_ss
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.temp 125
"
spice_ignore=false}
C {code.sym} 225 -660 0 0 {name=AC only_toplevel=true value="
.control
save all
 set color0 = white

* AC simulation
ac dec 1k 1 1T
let Av = db((v(Vout2)-v(Vout1)))
meas ac Ao FIND Av WHEN frequency=10
let ABW = Ao-3
meas ac BW WHEN Av=ABW
meas ac UGBW WHEN Av=0
let phase_vec = 180/pi*cph(v(Vout2)-v(Vout1))

* Phase margin (PM)
meas ac phase FIND phase_vec WHEN frequency=UGBW 
let PM = phase+180
print PM

* Gain margin (GM)
meas ac freq180 FIND frequency WHEN phase_vec=-180
meas ac gain FIND Av WHEN frequency=freq180
let GM = 0-gain

*BW in 7 dB
meas ac UGBW7dB WHEN Av=7
meas ac UGBW4dB WHEN Av=4

print GM
plot Av
plot phase_vec

plot db(v(x1.Vo1)-v(x1.Vo2))

write AC_OL.raw

wrdata AvOL_ Av
wrdata PhaseOL_ phase_vec


*DC simulation

op
let vout_dc = v(Vout1)
print vout_dc
write OTA_Telescopic_TOP_TB_OL.raw


reset    
noise v(Vout1) V6 dec 100 1 0.5e9 1
setplot noise1
*plot onoise_spectrum
setplot noise2
print onoise_total

.endc
"
}
C {devices/launcher.sym} 255 -480 0 0 {name=h3
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
C {code.sym} 115 -660 0 0 {name=NGSPICE
only_toplevel=true
value="

.temp 27
.control

save all
tran 1n 2u

plot v(Vout1)
plot v(VREF)

.endc
"
spice_ignore=true}
C {vsource.sym} 320 -215 0 0 {name=V2 value="dc 0.9 pwl(0 0.8 1u 0.8 1.01u 0.9 0.15m 0.9 0.15m 0)" savecurrent=false}
C {gnd.sym} 320 -165 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 320 -305 0 0 {name=p4 sig_type=std_logic lab=VREF}
C {code.sym} 360 -655 0 0 {name=save only_toplevel=false value="
.op

.save all

.save @n.x1.xm3.nsg13_lv_pmos[ids]
.save @n.x1.xm3.nsg13_lv_pmos[gm]

.save @n.x1.xm2.nsg13_lv_nmos[ids]
.save @n.x1.xm2.nsg13_lv_nmos[gm]

*OTA
.save @n.x1.x1.xm1.nsg13_lv_nmos[ids]
.save @n.x1.x1.xm1.nsg13_lv_nmos[gm]
.save @n.x1.x1.xm2.nsg13_lv_nmos[ids]
.save @n.x1.x1.xm2.nsg13_lv_nmos[gm]

.save @n.x1.x1.xm9.nsg13_lv_pmos[ids]
.save @n.x1.x1.xm9.nsg13_lv_pmos[gm]
.save @n.x1.x1.xm10.nsg13_lv_pmos[ids]
.save @n.x1.x1.xm10.nsg13_lv_pmos[gm]

.save @n.x1.x1.xm0.nsg13_lv_nmos[ids]

.save @n.x1.x1.xm1.nsg13_lv_nmos[vsat]

.save @n.x1.x1.xm7.nsg13_lv_pmos[ids]
.save @n.x1.x1.xm7.nsg13_lv_pmos[gm]
.save @n.x1.x1.xm1.nsg13_lv_pmos[vdss]

.save @n.x1.x1.xm13.nsg13_lv_nmos[ids]
.save @n.x1.x1.xm14.nsg13_lv_nmos[ids]
.save @n.x1.x1.xm15.nsg13_lv_nmos[ids]
.save @n.x1.x1.xm16.nsg13_lv_nmos[ids]
.save @n.x1.x1.xm17.nsg13_lv_nmos[ids]

.save @n.x1.x1.xm18.nsg13_lv_pmos[ids]
.save @n.x1.x1.xm19.nsg13_lv_pmos[ids]

*CMFB
.save @n.x1.x2.xm0.nsg13_lv_pmos[ids]
.save @n.x1.x2.xm1.nsg13_lv_pmos[ids]
.save @n.x1.x2.xm1.nsg13_lv_pmos[gm]
.save @n.x1.x2.xm2.nsg13_lv_pmos[ids]
.save @n.x1.x2.xm2.nsg13_lv_pmos[gm]
.save @n.x1.x2.xm3.nsg13_lv_pmos[ids]
.save @n.x1.x2.xm3.nsg13_lv_pmos[gm]
.save @n.x1.x2.xm4.nsg13_lv_pmos[ids]
.save @n.x1.x2.xm4.nsg13_lv_pmos[gm]
.save @n.x1.x2.xm5.nsg13_lv_pmos[ids]
.save @n.x1.x2.xm5.nsg13_lv_pmos[gm]
.save @n.x1.x2.xm6.nsg13_lv_pmos[ids]
.save @n.x1.x2.xm6.nsg13_lv_pmos[gm]

.save @n.x1.x2.xm7.nsg13_lv_nmos[ids]
.save @n.x1.x2.xm7.nsg13_lv_nmos[gm]
.save @n.x1.x2.xm8.nsg13_lv_nmos[ids]
.save @n.x1.x2.xm8.nsg13_lv_nmos[gm]



.control

let vsat_M1 = @n.x1.x1.xm1.nsg13_lv_nmos[vsat]
let vsat_M3 = @n.x1.x1.xm3.nsg13_lv_nmos[vsat]
let vsat_M5 = @n.x1.x1.xm5.nsg13_lv_pmos[vsat]
let vsat_M7 = @n.x1.x1.xm7.nsg13_lv_pmos[vsat]
let vsat_M0 = @n.x1.x1.xm0.nsg13_lv_nmos[vsat]

let vsat_M9 = @n.x1.x1.xm9.nsg13_lv_pmos[vsat]
let vsat_M11 = @n.x1.x1.xm11.nsg13_lv_nmos[vsat]

print vsat_M1
print vsat_M3
print vsat_M5
print vsat_M7
print vsat_M0
print vsat_M9
print vsat_M11

let ro_M1 = 1/@n.x1.x1.xm1.nsg13_lv_nmos[gds]
let ro_M3 = 1/@n.x1.x1.xm3.nsg13_lv_nmos[gds]
let ro_M5 = 1/@n.x1.x1.xm5.nsg13_lv_pmos[gds]
let ro_M7 = 1/@n.x1.x1.xm7.nsg13_lv_pmos[gds]
let ro_M0 = 1/@n.x1.x1.xm0.nsg13_lv_nmos[gds]

print ro_M1
print ro_M3
print ro_M5
print ro_M7
print ro_M0

let gm_M1 = @n.x1.x1.xm1.nsg13_lv_nmos[gm]
let gm_M3 = @n.x1.x1.xm3.nsg13_lv_nmos[gm]
let gm_M5 = @n.x1.x1.xm5.nsg13_lv_pmos[gm]
let gm_M7 = @n.x1.x1.xm7.nsg13_lv_pmos[gm]
let gm_M0 = @n.x1.x1.xm0.nsg13_lv_nmos[gm]

print gm_M1
print gm_M3
print gm_M5
print gm_M7
print gm_M0

let gmb_M3 = @n.x1.x1.xm3.nsg13_lv_nmos[gmb]
let gmb_M5 = @n.x1.x1.xm5.nsg13_lv_pmos[gmb]

print gmb_M3
print gmb_M5


*CMFB

let x2_vsat_M0 = @n.x1.x2.xm0.nsg13_lv_pmos[vsat]
let x2_vth_M0 = @n.x1.x2.xm0.nsg13_lv_pmos[vth]

print x2_vsat_M0
print x2_vth_M0

.endc

"
spice_ignore=true}
C {OTA_Telescopic_TOP_wp.sym} 950 -490 0 0 {name=x2}
