;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.0 #11195 (MINGW64)
;--------------------------------------------------------
	.module flash
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _FT_SetName
	.globl _ceilf
	.globl _strcmp
	.globl _strcat
	.globl _puts
	.globl _sprintf
	.globl _printf
	.globl _FcbRead
	.globl _FcbClose
	.globl _FcbOpen
	.globl _ReadSP
	.globl _MemFill
	.globl _flash_segment
	.globl _file_segment
	.globl _FALSE
	.globl _TRUE
	.globl _select_slot_40
	.globl _select_ramslot_40
	.globl _flash_ident
	.globl _find_flash
	.globl _print_hex_buffer
	.globl _erase_flash
	.globl _flash_command_okay
	.globl _write_flash_segment
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_file_segment	=	0x8000
_flash_segment	=	0x4000
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
;src/flash.c:29: void FT_SetName( FCB *p_fcb, const char *p_name )  // Routine servant à vérifier le format du nom de fichier
;	---------------------------------
; Function FT_SetName
; ---------------------------------
_FT_SetName::
	call	___sdcc_enter_ix
	push	af
	push	af
	dec	sp
;src/flash.c:32: memset( p_fcb, 0, sizeof(FCB) );
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	ld	b, #0x25
00178$:
	ld	(hl), #0x00
	inc	hl
	djnz	00178$
;src/flash.c:33: for( i = 0; i < 11; i++ ) {
	ld	e, 4 (ix)
	ld	d, 5 (ix)
	ld	hl, #0x0001
	add	hl, de
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	c, #0x00
00106$:
;src/flash.c:34: p_fcb->name[i] = ' ';
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	b, #0x00
	add	hl, bc
	ld	(hl), #0x20
;src/flash.c:33: for( i = 0; i < 11; i++ ) {
	inc	c
	ld	a, c
	sub	a, #0x0b
	jr	C,00106$
;src/flash.c:36: for( i = 0; (i < 8) && (p_name[i] != 0) && (p_name[i] != '.'); i++ ) {
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
;src/flash.c:37: p_fcb->name[i] =  p_name[i];
	ld	a, -4 (ix)
	add	a, -2 (ix)
	ld	l, a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	h, a
	ld	(hl), c
;src/flash.c:36: for( i = 0; (i < 8) && (p_name[i] != 0) && (p_name[i] != '.'); i++ ) {
	ld	a, -1 (ix)
	ld	-2 (ix), a
	jr	00111$
00102$:
;src/flash.c:39: if( p_name[i] == '.' ) {
	ld	a, l
	or	a, a
	jr	Z,00118$
;src/flash.c:40: i++;
	ld	a, -1 (ix)
	ld	-5 (ix), a
;src/flash.c:41: for( j = 0; (j < 3) && (p_name[i + j] != 0) && (p_name[i + j] != '.'); j++ ) {
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
;src/flash.c:42: p_fcb->ext[j] =  p_name[i + j] ;
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	(hl), b
;src/flash.c:41: for( j = 0; (j < 3) && (p_name[i + j] != 0) && (p_name[i + j] != '.'); j++ ) {
	inc	c
	jr	00116$
00118$:
;src/flash.c:45: }
	ld	sp, ix
	pop	ix
	ret
_Done_Version_tag:
	.ascii "Made with FUSION-C 1.3 R21010 (c)EBSOFT:2021"
	.db 0x00
_TRUE:
	.db #0x01	; 1
_FALSE:
	.db #0x00	; 0
;src/flash.c:72: int main(char *argv[], int argc)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	call	___sdcc_enter_ix
	ld	hl, #-55
	add	hl, sp
	ld	sp, hl
;src/flash.c:74: uint8_t slot=0;
	ld	-18 (ix), #0x00
;src/flash.c:75: uint8_t argnr=0;
	ld	-1 (ix), #0x00
;src/flash.c:78: printf ("Based on the original code by S0urceror\r\n\r\n");
	ld	hl, #___str_28
	push	hl
	call	_puts
	pop	af
;src/flash.c:79: if (argc < 1)
	ld	a, 6 (ix)
	sub	a, #0x01
	ld	a, 7 (ix)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC,00102$
;src/flash.c:81: printf ("FLASH.COM [flags] [romfile]\r\n\r\nOptions:\r\n/S0 - skip detection and select slot 0\r\n/S1 - skip detection and select slot 1\r\n/S2 - skip detection and select slot 2\r\n/S3 - skip detection and select slot 3\r\n");
	ld	hl, #___str_8
	push	hl
	call	_puts
	pop	af
;src/flash.c:82: return (0);
	ld	hl, #0x0000
	jp	00129$
00102$:
;src/flash.c:84: if (ReadSP ()<(0x8000+SEGMENT_SIZE))
	call	_ReadSP
	ld	a, h
	sub	a, #0xa0
	jr	NC,00104$
;src/flash.c:86: printf ("Not enough memory to read file segment");
	ld	hl, #___str_9
	push	hl
	call	_printf
	pop	af
;src/flash.c:87: return (0);
	ld	hl, #0x0000
	jp	00129$
00104$:
;src/flash.c:89: if (strcmp (argv[0],"/S0")==0) {
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #___str_10
	push	hl
	push	de
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00106$
;src/flash.c:90: slot = 0;argnr++;
	ld	-18 (ix), #0x00
	ld	-1 (ix), #0x01
00106$:
;src/flash.c:92: if (strcmp (argv[0],"/S1")==0) {
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #___str_11
	push	hl
	push	de
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00108$
;src/flash.c:93: slot = 1;argnr++;
	ld	-18 (ix), #0x01
	inc	-1 (ix)
00108$:
;src/flash.c:95: if (strcmp (argv[0],"/S2")==0) {
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #___str_12
	push	hl
	push	de
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00110$
;src/flash.c:96: slot = 2;argnr++;
	ld	-18 (ix), #0x02
	inc	-1 (ix)
00110$:
;src/flash.c:98: if (strcmp (argv[0],"/S3")==0) {
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	bc
	ld	hl, #___str_13
	push	hl
	push	de
	call	_strcmp
	pop	af
	pop	af
	pop	bc
	ld	a, h
	or	a, l
	jr	NZ,00112$
;src/flash.c:99: slot = 3;argnr++;
	ld	-18 (ix), #0x03
	inc	-1 (ix)
00112$:
;src/flash.c:102: if (argnr==0)
	ld	a, -1 (ix)
	or	a, a
	jr	NZ,00116$
;src/flash.c:105: if (!((slot = find_flash())<4))
	push	bc
	call	_find_flash
	ld	a, l
	pop	bc
	ld	-18 (ix), a
	sub	a, #0x04
	jr	C,00116$
;src/flash.c:107: printf ("Cannot find slot with flash\r\n");
	ld	hl, #___str_15
	push	hl
	call	_puts
	pop	af
;src/flash.c:108: return (0);
	ld	hl, #0x0000
	jp	00129$
00116$:
;src/flash.c:111: printf ("Found flash in slot: %d\r\n",slot);
	ld	e, -18 (ix)
	ld	d, #0x00
	push	bc
	push	de
	ld	hl, #___str_16
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	bc
;src/flash.c:116: FT_SetName (&fcb,argv[argnr]);
	ld	l, -1 (ix)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, #0
	add	hl, sp
	ld	-17 (ix), l
	ld	-16 (ix), h
	push	bc
	push	de
	push	hl
	call	_FT_SetName
	pop	af
	pop	af
	pop	bc
;src/flash.c:117: if(fcb_open( &fcb ) != FCB_SUCCESS) 
	ld	e, -17 (ix)
	ld	d, -16 (ix)
	push	bc
	push	de
	call	_FcbOpen
	pop	af
	ld	a, l
	pop	bc
	or	a, a
	jr	Z,00118$
;src/flash.c:119: printf ("Error: opening file\r\n");
	ld	hl, #___str_18
	push	hl
	call	_puts
	pop	af
;src/flash.c:120: return (0);   
	ld	hl, #0x0000
	jp	00129$
00118$:
;src/flash.c:122: printf ("Opened: %s\r\n",argv[0]);
	ld	l, c
	ld	h, b
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	hl, #___str_19
	push	hl
	call	_printf
	pop	af
	pop	af
;src/flash.c:124: unsigned long romsize = fcb.file_size;
	ld	l, -17 (ix)
	ld	h, -16 (ix)
	ld	de, #0x0010
	add	hl, de
	ld	a, (hl)
	ld	-15 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-14 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-13 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-12 (ix), a
;src/flash.c:125: printf("Filesize is %ld bytes\r\n", romsize);
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	push	hl
	ld	l, -15 (ix)
	ld	h, -14 (ix)
	push	hl
	ld	hl, #___str_20
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	af
;src/flash.c:128: float endsector = romsize;
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	push	hl
	ld	l, -15 (ix)
	ld	h, -14 (ix)
	push	hl
	call	___ulong2fs
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;src/flash.c:129: endsector = endsector / 65536;
	ld	hl, #0x4780
	push	hl
	ld	hl, #0x0000
	push	hl
	push	de
	push	bc
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
;src/flash.c:130: endsector = ceilf (endsector);
	push	de
	push	hl
	call	_ceilf
	pop	af
	pop	af
;src/flash.c:131: if (!erase_flash (slot)) 
	ld	a, -18 (ix)
	push	af
	inc	sp
	call	_erase_flash
	inc	sp
	ld	a, l
	or	a, a
	jr	NZ,00120$
;src/flash.c:132: return (0); 
	ld	hl, #0x0000
	jp	00129$
00120$:
;src/flash.c:135: unsigned long total_bytes_written = 0;
	xor	a, a
	ld	-11 (ix), a
	ld	-10 (ix), a
	ld	-9 (ix), a
	ld	-8 (ix), a
;src/flash.c:140: while ( total_bytes_written < romsize) 
	ld	a, -17 (ix)
	ld	-7 (ix), a
	ld	a, -16 (ix)
	ld	-6 (ix), a
	ld	-1 (ix), #0x00
00126$:
	ld	a, -11 (ix)
	sub	a, -15 (ix)
	ld	a, -10 (ix)
	sbc	a, -14 (ix)
	ld	a, -9 (ix)
	sbc	a, -13 (ix)
	ld	a, -8 (ix)
	sbc	a, -12 (ix)
	jp	NC, 00128$
;src/flash.c:143: MemFill (file_segment,0xff,SEGMENT_SIZE);
	ld	hl, #0x2000
	push	hl
	ld	a, #0xff
	push	af
	inc	sp
	ld	hl, #_file_segment
	push	hl
	call	_MemFill
	pop	af
	pop	af
	inc	sp
;src/flash.c:144: bytes_read = fcb_read( &fcb, file_segment,SEGMENT_SIZE);
	ld	c, -7 (ix)
	ld	b, -6 (ix)
	ld	hl, #0x2000
	push	hl
	ld	hl, #_file_segment
	push	hl
	push	bc
	call	_FcbRead
	pop	af
	pop	af
	pop	af
;src/flash.c:148: if (bytes_read > 0) {
	xor	a, a
	cp	a, l
	sbc	a, h
	jp	PO, 00201$
	xor	a, #0x80
00201$:
	jp	P, 00124$
;src/flash.c:150: int progress = (int)((total_bytes_written + bytes_read) * 20 / romsize); // Scale to 20 chars
	ld	a, h
	rla
	sbc	a, a
	ld	c, a
	ld	b, a
	ld	a, l
	add	a, -11 (ix)
	ld	-5 (ix), a
	ld	a, h
	adc	a, -10 (ix)
	ld	-4 (ix), a
	ld	a, c
	adc	a, -9 (ix)
	ld	-3 (ix), a
	ld	a, b
	adc	a, -8 (ix)
	ld	-2 (ix), a
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	push	hl
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x0014
	push	hl
	call	__mullong
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c, l
	ld	b, h
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	push	hl
	ld	l, -15 (ix)
	ld	h, -14 (ix)
	push	hl
	push	de
	push	bc
	call	__divulong
	pop	af
	pop	af
	pop	af
	pop	af
	ex	de, hl
;src/flash.c:151: printf("[%-20s] %ld/%ld \r", "####################" + (20 - progress), total_bytes_written + bytes_read, romsize); // write 8k segment (or partial segment)
	ld	hl, #0x0014
	cp	a, a
	sbc	hl, de
	ld	de, #___str_22
	add	hl, de
	ld	c, l
	ld	b, h
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	push	hl
	ld	l, -15 (ix)
	ld	h, -14 (ix)
	push	hl
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	push	hl
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	push	bc
	ld	hl, #___str_21
	push	hl
	call	_printf
	ld	hl, #12
	add	hl, sp
	ld	sp, hl
;src/flash.c:154: if (!write_flash_segment(slot, segmentnr))
	ld	h, -1 (ix)
	ld	l, -18 (ix)
	push	hl
	call	_write_flash_segment
	pop	af
	ld	a, l
	or	a, a
	jr	Z,00128$
;src/flash.c:158: total_bytes_written += bytes_read;
	ld	c, -5 (ix)
	ld	b, -4 (ix)
	ld	e, -3 (ix)
	ld	d, -2 (ix)
	ld	-11 (ix), c
	ld	-10 (ix), b
	ld	-9 (ix), e
	ld	-8 (ix), d
;src/flash.c:159: segmentnr++;
	inc	-1 (ix)
	jp	00126$
00124$:
;src/flash.c:163: printf("Error reading file or end of file reached\r\n");
	ld	hl, #___str_24
	push	hl
	call	_puts
	pop	af
;src/flash.c:164: break;
00128$:
;src/flash.c:170: printf("\nWrite operation complete!\r\n");
	ld	hl, #___str_26
	push	hl
	call	_puts
	pop	af
;src/flash.c:171: fcb_close (&fcb);
	ld	c, -17 (ix)
	ld	b, -16 (ix)
	push	bc
	call	_FcbClose
	pop	af
;src/flash.c:172: return(0);
	ld	hl, #0x0000
00129$:
;src/flash.c:173: }
	ld	sp, ix
	pop	ix
	ret
___str_8:
	.ascii "FLASH.COM [flags] [romfile]"
	.db 0x0d
	.db 0x0a
	.db 0x0d
	.db 0x0a
	.ascii "Options:"
	.db 0x0d
	.db 0x0a
	.ascii "/S0 - skip detection and select slot 0"
	.db 0x0d
	.db 0x0a
	.ascii "/S1 - skip detection and select slot 1"
	.db 0x0d
	.db 0x0a
	.ascii "/S2 - skip detection and select slot 2"
	.db 0x0d
	.db 0x0a
	.ascii "/S3 - skip detection and select slot 3"
	.db 0x0d
	.db 0x00
___str_9:
	.ascii "Not enough memory to read file segment"
	.db 0x00
___str_10:
	.ascii "/S0"
	.db 0x00
___str_11:
	.ascii "/S1"
	.db 0x00
___str_12:
	.ascii "/S2"
	.db 0x00
___str_13:
	.ascii "/S3"
	.db 0x00
___str_15:
	.ascii "Cannot find slot with flash"
	.db 0x0d
	.db 0x00
___str_16:
	.ascii "Found flash in slot: %d"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_18:
	.ascii "Error: opening file"
	.db 0x0d
	.db 0x00
___str_19:
	.ascii "Opened: %s"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_20:
	.ascii "Filesize is %ld bytes"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_21:
	.ascii "[%-20s] %ld/%ld "
	.db 0x0d
	.db 0x00
___str_22:
	.ascii "####################"
	.db 0x00
___str_24:
	.ascii "Error reading file or end of file reached"
	.db 0x0d
	.db 0x00
___str_26:
	.db 0x0a
	.ascii "Write operation complete!"
	.db 0x0d
	.db 0x00
___str_28:
	.ascii "MSXUSB Flash Loader 1.1"
	.db 0x0d
	.db 0x0a
	.ascii "(c) 2024 The Retro Hacker"
	.db 0x0d
	.db 0x0a
	.ascii "Based on the original code by S0urceror"
	.db 0x0d
	.db 0x0a
	.db 0x0d
	.db 0x00
;src/flash.c:180: void select_slot_40 (uint8_t slot)
;	---------------------------------
; Function select_slot_40
; ---------------------------------
_select_slot_40::
;src/flash.c:190: __endasm;
	ld	iy,#2
	add	iy,sp ;Bypass the return address of the function
	ld	a,(iy) ;slot
	ld	h,#0x40
	jp	0x24 ; ENASLT
;src/flash.c:191: }
	ret
;src/flash.c:198: void select_ramslot_40 ()
;	---------------------------------
; Function select_ramslot_40
; ---------------------------------
_select_ramslot_40::
;src/flash.c:204: __endasm;
	ld	a,(#0xf342) ; RAMAD1
	ld	h,#0x40
	jp	0x24 ; ENASLT
;src/flash.c:205: }
	ret
;src/flash.c:212: BOOL flash_ident ()
;	---------------------------------
; Function flash_ident
; ---------------------------------
_flash_ident::
;src/flash.c:216: flash_segment[0] = 0xf0;
	ld	hl, #_flash_segment
	ld	(hl), #0xf0
;src/flash.c:218: dummy = flash_segment [0x555];
	ld	a, (#_flash_segment+1365)
;src/flash.c:219: flash_segment[0x555] = 0xaa;
	ld	hl, #(_flash_segment + 0x0555)
	ld	(hl), #0xaa
;src/flash.c:220: dummy = flash_segment [0x2aa];
	ld	a, (#_flash_segment+682)
;src/flash.c:221: flash_segment[0x2aa] = 0x55;
	ld	hl, #(_flash_segment + 0x02aa)
	ld	(hl), #0x55
;src/flash.c:222: dummy = flash_segment [0x555];
	ld	a, (#_flash_segment+1365)
;src/flash.c:223: flash_segment[0x555] = 0x90;
	ld	hl, #(_flash_segment + 0x0555)
	ld	(hl), #0x90
;src/flash.c:225: uint8_t manufacturer = flash_segment[0];
	ld	a, (#_flash_segment+0)
;src/flash.c:226: uint8_t device = flash_segment[1];
	ld	a, (#(_flash_segment + 0x0001) + 0)
;src/flash.c:234: switch (device) {
	cp	a, #0x20
	jr	Z,00102$
	sub	a, #0xa4
	jr	NZ,00103$
;src/flash.c:236: printf("Found device: AMD_AM29F040\r\n");
	ld	hl, #___str_30
	push	hl
	call	_puts
	pop	af
;src/flash.c:237: flash_segment[0] = 0xf0;
	ld	hl, #_flash_segment
	ld	(hl), #0xf0
;src/flash.c:238: return TRUE;
	ld	iy, #_TRUE
	ld	l, 0 (iy)
	ret
;src/flash.c:240: case 0x20:
00102$:
;src/flash.c:241: printf("Found device: AMD_AM29F010\r\n");
	ld	hl, #___str_32
	push	hl
	call	_puts
	pop	af
;src/flash.c:242: flash_segment[0] = 0xf0;
	ld	hl, #_flash_segment
	ld	(hl), #0xf0
;src/flash.c:243: return TRUE;
	ld	iy, #_TRUE
	ld	l, 0 (iy)
	ret
;src/flash.c:245: default:
00103$:
;src/flash.c:246: return FALSE;
	ld	iy, #_FALSE
	ld	l, 0 (iy)
;src/flash.c:247: }
;src/flash.c:249: }
	ret
___str_30:
	.ascii "Found device: AMD_AM29F040"
	.db 0x0d
	.db 0x00
___str_32:
	.ascii "Found device: AMD_AM29F010"
	.db 0x0d
	.db 0x00
;src/flash.c:256: uint8_t find_flash ()
;	---------------------------------
; Function find_flash
; ---------------------------------
_find_flash::
;src/flash.c:259: uint8_t highest_slot = 4;
;src/flash.c:260: for (i=0;i<4;i++)
	ld	hl, #0x0004
00104$:
;src/flash.c:263: select_slot_40 (i);
	push	hl
	push	hl
	inc	sp
	call	_select_slot_40
	inc	sp
	call	_flash_ident
	ld	a, l
	pop	hl
	or	a, a
	jr	Z,00105$
;src/flash.c:266: highest_slot=i; // yes? save slot number
	ld	l, h
00105$:
;src/flash.c:260: for (i=0;i<4;i++)
	inc	h
	ld	a, h
	sub	a, #0x04
	jr	C,00104$
;src/flash.c:268: select_ramslot_40 ();
	push	hl
	call	_select_ramslot_40
	pop	hl
;src/flash.c:269: return highest_slot;
;src/flash.c:270: }
	ret
;src/flash.c:277: void print_hex_buffer (uint8_t* start, uint8_t* end)
;	---------------------------------
; Function print_hex_buffer
; ---------------------------------
_print_hex_buffer::
	call	___sdcc_enter_ix
	ld	hl, #-14
	add	hl, sp
	ld	sp, hl
;src/flash.c:280: uint8_t* cur = start;
	ld	c, 4 (ix)
	ld	b, 5 (ix)
;src/flash.c:282: while (cur<end)
	ld	hl, #0
	add	hl, sp
	ex	de, hl
	ld	-7 (ix), e
	ld	-6 (ix), d
	ld	-5 (ix), e
	ld	-4 (ix), d
	ld	-1 (ix), #0x00
00106$:
	ld	a, c
	sub	a, 6 (ix)
	ld	a, b
	sbc	a, 7 (ix)
	jp	NC, 00109$
;src/flash.c:284: char hex[]="0\0\0";
	ld	hl, #3
	add	hl, sp
	ld	-3 (ix), l
	ld	-2 (ix), h
	ld	(hl), #0x30
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	inc	hl
	ld	(hl), #0x00
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	inc	hl
	inc	hl
	ld	(hl), #0x00
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src/flash.c:285: uint8_t len = sprintf (str,"%x",*cur);
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	push	de
	pop	iy
	push	bc
	push	de
	push	hl
	ld	hl, #___str_34
	push	hl
	push	iy
	call	_sprintf
	pop	af
	pop	af
	pop	af
	pop	de
	pop	bc
	ld	a, l
;src/flash.c:286: if (len<2)
	sub	a, #0x02
	jr	NC,00102$
;src/flash.c:288: strcat (hex,str);
	ld	l, -5 (ix)
	ld	h, -4 (ix)
	push	hl
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	push	hl
	pop	iy
	pop	hl
	push	bc
	push	de
	push	hl
	push	iy
	call	_strcat
	pop	af
	pop	af
	pop	de
	pop	bc
;src/flash.c:289: printf (hex);
	ld	l, -3 (ix)
	ld	h, -2 (ix)
	push	bc
	push	de
	push	hl
	call	_printf
	pop	af
	pop	de
	pop	bc
	jr	00103$
00102$:
;src/flash.c:292: printf (str);
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	push	bc
	push	de
	push	hl
	call	_printf
	pop	af
	pop	de
	pop	bc
00103$:
;src/flash.c:294: cur++;
	inc	bc
;src/flash.c:295: cnt++;
	inc	-1 (ix)
;src/flash.c:296: if ((cnt%8)==0)
	ld	a, -1 (ix)
	and	a, #0x07
	jp	NZ,00106$
;src/flash.c:297: printf ("\r\n");
	push	bc
	push	de
	ld	hl, #___str_36
	push	hl
	call	_puts
	pop	af
	pop	de
	pop	bc
	jp	00106$
00109$:
;src/flash.c:299: }
	ld	sp, ix
	pop	ix
	ret
___str_34:
	.ascii "%x"
	.db 0x00
___str_36:
	.db 0x0d
	.db 0x00
;src/flash.c:310: BOOL erase_flash(uint8_t slot)
;	---------------------------------
; Function erase_flash
; ---------------------------------
_erase_flash::
;src/flash.c:313: select_slot_40 (slot);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_select_slot_40
	inc	sp
;src/flash.c:315: printf ("Erasing flash: ");
	ld	hl, #___str_37
	push	hl
	call	_printf
	pop	af
;src/flash.c:317: flash_segment[0x555] = 0xaa;
	ld	hl, #(_flash_segment + 0x0555)
	ld	(hl), #0xaa
;src/flash.c:318: flash_segment[0x2aa] = 0x55;
	ld	hl, #(_flash_segment + 0x02aa)
	ld	(hl), #0x55
;src/flash.c:319: flash_segment[0x555] = 0x80;
	ld	hl, #(_flash_segment + 0x0555)
	ld	(hl), #0x80
;src/flash.c:320: flash_segment[0x555] = 0xaa;
	ld	(hl), #0xaa
;src/flash.c:321: flash_segment[0x2aa] = 0x55;
	ld	hl, #(_flash_segment + 0x02aa)
	ld	(hl), #0x55
;src/flash.c:322: flash_segment[0x555] = 0x10;
	ld	hl, #(_flash_segment + 0x0555)
	ld	(hl), #0x10
;src/flash.c:324: if (!flash_command_okay (0,0xff))
	ld	a, #0xff
	push	af
	inc	sp
	ld	hl, #0x0000
	push	hl
	call	_flash_command_okay
	pop	af
	inc	sp
	ld	a, l
	or	a, a
	jr	NZ,00102$
;src/flash.c:327: flash_segment[0] = 0xf0;
	ld	hl, #_flash_segment
	ld	(hl), #0xf0
;src/flash.c:328: printf ("error erasing flash!\r\n");
	ld	hl, #___str_39
	push	hl
	call	_puts
	pop	af
;src/flash.c:329: return FALSE;
	ld	iy, #_FALSE
	ld	l, 0 (iy)
	ret
00102$:
;src/flash.c:332: printf ("done!\r\n");
	ld	hl, #___str_41
	push	hl
	call	_puts
	pop	af
;src/flash.c:333: return TRUE;
	ld	iy, #_TRUE
	ld	l, 0 (iy)
;src/flash.c:334: }
	ret
___str_37:
	.ascii "Erasing flash: "
	.db 0x00
___str_39:
	.ascii "error erasing flash!"
	.db 0x0d
	.db 0x00
___str_41:
	.ascii "done!"
	.db 0x0d
	.db 0x00
;src/flash.c:337: BOOL flash_command_okay (uint16_t address,uint8_t expected_value)
;	---------------------------------
; Function flash_command_okay
; ---------------------------------
_flash_command_okay::
	call	___sdcc_enter_ix
;src/flash.c:340: while (TRUE)
00105$:
	ld	hl,#_TRUE + 0
	ld	c, (hl)
	ld	a, c
	or	a, a
	jr	Z,00107$
;src/flash.c:342: value = flash_segment[address];
	ld	de, #_flash_segment+0
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, de
	ld	b, (hl)
;src/flash.c:343: if (value==expected_value)
	ld	a, 6 (ix)
	sub	a, b
	jr	NZ,00102$
;src/flash.c:344: return TRUE;
	ld	l, c
	jr	00111$
00102$:
;src/flash.c:345: if ((value & 0x20) != 0)
	bit	5, b
	jr	Z,00105$
;src/flash.c:346: break;
00107$:
;src/flash.c:348: value = flash_segment[address];
	ld	de, #_flash_segment+0
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	add	hl, de
	ld	e, (hl)
;src/flash.c:349: if (value==expected_value)
	ld	a, 6 (ix)
	sub	a, e
	jr	NZ,00109$
;src/flash.c:350: return TRUE;
	ld	l, c
	jr	00111$
00109$:
;src/flash.c:353: printf ("=> address: %x, value: %x, response: %x\r\n",address,expected_value,value);
	ld	d, #0x00
	ld	c, 6 (ix)
	ld	b, #0x00
	push	de
	push	bc
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	push	hl
	ld	hl, #___str_42
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	af
	pop	af
;src/flash.c:354: return FALSE;
	ld	iy, #_FALSE
	ld	l, 0 (iy)
00111$:
;src/flash.c:356: }
	pop	ix
	ret
___str_42:
	.ascii "=> address: %x, value: %x, response: %x"
	.db 0x0d
	.db 0x0a
	.db 0x00
;src/flash.c:358: BOOL write_flash_segment (uint8_t slot,uint8_t segment)
;	---------------------------------
; Function write_flash_segment
; ---------------------------------
_write_flash_segment::
	call	___sdcc_enter_ix
	push	af
	push	af
;src/flash.c:361: select_slot_40 (slot);
	ld	a, 4 (ix)
	push	af
	inc	sp
	call	_select_slot_40
	inc	sp
;src/flash.c:363: flash_segment[0x1000] = segment;
	ld	hl, #(_flash_segment + 0x1000)
	ld	a, 5 (ix)
	ld	(hl), a
;src/flash.c:368: for (i=0;i<(8*1024);i++)
	ld	hl, #0x0000
	ex	(sp), hl
	ld	-2 (ix), #0x00
	ld	-1 (ix), #0x00
00109$:
;src/flash.c:371: flash_segment[0x555] = 0xaa;
	ld	hl, #(_flash_segment + 0x0555)
	ld	(hl), #0xaa
;src/flash.c:372: flash_segment[0x2aa] = 0x55;
	ld	hl, #(_flash_segment + 0x02aa)
	ld	(hl), #0x55
;src/flash.c:373: flash_segment[0x555] = 0xa0;
	ld	hl, #(_flash_segment + 0x0555)
	ld	(hl), #0xa0
;src/flash.c:374: flash_segment[i] = file_segment[i];
	ld	a, -2 (ix)
	add	a, #<(_flash_segment)
	ld	c, a
	ld	a, -1 (ix)
	adc	a, #>(_flash_segment)
	ld	b, a
	ld	de, #_file_segment+0
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	add	hl, de
	ld	a, (hl)
	ld	(bc), a
;src/flash.c:376: if (i>=0x1000) // addresses 0x5000 to 0x5fff
	ld	a, -1 (ix)
	xor	a, #0x80
	sub	a, #0x90
	jr	C,00102$
;src/flash.c:377: flash_segment[0x1000] = segment; // necessary to switch back
	ld	hl, #(_flash_segment + 0x1000)
	ld	a, 5 (ix)
	ld	(hl), a
00102$:
;src/flash.c:378: if (!flash_command_okay (i,file_segment[i]))
	ld	bc, #_file_segment+0
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	add	hl, bc
	ld	a, (hl)
	push	af
	inc	sp
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	push	hl
	call	_flash_command_okay
	pop	af
	inc	sp
	ld	a, l
	or	a, a
	jr	NZ,00110$
;src/flash.c:380: printf ("Error writing byte: %x in segment: %d\r\n",i,segment);
	ld	c, 5 (ix)
	ld	b, #0x00
	push	bc
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ld	hl, #___str_43
	push	hl
	call	_printf
	pop	af
	pop	af
	pop	af
;src/flash.c:381: break;   
	jr	00105$
00110$:
;src/flash.c:368: for (i=0;i<(8*1024);i++)
	inc	-2 (ix)
	jr	NZ,00133$
	inc	-1 (ix)
00133$:
	ld	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, -1 (ix)
	ld	-3 (ix), a
	ld	a, -1 (ix)
	xor	a, #0x80
	sub	a, #0xa0
	jp	C, 00109$
00105$:
;src/flash.c:388: select_ramslot_40 ();
	call	_select_ramslot_40
;src/flash.c:390: if (i<(8*1024))
	ld	a, -3 (ix)
	xor	a, #0x80
	sub	a, #0xa0
	jr	NC,00107$
;src/flash.c:391: return FALSE;
	ld	iy, #_FALSE
	ld	l, 0 (iy)
	jr	00111$
00107$:
;src/flash.c:393: return TRUE;
	ld	iy, #_TRUE
	ld	l, 0 (iy)
00111$:
;src/flash.c:394: }
	ld	sp, ix
	pop	ix
	ret
___str_43:
	.ascii "Error writing byte: %x in segment: %d"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
