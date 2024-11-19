# DIY Instructions

## PCB

If you prefer using PLCC versions of the CPLD and flash memory chips, I recommend the v4 PCB by @cristianoag. This version fits into a Konami-style cartridge case and includes a switch to toggle between two ROM images. Be sure to use the rev4 CPLD code to enable this functionality. You can find the Gerber files and CPLD code for v4 at these links: [Gerber Files](hardware/v4/kicad-cpld-rev4/production) and [CPLD Code](hardware/v4/quartus-rev4).

If you’re comfortable with SMD soldering and want to avoid the challenges of sourcing 7064SLC or 7032SLC CPLDs without JTAG locks, use the v5 CPLD code and PCBs instead. The files for these are available at: [CPLD Code](hardware/v5/cpld) and [PCB Files](hardware/v5/kicad).

Please note: there are two folders for the PCBs and CPLD code because there are different types of CH376 modules available. Depending on the module you have, you’ll need to use a specific version of the PCB. Compare the signals of your module with those on the PCBs to ensure you select the correct one.

For the CPLD code, there are two versions to support the two types of CPLDs you can use for the SMD version of the project: 7064STC44 or 7032STC44.

## Bill of Materials and Setup Instructions

Please refer to the appropriate bill of materials and instructions according to the PCB version you select:

* [V4](hardware/v4/README.MD)
* [V5](hardware/v5/README.MD)

