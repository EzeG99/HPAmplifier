v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {dc 0.9 pwl(0 0.8 0.005u 0.8 0.005u 0.9 0.15m 0.9 0.15m 0)} -635 510 0 0 0.4 0.4 {}
T {Tiene problemas de convergencia, debe simularse DC} -1090 -90 0 0 0.4 0.4 {}
N -75 150 -75 230 {lab=VCM}
N -75 290 -75 310 {lab=GND}
N -510 235 -510 255 {lab=GND}
N -330 235 -330 255 {lab=GND}
N -330 115 -330 175 {lab=VREF}
N 535 70 535 100 {lab=GND}
N 635 70 635 100 {lab=GND}
N 635 -70 635 10 {lab=Vout2}
N -75 150 45 150 {lab=VCM}
N 45 10 45 150 {lab=VCM}
N 45 10 75 10 {lab=VCM}
N -185 -170 -185 150 {lab=VCM}
N -185 -170 75 -170 {lab=VCM}
N -185 150 -75 150 {lab=VCM}
N 445 -90 535 -90 {lab=Vout1}
N 535 -90 535 10 {lab=Vout1}
N 445 -70 635 -70 {lab=Vout2}
N 75 -170 75 -140 {lab=VCM}
N 75 -140 145 -140 {lab=VCM}
N 75 -25 75 10 {lab=VCM}
N 75 -25 145 -25 {lab=VCM}
N 145 -120 145 -100 {lab=#net1}
N 145 -65 145 -45 {lab=#net2}
N 295 10 295 20 {lab=GND}
N 260 -190 260 -170 {lab=VREF}
N 295 -190 295 -170 {lab=VDD}
N 340 10 385 10 {lab=#net3}
N -670 240 -670 255 {lab=GND}
N -670 165 -670 180 {lab=sub!}
N -670 165 -610 165 {lab=sub!}
N -510 115 -510 175 {lab=VDD}
C {vsource.sym} -75 260 0 0 {name=V7 value=1.25 savecurrent=false}
C {gnd.sym} -75 310 0 0 {name=l5 lab=GND}
C {vsource.sym} -510 205 0 0 {name=V1 value=1.98 savecurrent=false}
C {gnd.sym} -510 255 0 0 {name=l3 lab=GND}
C {lab_wire.sym} -510 115 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {vsource.sym} -330 205 0 0 {name=V2 value="dc 0.9" savecurrent=false}
C {gnd.sym} -330 255 0 0 {name=l4 lab=GND}
C {lab_wire.sym} -330 115 0 0 {name=p4 sig_type=std_logic lab=VREF}
C {capa-2.sym} 535 40 0 0 {name=C1
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 535 100 0 0 {name=l10 lab=GND}
C {capa-2.sym} 635 40 0 0 {name=C2
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 635 100 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 635 -70 0 0 {name=p19 sig_type=std_logic lab=Vout2}
C {lab_wire.sym} 535 -30 0 0 {name=p18 sig_type=std_logic lab=Vout1}
C {devices/code.sym} -615 -240.390625 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib cornerMOSlv.lib mos_ff
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.temp 0
"}
C {code.sym} -485 -240 0 0 {name=AC only_toplevel=true value="
.control
save all
 set color0 = white

* AC simulation
ac dec 1000 1 1T
let Av = db(v(Vout1)-v(Vout2))
meas ac Ao FIND Av WHEN frequency=10
let ABW = Ao-3
meas ac BW WHEN Av=ABW
meas ac UGBW WHEN Av=0
let phase_vec = 180/pi*cph(v(Vout1)-v(Vout2))

* Phase margin (PM)
meas ac phase FIND phase_vec WHEN frequency=UGBW 
let PM = phase+180
print PM

* Gain margin (GM)
meas ac freq180 FIND frequency WHEN phase_vec=-180
meas ac gain FIND Av WHEN frequency=freq180
let GM = 0-gain

print GM
plot Av
plot phase_vec

write AC_OL.raw
wrdata AvCL_ Av

*DC simulation

op
let vout_dc = v(Vout1)
print vout_dc
write OTA_Telescopic_TB2_CL.raw

.endc
"

spice_ignore=true}
C {devices/launcher.sym} -155 -240 0 0 {name=h3
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
C {code.sym} -365 -235 0 0 {name=save only_toplevel=false value="
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


*CMFB

let x2_vdssat_M0 = @m.x2.xm0.msky130_fd_pr__pfet_01v8_lvt[vdsat]
let x2_vth_M0 = @m.x2.xm0.msky130_fd_pr__pfet_01v8_lvt[vth]

print x2_vdssat_M0
print x2_vth_M0

.endc

"
spice_ignore=true
}
C {lab_wire.sym} 10 -170 0 0 {name=p7 sig_type=std_logic lab=VCM}
C {code.sym} -365 -90 0 0 {name=STEP
only_toplevel=true
value="

.temp 27
.control

save all
tran 0.001n 0.05u

plot v(Vout2)
plot v(VREF)

.endc
"
spice_ignore=true}
C {gnd.sym} 295 20 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 260 -190 0 0 {name=p2 sig_type=std_logic lab=VREF}
C {lab_wire.sym} 295 -190 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {sg13g2_pr/ptap1.sym} -670 210 0 0 {name=R5
model=ptap1
spiceprefix=X
w=0.78e-6
l=0.78e-6
}
C {sg13g2_pr/sub.sym} -610 165 0 0 {name=l11 lab=sub!}
C {gnd.sym} -670 255 0 0 {name=l12 lab=GND}
C {OTA_Telescopic_TOP_IOCells.sym} 295 -80 0 0 {name=x1}
C {code_shown.sym} -805 -415 0 0 {name=IOCells models only_toplevel=false value="
.include sg13g2_bondpad.lib 
.include diodes.lib
.lib cornerMOShv.lib mos_tt
"}
C {code.sym} -485 -90 0 0 {name=TRAN
only_toplevel=true
value="

.control
 set color0 = white

set wr_singlescale
set wr_vecnames

save v(VDD) v(Vout1) v(Vout2) i(V1)
save v(x1.Vo1) v(x1.Vo2)

.options method=gear
tran 10p 500n
*write NMOS_diode_large_signal.raw

let VCM = v(Vout1)
let VDD = v(VDD)
let IDD = -i(V1)

wrdata VCM_tt_10ns_DC_io.txt VCM
wrdata IDD_tt_10ns_DC_io.txt IDD

plot VCM
plot VDD
plot IDD

let Vo1 = v(x1.Vo1)
let Vo2 = v(x1.Vo2)

let Vo = Vo1-Vo2

wrdata Vo Vo

.endc
"}
