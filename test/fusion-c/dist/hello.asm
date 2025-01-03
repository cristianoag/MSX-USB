;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.0 #11195 (MINGW64)
;--------------------------------------------------------
	.module hello
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _FT_errorHandler
	.globl _FT_SetName
	.globl _printf
	.globl _FcbOpen
	.globl _WaitKey
	.globl _Width
	.globl _SetColors
	.globl _Exit
	.globl _Screen
	.globl _Print
	.globl _file
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_file::
	.ds 37
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
;src/hello.c:16: void FT_SetName(FCB *p_fcb, const char *p_name) 
;	---------------------------------
; Function FT_SetName
; ---------------------------------
_FT_SetName::
	call	___sdcc_enter_ix
	push	af
	push	af
	dec	sp
;src/hello.c:19: memset(p_fcb, 0, sizeof(FCB));
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	ld	b, #0x25
00178$:
	ld	(hl), #0x00
	inc	hl
	djnz	00178$
;src/hello.c:20: for (i = 0; i < 11; i++) {
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	ld	hl, #0x0001
	add	hl, de
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	c, #0x00
00106$:
;src/hello.c:21: p_fcb->name[i] = ' ';
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	b, #0x00
	add	hl, bc
	ld	(hl), #0x20
;src/hello.c:20: for (i = 0; i < 11; i++) {
	inc	c
	ld	a, c
	sub	a, #0x0b
	jr	C,00106$
;src/hello.c:23: for (i = 0; (i < 8) && (p_name[i] != 0) && (p_name[i] != '.'); i++) {
	ld	-2 (ix), #0x00
00111$:
	ld	a, 6 (ix)
	add	a, -2 (ix)
	ld	l, a
	ld	a, 7 (ix)
	adc	a, #0x00
	ld	h, a
	ld	a, -2 (ix)
	inc	a
	ld	-1 (ix), a
	ld	c, (hl)
	ld	a, c
	sub	a, #0x2e
	jr	NZ, 00180$
	ld	a, #0x01
	.db	#0x20
00180$:
	xor	a, a
00181$:
	ld	l, a
	ld	a, -2 (ix)
	sub	a, #0x08
	jr	NC,00102$
	ld	a, c
	or	a, a
	jr	Z,00102$
	bit	0, l
	jr	NZ,00102$
;src/hello.c:24: p_fcb->name[i] = p_name[i];
	ld	a, -4 (ix)
	add	a, -2 (ix)
	ld	l, a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	h, a
	ld	(hl), c
;src/hello.c:23: for (i = 0; (i < 8) && (p_name[i] != 0) && (p_name[i] != '.'); i++) {
	ld	a, -1 (ix)
	ld	-2 (ix), a
	jr	00111$
00102$:
;src/hello.c:26: if (p_name[i] == '.') {
	ld	a, l
	or	a, a
	jr	Z,00118$
;src/hello.c:27: i++;
	ld	a, -1 (ix)
	ld	-5 (ix), a
;src/hello.c:28: for (j = 0; (j < 3) && (p_name[i + j] != 0) && (p_name[i + j] != '.'); j++) {
	ld	hl, #0x0009
	add	hl, de
	ex	de, hl
	ld	c, #0x00
00116$:
	ld	a, c
	sub	a, #0x03
	jr	NC,00118$
	ld	l, -5 (ix)
	ld	h, #0x00
	ld	-4 (ix), c
	ld	-3 (ix), #0x00
	ld	a, l
	add	a, -4 (ix)
	ld	-2 (ix), a
	ld	a, h
	adc	a, -3 (ix)
	ld	-1 (ix), a
	ld	a, 6 (ix)
	add	a, -2 (ix)
	ld	l, a
	ld	a, 7 (ix)
	adc	a, -1 (ix)
	ld	h, a
	ld	b, (hl)
	ld	a, b
	or	a, a
	jr	Z,00118$
	ld	a, b
	sub	a, #0x2e
	jr	Z,00118$
;src/hello.c:29: p_fcb->ext[j] = p_name[i + j];
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), b
;src/hello.c:28: for (j = 0; (j < 3) && (p_name[i + j] != 0) && (p_name[i + j] != '.'); j++) {
	inc	c
	jr	00116$
00118$:
;src/hello.c:32: }
	ld	sp, ix
	pop	ix
	ret
_Done_Version_tag:
	.ascii "Made with FUSION-C 1.3 R21010 (c)EBSOFT:2021"
	.db 0x00
;src/hello.c:34: void FT_errorHandler(char n, char *name) // Gère les erreurs
;	---------------------------------
; Function FT_errorHandler
; ---------------------------------
_FT_errorHandler::
;src/hello.c:36: Screen(0);
	xor	a, a
	push	af
	inc	sp
	call	_Screen
	inc	sp
;src/hello.c:37: SetColors(15,6,6);
	ld	de, #0x0606
	push	de
	ld	a, #0x0f
	push	af
	inc	sp
	call	_SetColors
	pop	af
	inc	sp
;src/hello.c:38: switch (n)
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	dec	a
	jr	Z,00101$
	ld	a, 0 (iy)
	sub	a, #0x02
	jr	Z,00102$
	ld	a, 0 (iy)
	sub	a, #0x03
	jr	Z,00103$
	jr	00104$
;src/hello.c:40: case 1:
00101$:
;src/hello.c:41: Print("\n\rFAILED: fcb_open(): ");
	ld	hl, #___str_1
	push	hl
	call	_Print
	pop	af
;src/hello.c:42: Print(name);
	ld	hl, #3
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_Print
	pop	af
;src/hello.c:43: break;
	jr	00104$
;src/hello.c:45: case 2:
00102$:
;src/hello.c:46: Print("\n\rFAILED: fcb_close():");
	ld	hl, #___str_2
	push	hl
	call	_Print
	pop	af
;src/hello.c:47: Print(name);
	ld	hl, #3
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_Print
	pop	af
;src/hello.c:48: break;  
	jr	00104$
;src/hello.c:50: case 3:
00103$:
;src/hello.c:51: Print("\n\rStop Kidding, run me on MSX2 !");
	ld	hl, #___str_3
	push	hl
	call	_Print
	pop	af
;src/hello.c:53: }
00104$:
;src/hello.c:54: Exit(0);
	ld	l, #0x00
;src/hello.c:55: }
	jp  _Exit
___str_1:
	.db 0x0a
	.db 0x0d
	.ascii "FAILED: fcb_open(): "
	.db 0x00
___str_2:
	.db 0x0a
	.db 0x0d
	.ascii "FAILED: fcb_close():"
	.db 0x00
___str_3:
	.db 0x0a
	.db 0x0d
	.ascii "Stop Kidding, run me on MSX2 !"
	.db 0x00
;src/hello.c:57: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	call	___sdcc_enter_ix
	ld	hl, #-11
	add	hl, sp
	ld	sp, hl
;src/hello.c:59: Screen(0);
	xor	a, a
	push	af
	inc	sp
	call	_Screen
	inc	sp
;src/hello.c:60: Width(40);
	ld	a, #0x28
	push	af
	inc	sp
	call	_Width
	inc	sp
;src/hello.c:61: Print("Hello ! \n\n");
	ld	hl, #___str_5
	push	hl
	call	_Print
;src/hello.c:62: Print("Your are using FUSION-C \n\rversion:");
	ld	hl, #___str_6
	ex	(sp),hl
	call	_Print
;src/hello.c:64: Print("  Rev.");
	ld	hl, #___str_7
	ex	(sp),hl
	call	_Print
	pop	af
;src/hello.c:67: char file_name[] = "nextor.rom";
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	a, #0x6e
	ld	(de), a
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x65
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	(hl), #0x78
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x74
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x6f
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x72
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x2e
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x72
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x6f
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x6d
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x00
;src/hello.c:69: FT_SetName( &file, file_name );
	ld	c, e
	ld	b, d
	push	de
	push	bc
	ld	hl, #_file
	push	hl
	call	_FT_SetName
	pop	af
	ld	hl, #_file
	ex	(sp),hl
	call	_FcbOpen
	pop	af
	ld	a, l
	pop	de
	or	a, a
	jr	Z,00102$
;src/hello.c:72: FT_errorHandler(1, file_name);
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	call	_FT_errorHandler
	pop	af
	inc	sp
00102$:
;src/hello.c:75: printf("\n\r\n\rSize: %lu\n\r",file.file_size);
	ld	de, (#_file + 16)
	ld	hl, (#_file + 18)
	ld	bc, #___str_8+0
	push	hl
	push	de
	push	bc
	call	_printf
	pop	af
	pop	af
	pop	af
;src/hello.c:76: WaitKey();
	call	_WaitKey
;src/hello.c:77: Exit(0);
	ld	l, #0x00
	call	_Exit
;src/hello.c:79: }
	ld	sp, ix
	pop	ix
	ret
___str_5:
	.ascii "Hello ! "
	.db 0x0a
	.db 0x0a
	.db 0x00
___str_6:
	.ascii "Your are using FUSION-C "
	.db 0x0a
	.db 0x0d
	.ascii "version:"
	.db 0x00
___str_7:
	.ascii "  Rev."
	.db 0x00
___str_8:
	.db 0x0a
	.db 0x0d
	.db 0x0a
	.db 0x0d
	.ascii "Size: %lu"
	.db 0x0a
	.db 0x0d
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
