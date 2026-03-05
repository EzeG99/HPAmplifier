v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {dc 0.9 pwl(0 0.8 0.005u 0.8 0.005u 0.9 0.15m 0.9 0.15m 0)} -860 360 0 0 0.4 0.4 {}
N -350 190 -350 210 {lab=GND}
N 170 120 170 150 {lab=GND}
N 270 120 270 150 {lab=GND}
N 270 -20 270 60 {lab=Vout2}
N 80 -40 170 -40 {lab=Vout1}
N 170 -40 170 60 {lab=Vout1}
N 80 -20 270 -20 {lab=Vout2}
N -70 60 -70 70 {lab=GND}
N -105 -140 -105 -120 {lab=VREF}
N -70 -140 -70 -120 {lab=VDD}
N -780 275 -780 295 {lab=GND}
N -780 155 -780 215 {lab=VDD}
N -350 25 -350 130 {lab=#net1}
N -350 -90 -220 -90 {lab=#net1}
N -350 25 -220 25 {lab=#net1}
N -315 -15 -220 -15 {lab=#net1}
N -315 -15 -315 5 {lab=#net1}
N -315 5 -305 5 {lab=#net1}
N -245 5 -220 5 {lab=#net2}
N -245 -70 -220 -70 {lab=#net3}
N -315 -70 -315 -50 {lab=#net4}
N -315 -50 -220 -50 {lab=#net4}
N -350 5 -350 25 {lab=#net1}
N -420 -70 -420 -60 {lab=#net4}
N -315 -70 -305 -70 {lab=#net4}
N -420 -70 -315 -70 {lab=#net4}
N -420 -0 -420 5 {lab=#net1}
N -420 5 -350 5 {lab=#net1}
N -350 -90 -350 5 {lab=#net1}
N -350 5 -315 5 {lab=#net1}
N -700 275 -700 295 {lab=GND}
N -700 155 -700 215 {lab=VREF}
N -25 60 20 60 {lab=#net5}
N -930 250 -930 265 {lab=GND}
N -930 175 -930 190 {lab=sub!}
N -930 175 -870 175 {lab=sub!}
C {vsource.sym} -350 160 0 0 {name=V7 value=1.25 savecurrent=false}
C {gnd.sym} -350 210 0 0 {name=l5 lab=GND}
C {capa-2.sym} 170 90 0 0 {name=C1
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 170 150 0 0 {name=l10 lab=GND}
C {capa-2.sym} 270 90 0 0 {name=C2
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 270 150 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 270 -20 0 0 {name=p19 sig_type=std_logic lab=Vout2}
C {lab_wire.sym} 170 20 0 0 {name=p18 sig_type=std_logic lab=Vout1}
C {gnd.sym} -70 70 0 0 {name=l1 lab=GND}
C {lab_wire.sym} -105 -140 0 0 {name=p2 sig_type=std_logic lab=VREF}
C {lab_wire.sym} -70 -140 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {vsource.sym} -780 245 0 0 {name=V6 value=1.98 savecurrent=false}
C {gnd.sym} -780 295 0 0 {name=l8 lab=GND}
C {lab_wire.sym} -780 155 0 0 {name=p5 sig_type=std_logic lab=VDD}
C {res.sym} -275 -70 1 0 {name=R3
value=10G
footprint=1206
device=resistor
m=1
}
C {res.sym} -275 5 1 0 {name=R4
value=10G
footprint=1206
device=resistor
m=1
}
C {vsource.sym} -420 -30 0 0 {name=V1 value="0 AC 1" savecurrent=false}
C {devices/code.sym} -795 -350.390625 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib cornerMOSlv.lib mos_ff
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.temp 0
"
spice_ignore=false}
C {code.sym} -795 -200 0 0 {name=AC only_toplevel=true value="
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
C {devices/launcher.sym} -765 -20 0 0 {name=h3
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
C {code.sym} -905 -200 0 0 {name=NGSPICE
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
C {vsource.sym} -700 245 0 0 {name=V2 value="dc 0.9 pwl(0 0.8 1u 0.8 1.01u 0.9 0.15m 0.9 0.15m 0)" savecurrent=false}
C {gnd.sym} -700 295 0 0 {name=l4 lab=GND}
C {lab_wire.sym} -700 155 0 0 {name=p4 sig_type=std_logic lab=VREF}
C {code.sym} -660 -195 0 0 {name=save only_toplevel=false value="
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
C {sg13g2_pr/ptap1.sym} -930 220 0 0 {name=R5
model=ptap1
spiceprefix=X
w=0.78e-6
l=0.78e-6
}
C {sg13g2_pr/sub.sym} -870 175 0 0 {name=l11 lab=sub!}
C {gnd.sym} -930 265 0 0 {name=l12 lab=GND}
C {OTA_Telescopic_TOP_IOCells.sym} -70 -30 0 0 {name=x1}
C {code_shown.sym} -1095 -505 0 0 {name=IOCells models only_toplevel=false value="
.include sg13g2_bondpad.lib 
.include diodes.lib
.lib cornerMOShv.lib mos_tt
"}
