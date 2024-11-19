;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (MINGW64)
;--------------------------------------------------------
	.module conio
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _putdec
	.globl _puthex
	.globl _putchar
	.globl _getchar
	.globl _puts
	.globl _puthex8
	.globl _puthex16
	.globl _putdec8
	.globl _putdec16
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
;C:\devarea\Libraries\msxclib\lib\conio.c:7: void putchar(const char c) __naked {
;	---------------------------------
; Function putchar
; ---------------------------------
_putchar::
;C:\devarea\Libraries\msxclib\lib\conio.c:14: __endasm;
;A	= c
	ld	e, a
	ld	c, #2
	call	5
	ret
;C:\devarea\Libraries\msxclib\lib\conio.c:15: }
;C:\devarea\Libraries\msxclib\lib\conio.c:17: char getchar(void) {
;	---------------------------------
; Function getchar
; ---------------------------------
_getchar::
;C:\devarea\Libraries\msxclib\lib\conio.c:23: __endasm;
	ld	c, #8
	call	5
	ld	a, l
	ret	; A = return value
;C:\devarea\Libraries\msxclib\lib\conio.c:24: }
	ret
;C:\devarea\Libraries\msxclib\lib\conio.c:26: void puts(const char *s) {
;	---------------------------------
; Function puts
; ---------------------------------
_puts::
;C:\devarea\Libraries\msxclib\lib\conio.c:27: while (*s != 0) {
	pop	de
	pop	bc
	push	bc
	push	de
00101$:
	ld	a, (bc)
	or	a, a
	ret	Z
;C:\devarea\Libraries\msxclib\lib\conio.c:28: putchar(*s++);
	inc	bc
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
;C:\devarea\Libraries\msxclib\lib\conio.c:30: }
	jr	00101$
;C:\devarea\Libraries\msxclib\lib\conio.c:32: void puthex(int8_t nibbles, uint16_t v) {
;	---------------------------------
; Function puthex
; ---------------------------------
_puthex::
;C:\devarea\Libraries\msxclib\lib\conio.c:33: int8_t i = nibbles - 1;
	ld	hl, #2+0
	add	hl, sp
	ld	c, (hl)
	dec	c
;C:\devarea\Libraries\msxclib\lib\conio.c:34: while (i >= 0) {
00104$:
	bit	7, c
	ret	NZ
;C:\devarea\Libraries\msxclib\lib\conio.c:35: uint16_t aux = (v >> (i << 2)) & 0x000F;
	ld	a, c
	add	a, a
	add	a, a
	ld	b, a
	ld	hl, #3
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	b
	jr	00126$
00125$:
	srl	d
	rr	e
00126$:
	djnz	00125$
	ld	a, e
	and	a, #0x0f
;C:\devarea\Libraries\msxclib\lib\conio.c:36: uint8_t n = aux & 0x000F;
	and	a, #0x0f
	ld	e, a
;C:\devarea\Libraries\msxclib\lib\conio.c:38: putchar('A' + (n - 10));
	ld	b, e
;C:\devarea\Libraries\msxclib\lib\conio.c:37: if (n > 9)
	ld	a, #0x09
	sub	a, e
	jr	NC,00102$
;C:\devarea\Libraries\msxclib\lib\conio.c:38: putchar('A' + (n - 10));
	ld	a, b
	add	a, #0x37
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
	jr	00103$
00102$:
;C:\devarea\Libraries\msxclib\lib\conio.c:40: putchar('0' + n);
	ld	a, b
	add	a, #0x30
	push	bc
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	bc
00103$:
;C:\devarea\Libraries\msxclib\lib\conio.c:41: i--;
	dec	c
;C:\devarea\Libraries\msxclib\lib\conio.c:43: }
	jr	00104$
;C:\devarea\Libraries\msxclib\lib\conio.c:45: void puthex8(uint8_t v) {
;	---------------------------------
; Function puthex8
; ---------------------------------
_puthex8::
;C:\devarea\Libraries\msxclib\lib\conio.c:46: puthex(2, (uint16_t) v);
	ld	hl, #2+0
	add	hl, sp
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	a, #0x02
	push	af
	inc	sp
	call	_puthex
	pop	af
	inc	sp
;C:\devarea\Libraries\msxclib\lib\conio.c:47: }
	ret
;C:\devarea\Libraries\msxclib\lib\conio.c:49: void puthex16(uint16_t v) {
;	---------------------------------
; Function puthex16
; ---------------------------------
_puthex16::
;C:\devarea\Libraries\msxclib\lib\conio.c:50: puthex(4, v);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ld	a, #0x04
	push	af
	inc	sp
	call	_puthex
	pop	af
	inc	sp
;C:\devarea\Libraries\msxclib\lib\conio.c:51: }
	ret
;C:\devarea\Libraries\msxclib\lib\conio.c:53: void putdec(int16_t digits, uint16_t v) {
;	---------------------------------
; Function putdec
; ---------------------------------
_putdec::
;C:\devarea\Libraries\msxclib\lib\conio.c:54: uint8_t fz = 0;
	ld	c, #0x00
;C:\devarea\Libraries\msxclib\lib\conio.c:55: while (digits > 0) {
00106$:
	xor	a, a
	ld	iy, #2
	add	iy, sp
	cp	a, 0 (iy)
	sbc	a, 1 (iy)
	jp	PO, 00131$
	xor	a, #0x80
00131$:
	ret	P
;C:\devarea\Libraries\msxclib\lib\conio.c:56: uint16_t aux = v / digits;
	pop	de
	pop	hl
	push	hl
	push	de
	push	bc
	push	hl
	ld	hl, #8
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	__divuint
	pop	af
	pop	af
	ld	de, #0x000a
	push	de
	push	hl
	call	__moduint
	pop	af
	pop	af
	pop	bc
	ld	a, l
	ld	b, a
;C:\devarea\Libraries\msxclib\lib\conio.c:58: if (n != 0 || fz != 0) {
	or	a,a
	jr	NZ,00101$
	or	a,c
	jr	Z,00102$
00101$:
;C:\devarea\Libraries\msxclib\lib\conio.c:59: putchar('0' + n);
	ld	a, b
	add	a, #0x30
	push	af
	inc	sp
	call	_putchar
	inc	sp
;C:\devarea\Libraries\msxclib\lib\conio.c:60: fz = 1;
	ld	c, #0x01
00102$:
;C:\devarea\Libraries\msxclib\lib\conio.c:62: digits /= 10;
	push	bc
	ld	hl, #0x000a
	push	hl
	ld	hl, #6
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	__divsint
	pop	af
	pop	af
	pop	bc
	ld	iy, #2
	add	iy, sp
	ld	0 (iy), l
	ld	1 (iy), h
;C:\devarea\Libraries\msxclib\lib\conio.c:63: if (digits == 1) {
	ld	a, 0 (iy)
	dec	a
	or	a, 1 (iy)
	jr	NZ,00106$
;C:\devarea\Libraries\msxclib\lib\conio.c:64: fz = 1;
	ld	c, #0x01
;C:\devarea\Libraries\msxclib\lib\conio.c:67: }
	jr	00106$
;C:\devarea\Libraries\msxclib\lib\conio.c:70: void putdec8(uint8_t v) {
;	---------------------------------
; Function putdec8
; ---------------------------------
_putdec8::
;C:\devarea\Libraries\msxclib\lib\conio.c:71: putdec(100, (uint16_t) v);
	ld	hl, #2+0
	add	hl, sp
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	hl, #0x0064
	push	hl
	call	_putdec
	pop	af
	pop	af
;C:\devarea\Libraries\msxclib\lib\conio.c:72: }
	ret
;C:\devarea\Libraries\msxclib\lib\conio.c:75: void putdec16(uint16_t v) {
;	---------------------------------
; Function putdec16
; ---------------------------------
_putdec16::
;C:\devarea\Libraries\msxclib\lib\conio.c:76: putdec(10000, v);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ld	hl, #0x2710
	push	hl
	call	_putdec
	pop	af
	pop	af
;C:\devarea\Libraries\msxclib\lib\conio.c:77: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
