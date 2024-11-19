;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (MINGW64)
;--------------------------------------------------------
	.module mem
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpy
	.globl _memset
	.globl _memcmp
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
;C:\devarea\Libraries\msxclib\lib\mem.c:8: void memcpy(uint8_t *dest, uint8_t *src, uint16_t n) {
;	---------------------------------
; Function memcpy
; ---------------------------------
_memcpy::
	push	af
;C:\devarea\Libraries\msxclib\lib\mem.c:9: while (n > 0) {
	ld	hl, #4
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #6+0
	add	hl, sp
	ld	a, (hl)
	ld	iy, #0
	add	iy, sp
	ld	0 (iy), a
	ld	hl, #6+1
	add	hl, sp
	ld	a, (hl)
	ld	iy, #0
	add	iy, sp
	ld	1 (iy), a
	ld	hl, #8
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
00101$:
	ld	a, d
	or	a, e
	jr	Z,00104$
;C:\devarea\Libraries\msxclib\lib\mem.c:10: *dest = *src;
	pop	hl
	push	hl
	ld	a, (hl)
	ld	(bc), a
;C:\devarea\Libraries\msxclib\lib\mem.c:11: dest++;
	inc	bc
;C:\devarea\Libraries\msxclib\lib\mem.c:12: src++;
	ld	iy, #0
	add	iy, sp
	inc	0 (iy)
	jr	NZ,00117$
	inc	1 (iy)
00117$:
;C:\devarea\Libraries\msxclib\lib\mem.c:13: n--;
	dec	de
	jr	00101$
00104$:
;C:\devarea\Libraries\msxclib\lib\mem.c:15: }
	pop	af
	ret
;C:\devarea\Libraries\msxclib\lib\mem.c:18: void memset(uint8_t *s, uint8_t c, uint16_t n) {
;	---------------------------------
; Function memset
; ---------------------------------
_memset::
;C:\devarea\Libraries\msxclib\lib\mem.c:19: while (n > 0) {
	pop	de
	pop	bc
	push	bc
	push	de
	ld	hl, #5
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
00101$:
	ld	a, d
	or	a, e
	ret	Z
;C:\devarea\Libraries\msxclib\lib\mem.c:20: *s = c;
	ld	hl, #4+0
	add	hl, sp
	ld	a, (hl)
	ld	(bc), a
;C:\devarea\Libraries\msxclib\lib\mem.c:21: s++;
	inc	bc
;C:\devarea\Libraries\msxclib\lib\mem.c:22: n--;
	dec	de
;C:\devarea\Libraries\msxclib\lib\mem.c:24: }
	jr	00101$
;C:\devarea\Libraries\msxclib\lib\mem.c:27: unsigned char memcmp(uint8_t *dest, uint8_t *src, uint16_t n)
;	---------------------------------
; Function memcmp
; ---------------------------------
_memcmp::
	push	af
	push	af
;C:\devarea\Libraries\msxclib\lib\mem.c:29: while (n > 0) {
	ld	hl, #6
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #8+0
	add	hl, sp
	ld	a, (hl)
	ld	iy, #2
	add	iy, sp
	ld	0 (iy), a
	ld	hl, #8+1
	add	hl, sp
	ld	a, (hl)
	ld	iy, #2
	add	iy, sp
	ld	1 (iy), a
	ld	hl, #10
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
00103$:
	ld	a, d
	or	a, e
	jr	Z,00105$
;C:\devarea\Libraries\msxclib\lib\mem.c:30: if (*dest != *src) {
	ld	a, (bc)
	ld	iy, #1
	add	iy, sp
	ld	0 (iy), a
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	inc	sp
	push	af
	inc	sp
	ld	hl, #1+0
	add	hl, sp
	ld	a, (hl)
	ld	iy, #0
	add	iy, sp
	sub	a, 0 (iy)
	jr	Z,00102$
;C:\devarea\Libraries\msxclib\lib\mem.c:31: return 1;
	ld	l, #0x01
	jr	00106$
00102$:
;C:\devarea\Libraries\msxclib\lib\mem.c:33: dest++;
	inc	bc
;C:\devarea\Libraries\msxclib\lib\mem.c:34: src++;
	ld	iy, #2
	add	iy, sp
	inc	0 (iy)
	jr	NZ,00124$
	inc	1 (iy)
00124$:
;C:\devarea\Libraries\msxclib\lib\mem.c:35: n--;
	dec	de
	jr	00103$
00105$:
;C:\devarea\Libraries\msxclib\lib\mem.c:37: return 0;
	ld	l, #0x00
00106$:
;C:\devarea\Libraries\msxclib\lib\mem.c:38: }
	pop	af
	pop	af
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
