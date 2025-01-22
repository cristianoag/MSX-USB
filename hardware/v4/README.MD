Here is the list of materials required to build the MSXUSB cartridge with the v4 .

| References | Values              | Footprint                                             | Qty | Link        |
|------------|---------------------|-------------------------------------------------------|-----|-------------|
| C2, C3, C4 | 100 nf (0.1 µF)     | C_0805_2012Metric_Pad1.18×1.45mm_HandSolder          | 3   | [AliExpress](https://www.aliexpress.com) |
| C1         | 100 µF 10V          | CP_Radial_D5.0mm_P2.50mm                              | 1   | [AliExpress](https://www.aliexpress.com) |
| R1         | 4K7                 | R_0805_2012Metric_Pad1.20×1.40mm_HandSolder          | 1   | [AliExpress](https://www.aliexpress.com) |
| U1         | EPM7064SLC44-10(*)  | PLCC44                                               | 1   | [UTSource](https://www.utsource.net)     |
| U2         | AM29F040B-70JC      | PLCC-32_THT-Socket                                   | 1   | [AliExpress](https://www.aliexpress.com) |
| SW1        | SK-12D07VG4         | SK12D07VG4 toggle switch (small) 90 degrees          | 1   | [AliExpress](https://www.aliexpress.com) |
| Module     | CH376S              | CH376S U Disk Read Write Module Supports USB Control Transfer 12MHz | 1 | [AliExpress](https://www.aliexpress.com) |
| Socket 1   | PLCC 32 DIP         | Low profile DIP PLCC Socket adapter                 | 1   | [AliExpress](https://www.aliexpress.com) |
| Socket 2   | PLCC 44 DIP         | Low profile DIP PLCC Socket adapter                 | 1   | [AliExpress](https://www.aliexpress.com) |

(*) You can also use ATMEL’s ATF1504AS instead. Just make sure to read the instructions below if you decide to use that one.

## Step 1: Program CPLD

For v4 you will need the obsolete part EPM7064SLC44-10. You can get them from AliExpress and other places but as they are refurbished/recovered from dumpsters expect to have only 50% working, so order double if you decide to go with Ali Express. I provided links to UTSource on the table above as they are able to provide units from new old stock.

You will also need an Altera programmer such as USB blaster. You can purchase those from Ali Express or any other electronics shop around. You will use it to program the CPLD.

Next, you have to download Quartus software version 13.0sp1, as newer versions do not support EPM7064. Go to https://fpgasoftware.intel.com/?edition=lite and proceed with the download and installation.

Connect the programmer to the board and also power the board externally with 5V, you can do it using the expansion header or CH3786 header. Find the pins VCC and GND and you are done. Failing to do so it will result in an JTAG read error.

Next, we check your connection and if everything went ok you will see this message.

```
$ ./quartus_pgm --auto
Info (213045): Using programming cable "USB-Blaster [3-1]"
1) USB-Blaster [3-1]
  070640DD   EPM7064S

Info: Quartus II 32-bit Programmer was successful. 0 errors, 0 warnings
    Info: Peak virtual memory: 127 megabytes
    Info: Processing ended: Sat Dec 18 10:16:56 2021
    Info: Elapsed time: 00:00:00
    Info: Total CPU time (on all processors): 00:00:00
```

And it has arrived the amazing moment where you are going to program it (you can do it with the command line quartus_pgm or with the GUI tool quartus) with the following file: [MSXUSB.pof](quartus-rev4/output_files/MSXUSB.pof)

## License

![Open Hardware](/images/ccans.png)

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/).

* If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
* You may not use the material for commercial purposes.
* You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

**ATTENTION**

This project was made for the retro community and not for commercial purposes. So only retro hardware forums and individual people can build this project.

THE SALE OF ANY PART OF THIS PROJECT WITHOUT EXPRESS AUTHORIZATION IS PROHIBITED!