<img width="797" height="695" alt="image" src="https://github.com/user-attachments/assets/34c5182e-b2e6-403a-8e89-d8d6b84ccede" /># UNIC-CASS Postulations by Fundación Fulgor

This repository contains 5 versions of the HPA design. The first 3 are outdated versions, while the one called "OTA_Telescopic" includes the latest progress. In addition, the "OTA_Telescopic_TEST" folder contains tests of alternative solutions to issues with the tools/software.

Inside the "OTA_Telescopic" folder there are three directories:

  "Schematics_and_Symbols": contains all schematics, symbols, and IOCells for the designs.

      OTA_Telescopic_CMFB.sch/sym: schematic and symbol of the common-mode feedback (CMFB).

      OTA_Telescopic_currentRef.sch/sym: schematic and symbol of the current reference.

      OTA_Telescopic_core.sch/sym: schematic and symbol of the OTA core.

      OTA_Telescopic_FB.sch/sym: schematic and symbol of the OTA with resistive feedback.

      OTA_Telescopic_TOP_wp.sch/sym: schematic and symbol of all HPA blocks integrated together, but with floating/unconnected terminals left for measuring the circuit response in post-layout simulations.

      OTA_Telescopic_TOP_IOCells.sch/sym: schematic and symbol of OTA_Telescopic_TOP_wp.sch, but including the IOCell connections in order to examine their effects on circuit operation. 

      HPA.sch/sym: schematic and symbol of the HPA.

      HPA_IOCells.sch: schematic of the HPA including the IOCell connections, provided as a reference for how the terminals are wired.

  "Layout_and_Related_files": contains the layouts of the designs along with other related files.

      OTA_Telescopic_CMFB.gds: contains the layout of the common-mode feedback circuit, DRC- and LVS-clean.

      OTA_Telescopic_currentRef.gds: contains the layout of the current reference circuit, DRC- and LVS-clean.

      OTA_Telescopic_core.gds: contains the layout of the OTA core, DRC- and LVS-clean.

      OTA_Telescopic_FB.gds: contains the layout of the OTA with resistive feedback, DRC- and LVS-clean.

      OTA_Telescopic_TOP_wp.gds: contains the layout of all HPA blocks integrated together, DRC- and LVS-clean, but with floating/unconnected terminals left for measuring the circuit response in post-layout simulations.

      HPA.gds: contains the layout of the HPA circuit, DRC- and LVS-clean.

      HPA_user_project_wrapper.gds: contains the layout of the HPA inside the pad ring.

  "Testbenchs": contains all tests performed on the design, with and without IOCells, as well as the "simulations" folder.

      OTA_Telescopic_TOP_TB_CMFB.sch: CMFB stability testbench.

      OTA_Telescopic_TOP_TB_CL.sch: closed-loop testbench.

      OTA_Telescopic_TOP_TB_OL.sch: open-loop testbench.

      OTA_Telescopic_TOP_TB_StartUp.sch: startup testbench.

      Testbenches that include "io" correspond to the same analyses performed while accounting for the effects of the IOCells.
