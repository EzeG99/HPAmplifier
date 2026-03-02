v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {dc 0.9 pwl(0 0.8 0.005u 0.8 0.005u 0.9 0.15m 0.9 0.15m 0)} -635 510 0 0 0.4 0.4 {}
N 625 -230 625 -150 {lab=VCM}
N 625 -90 625 -70 {lab=GND}
N 190 -145 190 -125 {lab=GND}
N 190 -265 190 -205 {lab=VDD}
N 370 -145 370 -125 {lab=GND}
N 370 -265 370 -205 {lab=VREF}
N 1235 -310 1235 -280 {lab=GND}
N 1335 -310 1335 -280 {lab=GND}
N 1335 -450 1335 -370 {lab=Vout2}
N 625 -230 745 -230 {lab=VCM}
N 745 -370 745 -230 {lab=VCM}
N 745 -370 775 -370 {lab=VCM}
N 515 -550 515 -230 {lab=VCM}
N 515 -550 775 -550 {lab=VCM}
N 515 -230 625 -230 {lab=VCM}
N 1145 -470 1235 -470 {lab=Vout1}
N 1235 -470 1235 -370 {lab=Vout1}
N 1145 -450 1335 -450 {lab=Vout2}
N 775 -550 775 -520 {lab=VCM}
N 775 -520 845 -520 {lab=VCM}
N 775 -400 775 -370 {lab=VCM}
N 775 -400 845 -400 {lab=VCM}
N 845 -500 845 -480 {lab=#net1}
N 845 -440 845 -420 {lab=#net2}
N 995 -370 995 -360 {lab=GND}
N 960 -570 960 -550 {lab=VREF}
N 995 -570 995 -550 {lab=VDD}
N 1040 -370 1085 -370 {lab=#net3}
C {vsource.sym} 625 -120 0 0 {name=V7 value=1.25 savecurrent=false}
C {gnd.sym} 625 -70 0 0 {name=l5 lab=GND}
C {vsource.sym} 190 -175 0 0 {name=V1 value="dc 1.8 pwl(0 0 10n 1.8)" savecurrent=false}
C {gnd.sym} 190 -125 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 190 -265 0 0 {name=p1 sig_type=std_logic lab=VDD}
C {vsource.sym} 370 -175 0 0 {name=V2 value="dc 0.9" savecurrent=false}
C {gnd.sym} 370 -125 0 0 {name=l4 lab=GND}
C {lab_wire.sym} 370 -265 0 0 {name=p4 sig_type=std_logic lab=VREF}
C {capa-2.sym} 1235 -340 0 0 {name=C1
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 1235 -280 0 0 {name=l10 lab=GND}
C {capa-2.sym} 1335 -340 0 0 {name=C2
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 1335 -280 0 0 {name=l7 lab=GND}
C {lab_wire.sym} 1335 -450 0 0 {name=p19 sig_type=std_logic lab=Vout2}
C {lab_wire.sym} 1235 -410 0 0 {name=p18 sig_type=std_logic lab=Vout1}
C {devices/code.sym} 85 -620.390625 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.temp 65
"}
C {code.sym} 215 -620 0 0 {name=AC only_toplevel=true value="
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
C {devices/launcher.sym} 545 -620 0 0 {name=h3
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
C {code.sym} 335 -615 0 0 {name=save only_toplevel=false value="
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
C {code.sym} 225 -470 0 0 {name=TRAN
only_toplevel=true
value="

.control
 set color0 = white

set wr_singlescale
set wr_vecnames

save all
tran 10p 500n
*write NMOS_diode_large_signal.raw

let VCM = v(Vout1)
let VDD = v(VDD)
let IDD = -i(V1)

*wrdata VCM_ss_10ns_DC.txt VCM
*wrdata IDD_ss_10ns_DC.txt IDD

plot VCM
plot VDD
plot IDD

let Vo1 = v(x1.Vo1)
let Vo2 = v(x1.Vo2)

let Vo = Vo1-Vo2

wrdata Vo Vo

reset    
noise v(Vout1) V5 dec 100 1 0.5e9 1
setplot noise1
*plot onoise_spectrum
setplot noise2
print onoise_total

.endc
"}
C {lab_wire.sym} 710 -550 0 0 {name=p7 sig_type=std_logic lab=VCM}
C {code.sym} 335 -470 0 0 {name=STEP
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
C {gnd.sym} 995 -360 0 0 {name=l1 lab=GND}
C {lab_wire.sym} 960 -570 0 0 {name=p2 sig_type=std_logic lab=VREF}
C {lab_wire.sym} 995 -570 0 0 {name=p3 sig_type=std_logic lab=VDD}
C {OTA_Telescopic_TOP_wp.sym} 995 -460 0 0 {name=x2}
