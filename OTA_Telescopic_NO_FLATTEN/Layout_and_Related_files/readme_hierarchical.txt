##inv_PI_d2 — jerarquía + autoload + leaf PCells (sin gallery)

klayout -n sg13g2 -zz -r /foss/designs/PhaseInterpolator/hierarchical.py \
  -rd netlist=/foss/designs/PhaseInterpolator/Custom_std_cells/simulations/inv_PI_d2.spice \
  -rd output=/foss/designs/PhaseInterpolator/Custom_std_cells/inv_PI_d2.gds \
  -rd autoload=1 \
  -rd reuse_dir=/foss/designs/PhaseInterpolator/Custom_std_cells \
  -rd leaf=1 \
  -rd gallery=0

##nand_custom — top “solo dispositivos” (sin reusar celdas jerárquicas), genera PCells leaf directamente (sin gallery)

klayout -n sg13g2 -zz -r /foss/designs/PhaseInterpolator/hierarchical.py \
  -rd netlist=/foss/designs/PhaseInterpolator/Custom_std_cells/simulations/nand_custom.spice \
  -rd output=/foss/designs/PhaseInterpolator/Custom_std_cells/nand_custom.gds \
  -rd leaf=1 \
  -rd gallery=0
