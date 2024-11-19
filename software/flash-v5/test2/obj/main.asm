;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _writeBlock
	.globl _verifySwId
	.globl _eraseFlash
	.globl _detectInterface
	.globl _putSegFrame1
	.globl _getCurSegFrame1
	.globl _allocUserSegment
	.globl _numMapperPages
	.globl _mpInit
	.globl _getDeviceInfo
	.globl _dos1GetFilesize
	.globl _lseek
	.globl _read
	.globl _close
	.globl _open
	.globl _msxdos_init
	.globl _resetSystem
	.globl _clearKeyBuf
	.globl _memcmp
	.globl _putdec8
	.globl _puthex8
	.globl _puts
	.globl _getchar
	.globl _putchar
	.globl _HTIMI
	.globl _DSKSLT
	.globl _EXPTBL
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_devInfo:
	.ds 54
_numMprPages:
	.ds 1
_mprSegments:
	.ds 8
_curSegm:
	.ds 1
_hooks:
	.ds 1
_pfi:
	.ds 1
_askslot:
	.ds 1
_onlyErase:
	.ds 1
_resetAtEnd:
	.ds 1
_buffer:
	.ds 64
_pause:
	.ds 1
_c:
	.ds 1
_t1:
	.ds 1
_t2:
	.ds 1
_slot:
	.ds 1
_swId:
	.ds 1
_isMain:
	.ds 1
_isSlave:
	.ds 1
_fhandle:
	.ds 2
_i:
	.ds 2
_r:
	.ds 2
_fileSize:
	.ds 4
_seekpos:
	.ds 4
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_EXPTBL::
	.ds 2
_DSKSLT::
	.ds 2
_HTIMI::
	.ds 2
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
;src\main.c:49: static void restoreHooks()
;	---------------------------------
; Function restoreHooks
; ---------------------------------
_restoreHooks:
;src\main.c:52: *HTIMI = hooks[0];
	ld	bc, (_HTIMI)
	ld	a, (#_hooks + 0)
	ld	(bc), a
;src\main.c:54: }
	ret
;src\main.c:57: int main(char** argv, int argc)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	push	af
	push	af
;src\main.c:59: puts(title1);
	ld	hl, (_title1)
	push	hl
	call	_puts
	pop	af
;src\main.c:60: puts(title2);
	ld	hl, (_title2)
	push	hl
	call	_puts
	pop	af
;src\main.c:62: if (argc < 1) {
	ld	iy, #8
	add	iy, sp
	ld	a, 0 (iy)
	sub	a, #0x01
	ld	a, 1 (iy)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC,00103$
;src\main.c:63: showUsage:
00101$:
;src\main.c:64: puts(usage1);
	ld	hl, (_usage1)
	push	hl
	call	_puts
	pop	af
;src\main.c:65: puts(usage2);
	ld	hl, (_usage2)
	push	hl
	call	_puts
	pop	af
;src\main.c:66: puts(usage3);
	ld	hl, (_usage3)
	push	hl
	call	_puts
	pop	af
;src\main.c:67: return 1;
	ld	hl, #0x0001
	jp	00239$
00103$:
;src\main.c:69: pfi = 0;
	ld	hl,#_pfi + 0
	ld	(hl), #0x00
;src\main.c:70: onlyErase = 0;
	ld	hl,#_onlyErase + 0
	ld	(hl), #0x00
;src\main.c:71: askslot = 0;
	ld	hl,#_askslot + 0
	ld	(hl), #0x00
;src\main.c:72: pause = 0;
	ld	hl,#_pause + 0
	ld	(hl), #0x00
;src\main.c:73: for (i = 0; i < argc; i++) {
	ld	hl, #0x0000
	ld	(_i), hl
00229$:
	ld	hl, #8
	add	hl, sp
	ld	iy, #_i
	ld	a, 0 (iy)
	sub	a, (hl)
	ld	a, 1 (iy)
	inc	hl
	sbc	a, (hl)
	jp	PO, 00521$
	xor	a, #0x80
00521$:
	jp	P, 00122$
;src\main.c:74: if (argv[i][0] == '/') {
	ld	bc, (_i)
	sla	c
	rl	b
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	sub	a, #0x2f
	jr	NZ,00230$
;src\main.c:75: if (argv[i][1] == 'h' || argv[i][1] == 'H') {
	inc	hl
	ld	a, (hl)
	cp	a, #0x68
	jr	Z,00116$
	cp	a, #0x48
	jr	NZ,00117$
00116$:
;src\main.c:76: puts(usage1);
	ld	hl, (_usage1)
	push	hl
	call	_puts
	pop	af
;src\main.c:77: puts(usage2);
	ld	hl, (_usage2)
	push	hl
	call	_puts
	pop	af
;src\main.c:78: puts(usage3);
	ld	hl, (_usage3)
	push	hl
	call	_puts
	pop	af
;src\main.c:79: return 0;
	ld	hl, #0x0000
	jp	00239$
00117$:
;src\main.c:82: ++pfi;
	ld	hl,#_pfi + 0
	ld	c, (hl)
	inc	c
;src\main.c:80: } else if (argv[i][1] == 'e' || argv[i][1] == 'E') {
	cp	a, #0x65
	jr	Z,00112$
	cp	a, #0x45
	jr	NZ,00113$
00112$:
;src\main.c:81: onlyErase = 1;
	ld	hl,#_onlyErase + 0
	ld	(hl), #0x01
;src\main.c:82: ++pfi;
	ld	hl,#_pfi + 0
	ld	(hl), c
	jr	00230$
00113$:
;src\main.c:83: } else if (argv[i][1] == 's' || argv[i][1] == 'S') {
	cp	a, #0x73
	jr	Z,00108$
	cp	a, #0x53
	jr	NZ,00109$
00108$:
;src\main.c:84: askslot = 1;
	ld	hl,#_askslot + 0
	ld	(hl), #0x01
;src\main.c:85: ++pfi;
	ld	hl,#_pfi + 0
	ld	(hl), c
	jr	00230$
00109$:
;src\main.c:86: } else if (argv[i][1] == 'p' || argv[i][1] == 'P') {
	cp	a, #0x70
	jr	Z,00104$
	sub	a, #0x50
	jp	NZ,00101$
00104$:
;src\main.c:87: pause = 1;
	ld	hl,#_pause + 0
	ld	(hl), #0x01
;src\main.c:88: ++pfi;
	ld	hl,#_pfi + 0
	ld	(hl), c
;src\main.c:90: goto showUsage;
00230$:
;src\main.c:73: for (i = 0; i < argc; i++) {
	ld	iy, #_i
	inc	0 (iy)
	jp	NZ,00229$
	inc	1 (iy)
	jp	00229$
00122$:
;src\main.c:94: if (pfi == argc && onlyErase == 0) {
	ld	hl,#_pfi + 0
	ld	c, (hl)
	ld	b, #0x00
	ld	iy, #8
	add	iy, sp
	ld	a, 0 (iy)
	sub	a, c
	jr	NZ,00124$
	ld	a, 1 (iy)
	sub	a, b
	jr	NZ,00124$
	ld	a,(#_onlyErase + 0)
	or	a, a
	jp	Z, 00101$
;src\main.c:95: goto showUsage;
00124$:
;src\main.c:99: hooks[0] = *HTIMI;
	ld	bc, #_hooks+0
	ld	hl, (_HTIMI)
	ld	a, (hl)
	ld	(bc), a
;src\main.c:102: *HTIMI = 0xC9;
	ld	hl, (_HTIMI)
	ld	(hl), #0xc9
;src\main.c:105: if (askslot == 1) {
	ld	a,(#_askslot + 0)
	dec	a
	jp	NZ,00157$
;src\main.c:106: puts(whatslot);
	ld	hl, (_whatslot)
	push	hl
	call	_puts
	pop	af
;src\main.c:107: while(1) {
00130$:
;src\main.c:108: c = getchar();
	call	_getchar
	ld	iy, #_c
	ld	0 (iy), l
;src\main.c:109: if (c >= '0' && c <= '3') {
	ld	a, 0 (iy)
	sub	a, #0x30
	jr	C,00130$
	ld	a, #0x33
	sub	a, 0 (iy)
	jr	C,00130$
;src\main.c:113: putchar(c);
	ld	a, (_c)
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:114: puts(crlf);
	ld	hl, (_crlf)
	push	hl
	call	_puts
	pop	af
;src\main.c:115: slot = c - '0';
	ld	a,(#_c + 0)
	ld	hl, #_slot
	add	a, #0xd0
	ld	(hl), a
;src\main.c:116: if ((*(EXPTBL+slot) & 0x80) == 0x80) {
	ld	iy, (_EXPTBL)
	ld	de, (_slot)
	ld	d, #0x00
	add	iy, de
	ld	a, 0 (iy)
	and	a, #0x80
	ld	c, a
	ld	b, #0x00
	ld	a, c
	sub	a, #0x80
	or	a, b
	jr	NZ,00139$
;src\main.c:117: puts(whatsubslot);
	ld	hl, (_whatsubslot)
	push	hl
	call	_puts
	pop	af
;src\main.c:118: while(1) {
00136$:
;src\main.c:119: c = getchar();
	call	_getchar
	ld	iy, #_c
	ld	0 (iy), l
;src\main.c:120: if (c >= '0' && c <= '3') {
	ld	a, 0 (iy)
	sub	a, #0x30
	jr	C,00136$
	ld	a, #0x33
	sub	a, 0 (iy)
	jr	C,00136$
;src\main.c:124: putchar(c);
	ld	a, (_c)
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:125: puts(crlf);
	ld	hl, (_crlf)
	push	hl
	call	_puts
	pop	af
;src\main.c:126: c -= '0';
	ld	iy, #_c
	ld	a, 0 (iy)
	ld	hl, #_c
	add	a, #0xd0
	ld	(hl), a
;src\main.c:127: slot |= 0x80 | (c << 2);
	ld	a, 0 (iy)
	add	a, a
	add	a, a
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	set	7, c
	ld	iy, #_slot
	ld	e, 0 (iy)
	ld	d, #0x00
	ld	a, c
	or	a, e
	ld	c, a
	ld	a, b
	or	a, d
	ld	0 (iy), c
00139$:
;src\main.c:129: if (detectInterface(slot) == 0) {
	ld	a, (_slot)
	push	af
	inc	sp
	call	_detectInterface
	inc	sp
	ld	a, l
	or	a, a
	jr	NZ,00141$
;src\main.c:130: slot = 0xFF;
	ld	hl,#_slot + 0
	ld	(hl), #0xff
00141$:
;src\main.c:132: puts(crlf);
	ld	hl, (_crlf)
	push	hl
	call	_puts
	pop	af
	jp	00158$
00157$:
;src\main.c:135: puts(searching);
	ld	hl, (_searching)
	push	hl
	call	_puts
	pop	af
;src\main.c:136: slot = (*EXPTBL) & 0x80;
	ld	hl, (_EXPTBL)
	ld	a, (hl)
	and	a, #0x80
	ld	(#_slot + 0),a
;src\main.c:137: while (1) {
00154$:
;src\main.c:138: if (slot == 0x8F || slot == 0x03) {
	ld	iy, #_slot
	ld	a, 0 (iy)
	sub	a, #0x8f
	jr	Z,00142$
	ld	a, 0 (iy)
	sub	a, #0x03
	jr	NZ,00143$
00142$:
;src\main.c:139: slot = 0xFF;
	ld	hl,#_slot + 0
	ld	(hl), #0xff
;src\main.c:140: break;
	jp	00158$
00143$:
;src\main.c:142: if (detectInterface(slot) == 1) {
	ld	a, (_slot)
	push	af
	inc	sp
	call	_detectInterface
	inc	sp
	dec	l
	jr	NZ,00148$
;src\main.c:143: puts(found3);
	ld	hl, (_found3)
	push	hl
	call	_puts
	pop	af
;src\main.c:144: putdec8(slot & 0x03);
	ld	a,(#_slot + 0)
	and	a, #0x03
	push	af
	inc	sp
	call	_putdec8
	inc	sp
;src\main.c:145: if ((slot & 0x80) == 0x80) {
	ld	a,(#_slot + 0)
	and	a, #0x80
	ld	c, a
	ld	b, #0x00
	ld	a, c
	sub	a, #0x80
	or	a, b
	jr	NZ,00146$
;src\main.c:146: putchar('.');
	ld	a, #0x2e
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:147: putdec8((slot & 0x0C) >> 2);
	ld	a,(#_slot + 0)
	and	a, #0x0c
	ld	c, a
	ld	b, #0x00
	sra	b
	rr	c
	sra	b
	rr	c
	ld	b, c
	push	bc
	inc	sp
	call	_putdec8
	inc	sp
00146$:
;src\main.c:149: puts(crlf);
	ld	hl, (_crlf)
	push	hl
	call	_puts
	pop	af
;src\main.c:150: break;
	jr	00158$
00148$:
;src\main.c:153: if (slot & 0x80) {
	ld	a,(#_slot + 0)
	rlca
	jr	NC,00152$
;src\main.c:154: if ((slot & 0x0C) != 0x0C) {
	ld	iy, #_slot
	ld	a, 0 (iy)
	and	a, #0x0c
	ld	c, a
	ld	b, #0x00
	ld	a, c
	sub	a, #0x0c
	or	a, b
	jr	Z,00152$
;src\main.c:155: slot += 0x04;
	ld	a, 0 (iy)
	add	a, #0x04
	ld	0 (iy), a
;src\main.c:156: continue;
	jp	00154$
00152$:
;src\main.c:159: slot = (slot & 0x03) + 1;
	ld	iy, #_slot
	ld	a, 0 (iy)
	and	a, #0x03
	inc	a
	ld	0 (iy), a
;src\main.c:160: slot |= (*(EXPTBL+slot)) & 0x80;
	ld	iy, (_EXPTBL)
	ld	de, (_slot)
	ld	d, #0x00
	add	iy, de
	ld	a, 0 (iy)
	and	a, #0x80
	ld	c, a
	ld	b, #0x00
	ld	iy, #_slot
	ld	e, 0 (iy)
	ld	d, #0x00
	ld	a, c
	or	a, e
	ld	c, a
	ld	a, b
	or	a, d
	ld	0 (iy), c
	jp	00154$
00158$:
;src\main.c:164: if (slot == 0xFF) {
	ld	a,(#_slot + 0)
	inc	a
	jr	NZ,00160$
;src\main.c:165: restoreHooks();
	call	_restoreHooks
;src\main.c:166: puts(notfound);
	ld	hl, (_notfound)
	push	hl
	call	_puts
	pop	af
;src\main.c:167: return 4;
	ld	hl, #0x0004
	jp	00239$
00160$:
;src\main.c:171: msxdos_init();
	call	_msxdos_init
;src\main.c:174: if (dosversion < 2 || *DSKSLT == slot) {
	ld	a,(#_dosversion + 0)
	sub	a, #0x02
	jr	C,00161$
	ld	hl, (_DSKSLT)
	ld	c, (hl)
	ld	a,(#_slot + 0)
	sub	a, c
	jr	NZ,00162$
00161$:
;src\main.c:175: isMain = 1;
	ld	hl,#_isMain + 0
	ld	(hl), #0x01
	jr	00163$
00162$:
;src\main.c:177: isMain = 0;
	ld	hl,#_isMain + 0
	ld	(hl), #0x00
00163$:
;src\main.c:180: isSlave = 0;
	ld	hl,#_isSlave + 0
	ld	(hl), #0x00
;src\main.c:181: if (dosversion == 0x82) {			// Is Nextor, check devices
	ld	a,(#_dosversion + 0)
	sub	a, #0x82
	jr	NZ,00171$
;src\main.c:182: for (c = 0; c < 16; c++) {
	ld	hl,#_c + 0
	ld	(hl), #0x00
00231$:
;src\main.c:183: if (0 == getDeviceInfo(c, &devInfo)) {
	ld	hl, #_devInfo
	push	hl
	ld	a, (_c)
	push	af
	inc	sp
	call	_getDeviceInfo
	pop	af
	inc	sp
	ld	a, l
	or	a, a
	jr	NZ,00232$
;src\main.c:184: if (devInfo.slotNum == slot) {
	ld	hl, #_devInfo + 0
	ld	c, (hl)
	ld	a,(#_slot + 0)
	sub	a, c
	jr	NZ,00232$
;src\main.c:185: isSlave = 1;
	ld	hl,#_isSlave + 0
	ld	(hl), #0x01
00232$:
;src\main.c:182: for (c = 0; c < 16; c++) {
	ld	iy, #_c
	inc	0 (iy)
	ld	a, 0 (iy)
	sub	a, #0x10
	jr	C,00231$
	jr	00172$
00171$:
;src\main.c:190: isSlave = 1;					// Forces a reset
	ld	hl,#_isSlave + 0
	ld	(hl), #0x01
00172$:
;src\main.c:193: if (onlyErase == 1) {
	ld	a,(#_onlyErase + 0)
	dec	a
	jp	NZ,00181$
;src\main.c:194: if (isMain == 1 || isSlave == 1) {
	ld	a,(#_isMain + 0)
	dec	a
	jr	Z,00176$
	ld	a,(#_isSlave + 0)
	dec	a
	jr	NZ,00177$
00176$:
;src\main.c:195: puts(confirmReset0);
	ld	hl, (_confirmReset0)
	push	hl
	call	_puts
	pop	af
;src\main.c:196: puts(confirmReset1);
	ld	hl, (_confirmReset1)
	push	hl
	call	_puts
	pop	af
;src\main.c:197: puts(confirmReset3);
	ld	hl, (_confirmReset3)
	push	hl
	call	_puts
	pop	af
;src\main.c:198: clearKeyBuf();
	call	_clearKeyBuf
;src\main.c:199: c = getchar();
	call	_getchar
	ld	iy, #_c
	ld	0 (iy), l
;src\main.c:200: putchar(c);
	ld	a, (_c)
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:201: puts(crlf);
	ld	hl, (_crlf)
	push	hl
	call	_puts
	pop	af
;src\main.c:202: if (c == 'y' || c == 'Y') {
	ld	iy, #_c
	ld	a, 0 (iy)
	sub	a, #0x79
	jr	Z,00173$
	ld	a, 0 (iy)
	sub	a, #0x59
	jr	NZ,00174$
00173$:
;src\main.c:203: __asm__("di");
	di
;src\main.c:204: eraseFlash(slot);
	ld	a, (_slot)
	push	af
	inc	sp
	call	_eraseFlash
	inc	sp
;src\main.c:205: resetSystem();
	call	_resetSystem
00174$:
;src\main.c:207: restoreHooks();
	call	_restoreHooks
;src\main.c:208: return 0;
	ld	hl, #0x0000
	jp	00239$
00177$:
;src\main.c:210: eraseFlash(slot);
	ld	a, (_slot)
	push	af
	inc	sp
	call	_eraseFlash
	inc	sp
;src\main.c:211: restoreHooks();
	call	_restoreHooks
;src\main.c:212: return 0;
	ld	hl, #0x0000
	jp	00239$
00181$:
;src\main.c:216: c = mpInit();
	call	_mpInit
	ld	iy, #_c
	ld	0 (iy), l
;src\main.c:217: if (c != 0) {
	ld	a, 0 (iy)
	or	a, a
	jr	Z,00183$
;src\main.c:218: puts(errorNoExtBios);
	ld	hl, (_errorNoExtBios)
	push	hl
	call	_puts
	pop	af
;src\main.c:219: numMprPages = numMapperPages();
	call	_numMapperPages
	ld	iy, #_numMprPages
	ld	0 (iy), l
	jr	00184$
00183$:
;src\main.c:221: numMprPages = mpVars->numFree;
	ld	hl, (_mpVars)
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(#_numMprPages + 0),a
00184$:
;src\main.c:223: if (numMprPages < 8) {
	ld	a,(#_numMprPages + 0)
	sub	a, #0x08
	jr	NC,00186$
;src\main.c:224: puts(noMemAvailable);
	ld	hl, (_noMemAvailable)
	push	hl
	call	_puts
	pop	af
;src\main.c:225: restoreHooks();
	call	_restoreHooks
;src\main.c:226: return 3;
	ld	hl, #0x0003
	jp	00239$
00186$:
;src\main.c:229: curSegm = getCurSegFrame1();
	call	_getCurSegFrame1
	ld	iy, #_curSegm
	ld	0 (iy), l
;src\main.c:232: fhandle = open(argv[pfi], O_RDONLY);
	ld	iy, #_pfi
	ld	l, 0 (iy)
	ld	h, #0x00
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, #0x01
	push	af
	inc	sp
	push	bc
	call	_open
	pop	af
	inc	sp
	ld	a, l
	ld	iy, #_fhandle
	ld	0 (iy), a
	rla
	sbc	a, a
	ld	1 (iy), a
;src\main.c:233: if (fhandle == -1) {
	ld	a, 0 (iy)
	inc	a
	jr	NZ,00188$
	ld	a, 1 (iy)
	inc	a
	jr	NZ,00188$
;src\main.c:234: puts(openingError);
	ld	hl, (_openingError)
	push	hl
	call	_puts
	pop	af
;src\main.c:235: restoreHooks();
	call	_restoreHooks
;src\main.c:236: return 4;
	ld	hl, #0x0004
	jp	00239$
00188$:
;src\main.c:239: if (dosversion < 2) {
	ld	a,(#_dosversion + 0)
	sub	a, #0x02
	jr	NC,00190$
;src\main.c:240: fileSize = dos1GetFilesize();
	call	_dos1GetFilesize
	ld	iy, #0
	add	iy, sp
	ld	3 (iy), d
	ld	2 (iy), e
	ld	1 (iy), h
	ld	0 (iy), l
	ld	de, #_fileSize
	ld	hl, #0
	add	hl, sp
	ld	bc, #4
	ldir
	jr	00191$
00190$:
;src\main.c:242: fileSize = lseek(fhandle, 0, SEEK_END);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	ld	a, #0x02
	push	af
	inc	sp
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x0000
	push	hl
	push	bc
	inc	sp
	call	_lseek
	pop	af
	pop	af
	pop	af
	ld	iy, #0
	add	iy, sp
	ld	3 (iy), d
	ld	2 (iy), e
	ld	1 (iy), h
	ld	0 (iy), l
	ld	de, #_fileSize
	ld	hl, #0
	add	hl, sp
	ld	bc, #4
	ldir
00191$:
;src\main.c:244: if (fileSize != 131072) {
	ld	iy, #_fileSize
	ld	a, 0 (iy)
	or	a, a
	or	a, 1 (iy)
	jr	NZ,00572$
	ld	a, 2 (iy)
	sub	a, #0x02
	or	a, 3 (iy)
	jr	Z,00193$
00572$:
;src\main.c:245: puts(filesizeError);
	ld	hl, (_filesizeError)
	push	hl
	call	_puts
	pop	af
;src\main.c:246: restoreHooks();
	call	_restoreHooks
;src\main.c:247: return 5;
	ld	hl, #0x0005
	jp	00239$
00193$:
;src\main.c:250: if (dosversion > 1) {
	ld	a, #0x01
	ld	iy, #_dosversion
	sub	a, 0 (iy)
	jp	NC, 00203$
;src\main.c:251: lseek(fhandle, 0x1C100, SEEK_SET);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	xor	a, a
	push	af
	inc	sp
	ld	hl, #0x0001
	push	hl
	ld	hl, #0xc100
	push	hl
	push	bc
	inc	sp
	call	_lseek
	pop	af
	pop	af
	pop	af
;src\main.c:252: r = read(fhandle, buffer, 32);
	ld	de, #_buffer
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	ld	hl, #0x0020
	push	hl
	push	de
	push	bc
	inc	sp
	call	_read
	pop	af
	pop	af
	inc	sp
	ld	(_r), hl
;src\main.c:253: if (r == -1) {
	ld	iy, #_r
	ld	a, 0 (iy)
	inc	a
	jr	NZ,00573$
	ld	a, 1 (iy)
	inc	a
	jp	Z,00214$
00573$:
;src\main.c:256: if (memcmp(buffer, "NEXTOR_DRIVER", 13) == 1) {
	ld	hl, #0x000d
	push	hl
	ld	hl, #___str_0
	push	hl
	ld	hl, #_buffer
	push	hl
	call	_memcmp
	pop	af
	pop	af
	pop	af
	dec	l
	jr	NZ,00197$
;src\main.c:257: puts(errorNotNxtDrv);
	ld	hl, (_errorNotNxtDrv)
	push	hl
	call	_puts
	pop	af
;src\main.c:258: restoreHooks();
	call	_restoreHooks
;src\main.c:259: return 6;		
	ld	hl, #0x0006
	jp	00239$
00197$:
;src\main.c:261: if (verifySwId(buffer+16) == 0) {
	ld	hl, #(_buffer + 0x0010)
	push	hl
	call	_verifySwId
	pop	af
	ld	a, l
	or	a, a
	jr	NZ,00199$
;src\main.c:262: puts(errorWrongDrv);
	ld	hl, (_errorWrongDrv)
	push	hl
	call	_puts
	pop	af
;src\main.c:263: restoreHooks();
	call	_restoreHooks
;src\main.c:264: return 7;
	ld	hl, #0x0007
	jp	00239$
00199$:
;src\main.c:266: seekpos = lseek(fhandle, 0, SEEK_SET);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	xor	a, a
	push	af
	inc	sp
	ld	hl, #0x0000
	push	hl
	ld	hl, #0x0000
	push	hl
	push	bc
	inc	sp
	call	_lseek
	pop	af
	pop	af
	pop	af
	ld	iy, #0
	add	iy, sp
	ld	3 (iy), d
	ld	2 (iy), e
	ld	1 (iy), h
	ld	0 (iy), l
	ld	de, #_seekpos
	ld	hl, #0
	add	hl, sp
	ld	bc, #4
	ldir
;src\main.c:267: if (seekpos != 0) {
	ld	iy, #_seekpos
	ld	a, 3 (iy)
	or	a, 2 (iy)
	or	a, 1 (iy)
	or	a, 0 (iy)
	jr	Z,00203$
;src\main.c:268: puts(errorSeek);
	ld	hl, (_errorSeek)
	push	hl
	call	_puts
	pop	af
;src\main.c:269: restoreHooks();
	call	_restoreHooks
;src\main.c:270: return 7;
	ld	hl, #0x0007
	jp	00239$
00203$:
;src\main.c:276: resetAtEnd = 0;
	ld	hl,#_resetAtEnd + 0
	ld	(hl), #0x00
;src\main.c:277: if (isMain == 1 || isSlave == 1) {
	ld	a,(#_isMain + 0)
	dec	a
	jr	Z,00208$
	ld	a,(#_isSlave + 0)
	dec	a
	jr	NZ,00209$
00208$:
;src\main.c:278: puts(confirmReset0);
	ld	hl, (_confirmReset0)
	push	hl
	call	_puts
	pop	af
;src\main.c:279: puts(confirmReset2);
	ld	hl, (_confirmReset2)
	push	hl
	call	_puts
	pop	af
;src\main.c:280: puts(confirmReset3);
	ld	hl, (_confirmReset3)
	push	hl
	call	_puts
	pop	af
;src\main.c:281: clearKeyBuf();
	call	_clearKeyBuf
;src\main.c:282: c = getchar();
	call	_getchar
	ld	iy, #_c
	ld	0 (iy), l
;src\main.c:283: putchar(c);
	ld	a, (_c)
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:284: puts(crlf);
	ld	hl, (_crlf)
	push	hl
	call	_puts
	pop	af
;src\main.c:285: if (c == 'y' || c == 'Y') {
	ld	iy, #_c
	ld	a, 0 (iy)
	sub	a, #0x79
	jr	Z,00204$
	ld	a, 0 (iy)
	sub	a, #0x59
	jr	NZ,00205$
00204$:
;src\main.c:286: resetAtEnd = 1;
	ld	hl,#_resetAtEnd + 0
	ld	(hl), #0x01
	jr	00209$
00205$:
;src\main.c:288: close(fhandle);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	push	bc
	inc	sp
	call	_close
	inc	sp
;src\main.c:289: restoreHooks();
	call	_restoreHooks
;src\main.c:290: return 0;
	ld	hl, #0x0000
	jp	00239$
00209$:
;src\main.c:294: for (i = 0; i < 8; i++) {
	ld	hl, #0x0000
	ld	(_i), hl
00233$:
;src\main.c:295: mprSegments[i] = allocUserSegment();
	ld	iy, #_i
	ld	a, 0 (iy)
	add	a, #<(_mprSegments)
	ld	c, a
	ld	a, 1 (iy)
	adc	a, #>(_mprSegments)
	ld	b, a
	push	bc
	call	_allocUserSegment
	ld	a, l
	pop	bc
	ld	(bc), a
;src\main.c:296: if (mprSegments[i] == 0) {
	ld	iy, #_mprSegments
	ld	de, (_i)
	add	iy, de
	ld	a, 0 (iy)
	or	a, a
	jr	NZ,00234$
;src\main.c:297: puts(errorAllocMapper);
	ld	hl, (_errorAllocMapper)
	push	hl
	call	_puts
	pop	af
;src\main.c:298: close(fhandle);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	push	bc
	inc	sp
	call	_close
	inc	sp
;src\main.c:299: restoreHooks();
	call	_restoreHooks
;src\main.c:300: return 10;
	ld	hl, #0x000a
	jp	00239$
00234$:
;src\main.c:294: for (i = 0; i < 8; i++) {
	ld	iy, #_i
	inc	0 (iy)
	jr	NZ,00582$
	inc	1 (iy)
00582$:
	ld	a, 0 (iy)
	sub	a, #0x08
	ld	a, 1 (iy)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C,00233$
;src\main.c:303: puts(readingFile);
	ld	hl, (_readingFile)
	push	hl
	call	_puts
	pop	af
;src\main.c:304: c = 0;
	ld	hl,#_c + 0
	ld	(hl), #0x00
;src\main.c:305: for (i = 0; i < 8; i++) {
	ld	hl, #0x0000
	ld	(_i), hl
00235$:
;src\main.c:306: putchar(ce[c]);
	ld	iy, #_ce
	ld	de, (_c)
	ld	d, #0x00
	add	iy, de
	ld	b, 0 (iy)
	push	bc
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:307: putchar(8);
	ld	a, #0x08
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:308: c = (c + 1) & 0x03;
	ld	iy, #_c
	ld	a, 0 (iy)
	inc	a
	and	a, #0x03
	ld	0 (iy), a
;src\main.c:309: t1 = mprSegments[i];
	ld	a, #<(_mprSegments)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_mprSegments)
	inc	hl
	adc	a, (hl)
	ld	b, a
	ld	a, (bc)
	ld	(#_t1 + 0),a
;src\main.c:310: putSegFrame1(t1);
	ld	a, (_t1)
	push	af
	inc	sp
	call	_putSegFrame1
	inc	sp
;src\main.c:311: r = read(fhandle, (void *)0x4000, 16384);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	ld	hl, #0x4000
	push	hl
	ld	l, #0x00
	push	hl
	push	bc
	inc	sp
	call	_read
	pop	af
	pop	af
	inc	sp
	ld	(_r), hl
;src\main.c:312: putSegFrame1(curSegm);
	ld	a, (_curSegm)
	push	af
	inc	sp
	call	_putSegFrame1
	inc	sp
;src\main.c:313: if (r != 16384) {
	ld	iy, #_r
	ld	a, 0 (iy)
	or	a, a
	jr	NZ,00583$
	ld	a, 1 (iy)
	sub	a, #0x40
	jr	Z,00236$
00583$:
;src\main.c:314: readErr:
00214$:
;src\main.c:315: puts(readingError0);
	ld	hl, (_readingError0)
	push	hl
	call	_puts
	pop	af
;src\main.c:316: puthex8(last_error);
	ld	a, (_last_error)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
;src\main.c:317: puts(readingError1);
	ld	hl, (_readingError1)
	push	hl
	call	_puts
	pop	af
;src\main.c:318: close(fhandle);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	push	bc
	inc	sp
	call	_close
	inc	sp
;src\main.c:319: restoreHooks();
	call	_restoreHooks
;src\main.c:320: return 11;
	ld	hl, #0x000b
	jp	00239$
00236$:
;src\main.c:305: for (i = 0; i < 8; i++) {
	ld	iy, #_i
	inc	0 (iy)
	jr	NZ,00584$
	inc	1 (iy)
00584$:
	ld	a, 0 (iy)
	sub	a, #0x08
	ld	a, 1 (iy)
	rla
	ccf
	rra
	sbc	a, #0x80
	jp	C, 00235$
;src\main.c:323: puts(ok0);
	ld	hl, (_ok0)
	push	hl
	call	_puts
	pop	af
;src\main.c:324: close(fhandle);
	ld	hl,#_fhandle + 0
	ld	b, (hl)
	push	bc
	inc	sp
	call	_close
	inc	sp
;src\main.c:326: if (pause == 1) {
	ld	iy, #_pause
	ld	a, 0 (iy)
	dec	a
	jr	NZ,00219$
;src\main.c:327: puts(pauseMsg);
	ld	hl, (_pauseMsg)
	push	hl
	call	_puts
	pop	af
;src\main.c:328: getchar();
	call	_getchar
;src\main.c:329: puts(crlf);
	ld	hl, (_crlf)
	push	hl
	call	_puts
	pop	af
00219$:
;src\main.c:332: __asm__("di");
	di
;src\main.c:333: eraseFlash(slot);
	ld	a, (_slot)
	push	af
	inc	sp
	call	_eraseFlash
	inc	sp
;src\main.c:335: puts(writingFlash);
	ld	hl, (_writingFlash)
	push	hl
	call	_puts
	pop	af
;src\main.c:336: for (i = 0; i < 8; i++) {
	ld	hl, #0x0000
	ld	(_i), hl
00237$:
;src\main.c:337: if (writeBlock(slot, mprSegments[i], curSegm, i) == 0) {
	ld	hl,#_i + 0
	ld	b, (hl)
	ld	iy, #_mprSegments
	ld	de, (_i)
	add	iy, de
	ld	d, 0 (iy)
	push	bc
	inc	sp
	ld	a, (_curSegm)
	push	af
	inc	sp
	push	de
	inc	sp
	ld	a, (_slot)
	push	af
	inc	sp
	call	_writeBlock
	pop	af
	pop	af
	ld	a, l
	or	a, a
	jr	Z,00222$
;src\main.c:336: for (i = 0; i < 8; i++) {
	ld	iy, #_i
	inc	0 (iy)
	jr	NZ,00587$
	inc	1 (iy)
00587$:
	ld	a, 0 (iy)
	sub	a, #0x08
	ld	a, 1 (iy)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C,00237$
00222$:
;src\main.c:341: __asm__("ei");
	ei
;src\main.c:342: if (i != 8) {
	ld	iy, #_i
	ld	a, 0 (iy)
	sub	a, #0x08
	or	a, 1 (iy)
	jr	Z,00224$
;src\main.c:343: puts(errorWriting);
	ld	hl, (_errorWriting)
	push	hl
	call	_puts
	pop	af
;src\main.c:344: eraseFlash(slot);
	ld	a, (_slot)
	push	af
	inc	sp
	call	_eraseFlash
	inc	sp
;src\main.c:345: puts(systemHalted);
	ld	hl, (_systemHalted)
	push	hl
	call	_puts
	pop	af
;src\main.c:346: __asm__("di");
	di
;src\main.c:347: __asm__("halt");
	halt
	jr	00225$
00224$:
;src\main.c:349: putchar(' ');
	ld	a, #0x20
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\main.c:350: puts(ok0);
	ld	hl, (_ok0)
	push	hl
	call	_puts
	pop	af
00225$:
;src\main.c:352: if (resetAtEnd == 1) {
	ld	a,(#_resetAtEnd + 0)
	dec	a
	jr	NZ,00227$
;src\main.c:353: puts(anyKeyToReset);
	ld	hl, (_anyKeyToReset)
	push	hl
	call	_puts
	pop	af
;src\main.c:354: clearKeyBuf();
	call	_clearKeyBuf
;src\main.c:355: getchar();
	call	_getchar
;src\main.c:356: resetSystem();
	call	_resetSystem
00227$:
;src\main.c:358: restoreHooks();
	call	_restoreHooks
;src\main.c:359: return 0;
	ld	hl, #0x0000
00239$:
;src\main.c:360: }
	pop	af
	pop	af
	ret
___str_0:
	.ascii "NEXTOR_DRIVER"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__EXPTBL:
	.dw #0xfcc1
__xinit__DSKSLT:
	.dw #0xf348
__xinit__HTIMI:
	.dw #0xfd9f
	.area _CABS (ABS)
