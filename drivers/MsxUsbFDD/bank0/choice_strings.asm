; MSXUSB USB FDD BIOS
; Based on the Rookie Drive USB FDD BIOS created by Konamiman in 2018
; This version is adapted to work with the latest version of the MSXUSB project
;
; This file contains the choice string for the FORMAT command.
; It needs to be in a separate file because FORMAT lives in ROM bank 1,
; but this string needs to be in bank 0.

CHOICE_S:
    db "1 - 720K, full format",13,10
    db "2 - 720K, quick format",13,10
    db "3 - 1.44M, full format",13,10
    db "4 - 1.44M, quick format",13,10
    db 0
