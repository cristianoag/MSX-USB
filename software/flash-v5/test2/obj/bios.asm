;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (MINGW64)
;--------------------------------------------------------
	.module bios
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _clearKeyBuf
	.globl _readSlot
	.globl _writeSlot
	.globl _putRamFrame1
	.globl _putRamFrame2
	.globl _putSlotFrame1
	.globl _putSlotFrame2
	.globl _resetSystem
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;C:\devarea\Libraries\msxclib\lib\bios.c:21: void clearKeyBuf(void) __naked {
;	---------------------------------
; Function clearKeyBuf
; ---------------------------------
_clearKeyBuf::
;C:\devarea\Libraries\msxclib\lib\bios.c:26: __endasm;
	ld	ix, #0x0156
	ld	iy, (0xFCC1 -1)
	jp	0x001C
;C:\devarea\Libraries\msxclib\lib\bios.c:27: }
;C:\devarea\Libraries\msxclib\lib\bios.c:33: unsigned char readSlot(unsigned char slot, unsigned int addr) __naked {
;	---------------------------------
; Function readSlot
; ---------------------------------
_readSlot::
;C:\devarea\Libraries\msxclib\lib\bios.c:40: __endasm;
;	A = slot
;	DE = addr
	ex	de, hl
	call	0x000C
	ret	; A = return value
;C:\devarea\Libraries\msxclib\lib\bios.c:41: }
;C:\devarea\Libraries\msxclib\lib\bios.c:47: void writeSlot(unsigned char slot, unsigned int addr, unsigned char byte) __naked {
;	---------------------------------
; Function writeSlot
; ---------------------------------
_writeSlot::
;C:\devarea\Libraries\msxclib\lib\bios.c:57: __endasm;
;	A = slot
;	DE = addr
;	stack = byte
	ex	de, hl
	ld	iy, #0
	add	iy, sp
	ld	e, 2(iy) ; byte
	jp	0x0014
;C:\devarea\Libraries\msxclib\lib\bios.c:58: }
;C:\devarea\Libraries\msxclib\lib\bios.c:64: void putRamFrame1(void) __naked {
;	---------------------------------
; Function putRamFrame1
; ---------------------------------
_putRamFrame1::
;C:\devarea\Libraries\msxclib\lib\bios.c:69: __endasm;
	ld	a, (0xF342)
	ld	h, #0x40
	jp	0x0024
;C:\devarea\Libraries\msxclib\lib\bios.c:70: }
;C:\devarea\Libraries\msxclib\lib\bios.c:76: void putRamFrame2(void) __naked {
;	---------------------------------
; Function putRamFrame2
; ---------------------------------
_putRamFrame2::
;C:\devarea\Libraries\msxclib\lib\bios.c:81: __endasm;
	ld	a, (0xF343)
	ld	h, #0x80
	jp	0x0024
;C:\devarea\Libraries\msxclib\lib\bios.c:82: }
;C:\devarea\Libraries\msxclib\lib\bios.c:88: void putSlotFrame1(unsigned char slot) __naked {
;	---------------------------------
; Function putSlotFrame1
; ---------------------------------
_putSlotFrame1::
;C:\devarea\Libraries\msxclib\lib\bios.c:93: __endasm;
;	A = slot
	ld	h, #0x40
	jp	0x0024
;C:\devarea\Libraries\msxclib\lib\bios.c:94: }
;C:\devarea\Libraries\msxclib\lib\bios.c:100: void putSlotFrame2(unsigned char slot) __naked {
;	---------------------------------
; Function putSlotFrame2
; ---------------------------------
_putSlotFrame2::
;C:\devarea\Libraries\msxclib\lib\bios.c:105: __endasm;
;	A = slot
	ld	h, #0x80
	jp	0x0024
;C:\devarea\Libraries\msxclib\lib\bios.c:106: }
;C:\devarea\Libraries\msxclib\lib\bios.c:112: void resetSystem(void) __naked {
;	---------------------------------
; Function resetSystem
; ---------------------------------
_resetSystem::
;C:\devarea\Libraries\msxclib\lib\bios.c:117: __endasm;
	ld	ix, #0x0000
	ld	iy, (0xFCC1 -1)
	jp	0x001C
;C:\devarea\Libraries\msxclib\lib\bios.c:118: }
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
