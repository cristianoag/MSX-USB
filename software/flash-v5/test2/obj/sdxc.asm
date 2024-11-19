;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (MINGW64)
;--------------------------------------------------------
	.module sdxc
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _putSegFrame1
	.globl _putSlotFrame2
	.globl _putSlotFrame1
	.globl _putRamFrame2
	.globl _putRamFrame1
	.globl _memcmp
	.globl _puts
	.globl _putchar
	.globl _usage2
	.globl _title1
	.globl _detectInterface
	.globl _verifySwId
	.globl _eraseFlash
	.globl _writeBlock
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_i:
	.ds 2
_c:
	.ds 1
_t1:
	.ds 1
_t2:
	.ds 1
_flashIdMan:
	.ds 1
_flashIdProd:
	.ds 1
_alg:
	.ds 1
_mySlot:
	.ds 1
_source:
	.ds 2
_dest:
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_title1::
	.ds 2
_usage2::
	.ds 2
_found:
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
;src\sdxc.c:44: static unsigned char flashIdent(unsigned char manId, unsigned char prodId)
;	---------------------------------
; Function flashIdent
; ---------------------------------
_flashIdent:
;src\sdxc.c:46: if (manId == 0x01) {				// AMD
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	dec	a
	jr	NZ,00139$
;src\sdxc.c:47: if (prodId == 0x20) {			// AM29F010
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x20
	jp	NZ,00140$
;src\sdxc.c:48: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:49: return 1;
	ld	l, #0x01
	ret
00139$:
;src\sdxc.c:52: if (prodId == 0x07) {			// AT49F002
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x07
	jr	NZ, 00222$
	ld	a, #0x01
	.db	#0x20
00222$:
	xor	a, a
00223$:
	ld	c, a
;src\sdxc.c:51: } else if (manId == 0x1F) {			// Atmel
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
;src\sdxc.c:52: if (prodId == 0x07) {			// AT49F002
	sub	a,#0x1f
	jr	NZ,00136$
	or	a,c
	jr	Z,00112$
;src\sdxc.c:53: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:54: return 1;
	ld	l, #0x01
	ret
00112$:
;src\sdxc.c:55: } else if (prodId == 0x08) {	// AT49F002T
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x08
	jr	NZ,00109$
;src\sdxc.c:56: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:57: return 1;
	ld	l, #0x01
	ret
00109$:
;src\sdxc.c:58: } else if (prodId == 0x17) {	// AT49F010
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x17
	jr	NZ,00106$
;src\sdxc.c:59: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:60: return 1;
	ld	l, #0x01
	ret
00106$:
;src\sdxc.c:61: } else if (prodId == 0xD5) {	// AT29C010 (page)
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0xd5
	jp	NZ,00140$
;src\sdxc.c:62: alg = ALGPAGE;
	ld	hl,#_alg + 0
	ld	(hl), #0x01
;src\sdxc.c:63: return 1;
	ld	l, #0x01
	ret
00136$:
;src\sdxc.c:65: } else if (manId == 0xBF) {			// SST
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
;src\sdxc.c:66: if (prodId == 0x07) {			// SST29EE010 (page)
	sub	a,#0xbf
	jr	NZ,00133$
	or	a,c
	jr	Z,00120$
;src\sdxc.c:67: alg = ALGPAGE;
	ld	hl,#_alg + 0
	ld	(hl), #0x01
;src\sdxc.c:68: return 1;
	ld	l, #0x01
	ret
00120$:
;src\sdxc.c:69: } else if (prodId == 0xB5) {	// SST39SF010A
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0xb5
	jr	NZ,00117$
;src\sdxc.c:70: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:71: return 1;
	ld	l, #0x01
	ret
00117$:
;src\sdxc.c:72: } else if (prodId == 0xB6) {	// SST39SF020
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0xb6
	jr	NZ,00140$
;src\sdxc.c:73: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:74: return 1;
	ld	l, #0x01
	ret
00133$:
;src\sdxc.c:76: } else if (manId == 0xDA) {			// Winbond
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0xda
	jr	NZ,00140$
;src\sdxc.c:77: if (prodId == 0x0B) {			// W49F002UN
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x0b
	jr	NZ,00128$
;src\sdxc.c:78: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:79: return 1;
	ld	l, #0x01
	ret
00128$:
;src\sdxc.c:80: } else if (prodId == 0x25) {	// W49F002B
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x25
	jr	NZ,00125$
;src\sdxc.c:81: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:82: return 1;
	ld	l, #0x01
	ret
00125$:
;src\sdxc.c:83: } else if (prodId == 0xA1) {	// W39F010
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	sub	a, #0xa1
	jr	NZ,00140$
;src\sdxc.c:84: alg = ALGBYTE;
	ld	hl,#_alg + 0
	ld	(hl), #0x00
;src\sdxc.c:85: return 1;
	ld	l, #0x01
	ret
00140$:
;src\sdxc.c:88: return 0;
	ld	l, #0x00
;src\sdxc.c:89: }
	ret
;src\sdxc.c:92: static void flashSendCmd(unsigned char cmd)
;	---------------------------------
; Function flashSendCmd
; ---------------------------------
_flashSendCmd:
;src\sdxc.c:94: poke(0x7000, 0x09);		// Bank 1 in the Frame-2 (4000-7FFF)
	ld	hl, #0x7000
	ld	(hl), #0x09
;src\sdxc.c:95: poke(0x9555, 0xAA);		// Absolute address 0x05555
	ld	hl, #0x9555
	ld	(hl), #0xaa
;src\sdxc.c:96: poke(0x7000, 0x08);		// Bank 0 in the Frame-2 (0000-3FFF)
	ld	hl, #0x7000
	ld	(hl), #0x08
;src\sdxc.c:97: poke(0xAAAA, 0x55);		// Absolute address 0x02AAA
	ld	hl, #0xaaaa
	ld	(hl), #0x55
;src\sdxc.c:98: poke(0x7000, 0x09);		// Bank 1 in the Frame-2 (4000-7FFF)
	ld	hl, #0x7000
	ld	(hl), #0x09
;src\sdxc.c:99: poke(0x9555, cmd);
	ld	hl, #0x9555
	ld	iy, #2
	add	iy, sp
	ld	a, 0 (iy)
	ld	(hl), a
;src\sdxc.c:100: }
	ret
;src\sdxc.c:103: static void flashEraseSectorSendCmd(unsigned char sector)
;	---------------------------------
; Function flashEraseSectorSendCmd
; ---------------------------------
_flashEraseSectorSendCmd:
;src\sdxc.c:105: poke(0x7000, 0x09);		// Bank 1 in the Frame-2 (4000-7FFF)
	ld	hl, #0x7000
	ld	(hl), #0x09
;src\sdxc.c:106: poke(0x9555, 0xAA);		// Absolute address 0x05555
	ld	hl, #0x9555
	ld	(hl), #0xaa
;src\sdxc.c:107: poke(0x7000, 0x08);		// Bank 0 in the Frame-2 (0000-3FFF)
	ld	hl, #0x7000
	ld	(hl), #0x08
;src\sdxc.c:108: poke(0xAAAA, 0x55);		// Absolute address 0x02AAA
	ld	hl, #0xaaaa
	ld	(hl), #0x55
;src\sdxc.c:109: poke(0x7000, 0x08 | (sector >> 2));		// Bank x in the Frame-2
	ld	iy, #2
	add	iy, sp
	ld	c, 0 (iy)
	srl	c
	srl	c
	set	3, c
	ld	hl, #0x7000
	ld	(hl), c
;src\sdxc.c:110: poke(0x8000 | ((sector & 0x03) << 12), FLASHCMD_ERASESECTOR);
	ld	a, 0 (iy)
	and	a, #0x03
	rlca
	rlca
	rlca
	rlca
	and	a, #0xf0
	ld	h, a
	ld	l, #0x00
	set	7, h
	ld	(hl), #0x30
;src\sdxc.c:111: }
	ret
;src\sdxc.c:115: static unsigned char writeHalfBlock(unsigned char bank)
;	---------------------------------
; Function writeHalfBlock
; ---------------------------------
_writeHalfBlock:
;src\sdxc.c:117: putSlotFrame1(mySlot);
	ld	a, (_mySlot)
	push	af
	inc	sp
	call	_putSlotFrame1
	inc	sp
;src\sdxc.c:118: putSlotFrame2(mySlot);
	ld	a, (_mySlot)
	push	af
	inc	sp
	call	_putSlotFrame2
	inc	sp
;src\sdxc.c:119: t1 = 0;
	ld	hl,#_t1 + 0
	ld	(hl), #0x00
;src\sdxc.c:120: source = (unsigned char *)0x2000;
	ld	hl, #0x2000
	ld	(_source), hl
;src\sdxc.c:121: while ((unsigned int)source < 0x4000) {
00112$:
	ld	hl, (_source)
	ld	a, h
	sub	a, #0x40
	jp	NC, 00115$
;src\sdxc.c:122: flashSendCmd(FLASHCMD_WRITEBYTE);
	ld	a, #0xa0
	push	af
	inc	sp
	call	_flashSendCmd
	inc	sp
;src\sdxc.c:123: poke(0x7000, bank | 0x08);
	ld	hl, #2+0
	add	hl, sp
	ld	c, (hl)
	set	3, c
	ld	hl, #0x7000
	ld	(hl), c
;src\sdxc.c:125: *dest = *source;			// write byte
	ld	bc, (_dest)
	ld	hl, (_source)
	ld	e, (hl)
;src\sdxc.c:124: if (alg == ALGBYTE) {
	ld	a,(#_alg + 0)
	or	a, a
	jr	NZ,00103$
;src\sdxc.c:125: *dest = *source;			// write byte
	ld	a, e
	ld	(bc), a
	jr	00104$
00103$:
;src\sdxc.c:127: for (i = 0; i < 127; i++) {	// write 128-byte
	ld	hl, #0x0000
	ld	(_i), hl
00116$:
;src\sdxc.c:128: *dest = *source;
	ld	a, e
	ld	(bc), a
;src\sdxc.c:129: ++dest;
	ld	iy, #_dest
	inc	0 (iy)
	jr	NZ,00168$
	inc	1 (iy)
00168$:
;src\sdxc.c:130: ++source;
	ld	iy, #_source
	inc	0 (iy)
	jr	NZ,00169$
	inc	1 (iy)
00169$:
;src\sdxc.c:127: for (i = 0; i < 127; i++) {	// write 128-byte
	ld	iy, #_i
	inc	0 (iy)
	jr	NZ,00170$
	inc	1 (iy)
00170$:
;src\sdxc.c:125: *dest = *source;			// write byte
	ld	bc, (_dest)
	ld	hl, (_source)
	ld	e, (hl)
;src\sdxc.c:127: for (i = 0; i < 127; i++) {	// write 128-byte
	ld	a, 0 (iy)
	sub	a, #0x7f
	ld	a, 1 (iy)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C,00116$
;src\sdxc.c:132: *dest = *source;
	ld	a, e
	ld	(bc), a
00104$:
;src\sdxc.c:134: i = 3800;
	ld	hl, #0x0ed8
	ld	(_i), hl
;src\sdxc.c:135: while (--i != 0) {
00107$:
	ld	hl, (_i)
	dec	hl
	ld	(_i), hl
	ld	iy, #_i
	ld	a, 1 (iy)
	or	a, 0 (iy)
	jr	Z,00109$
;src\sdxc.c:136: if (*dest == *source) {		// toggle bit, if equal byte was written
	ld	hl, (_dest)
	ld	c, (hl)
	ld	hl, (_source)
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jr	NZ,00107$
;src\sdxc.c:137: break;
00109$:
;src\sdxc.c:140: if (i == 0) {					// timeout
	ld	iy, #_i
	ld	a, 1 (iy)
	or	a, 0 (iy)
	jr	NZ,00111$
;src\sdxc.c:141: t1 = 1;						// error
	ld	hl,#_t1 + 0
	ld	(hl), #0x01
;src\sdxc.c:142: goto exit;
	jr	00115$
00111$:
;src\sdxc.c:144: ++dest;
	ld	iy, #_dest
	inc	0 (iy)
	jr	NZ,00173$
	inc	1 (iy)
00173$:
;src\sdxc.c:145: ++source;
	ld	iy, #_source
	inc	0 (iy)
	jp	NZ,00112$
	inc	1 (iy)
	jp	00112$
;src\sdxc.c:147: exit:
00115$:
;src\sdxc.c:148: putRamFrame1();
	call	_putRamFrame1
;src\sdxc.c:149: putRamFrame2();
	call	_putRamFrame2
;src\sdxc.c:150: return t1;
	ld	iy, #_t1
	ld	l, 0 (iy)
;src\sdxc.c:151: }
	ret
;src\sdxc.c:157: unsigned char detectInterface(unsigned char slot)
;	---------------------------------
; Function detectInterface
; ---------------------------------
_detectInterface::
;src\sdxc.c:159: __asm__("di");
	di
;src\sdxc.c:160: putSlotFrame1(slot);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSlotFrame1
	inc	sp
;src\sdxc.c:161: putSlotFrame2(slot);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSlotFrame2
	inc	sp
;src\sdxc.c:163: flashSendCmd(FLASHCMD_SOFTIDENTRY);
	ld	a, #0x90
	push	af
	inc	sp
	call	_flashSendCmd
	inc	sp
;src\sdxc.c:164: flashIdMan = peek(0x8000);
	ld	a, (#0x8000)
	ld	(#_flashIdMan + 0),a
;src\sdxc.c:165: flashIdProd = peek(0x8001);
	ld	a, (#0x8001)
	ld	(#_flashIdProd + 0),a
;src\sdxc.c:166: flashSendCmd(FLASHCMD_SOFTRESET);
	ld	a, #0xf0
	push	af
	inc	sp
	call	_flashSendCmd
	inc	sp
;src\sdxc.c:167: putRamFrame1();
	call	_putRamFrame1
;src\sdxc.c:168: putRamFrame2();
	call	_putRamFrame2
;src\sdxc.c:169: __asm__("ei");
	ei
;src\sdxc.c:172: if (flashIdent(flashIdMan, flashIdProd) == 1) {
	ld	a, (_flashIdProd)
	push	af
	inc	sp
	ld	a, (_flashIdMan)
	push	af
	inc	sp
	call	_flashIdent
	pop	af
	dec	l
	jr	NZ,00102$
;src\sdxc.c:186: puts(found);
	ld	hl, (_found)
	push	hl
	call	_puts
	pop	af
;src\sdxc.c:187: return 1;
	ld	l, #0x01
	ret
00102$:
;src\sdxc.c:194: return 0;
	ld	l, #0x00
;src\sdxc.c:195: }
	ret
;src\sdxc.c:198: unsigned char verifySwId(unsigned char *str)
;	---------------------------------
; Function verifySwId
; ---------------------------------
_verifySwId::
;src\sdxc.c:200: if (memcmp(str, "FBLabs SDXC", 11) == 0) {
	ld	hl, #0x000b
	push	hl
	ld	hl, #___str_0
	push	hl
	ld	hl, #6
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_memcmp
	pop	af
	pop	af
	pop	af
	ld	a, l
	or	a, a
	jr	NZ,00102$
;src\sdxc.c:201: return 1;
	ld	l, #0x01
	ret
00102$:
;src\sdxc.c:203: return 0;
	ld	l, #0x00
;src\sdxc.c:204: }
	ret
___str_0:
	.ascii "FBLabs SDXC"
	.db 0x00
;src\sdxc.c:207: static void waitErase(void)
;	---------------------------------
; Function waitErase
; ---------------------------------
_waitErase:
;src\sdxc.c:209: c = 0;
	ld	iy, #_c
	ld	0 (iy), #0x00
;src\sdxc.c:210: t2 = 10;
	ld	iy, #_t2
	ld	0 (iy), #0x0a
;src\sdxc.c:211: while (--t2 != 0) {
00103$:
	ld	iy, #_t2
	dec	0 (iy)
	ld	a, 0 (iy)
	or	a, a
	ret	Z
;src\sdxc.c:212: __asm__("ei");
	ei
;src\sdxc.c:213: __asm__("halt");
	halt
;src\sdxc.c:214: __asm__("di");
	di
;src\sdxc.c:215: t1 = peek(0x4000);
	ld	a, (#0x4000)
	ld	(#_t1 + 0),a
;src\sdxc.c:216: t2 = peek(0x4000);
	ld	a, (#0x4000)
	ld	(#_t2 + 0),a
;src\sdxc.c:217: if (t1 == t2) {
	ld	a,(#_t1 + 0)
	ld	iy, #_t2
	sub	a, 0 (iy)
	ret	Z
;src\sdxc.c:220: putchar(ce[c]);
	ld	iy, #_ce
	ld	de, (_c)
	ld	d, #0x00
	add	iy, de
	ld	b, 0 (iy)
	push	bc
	inc	sp
	call	_putchar
	inc	sp
;src\sdxc.c:221: putchar(8);
	ld	a, #0x08
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\sdxc.c:222: c = (c + 1) & 0x03;
	ld	iy, #_c
	ld	a, 0 (iy)
	inc	a
	and	a, #0x03
	ld	0 (iy), a
;src\sdxc.c:224: }
	jr	00103$
;src\sdxc.c:227: void eraseFlash(unsigned char slot)
;	---------------------------------
; Function eraseFlash
; ---------------------------------
_eraseFlash::
;src\sdxc.c:229: puts(erasingFlash);
	ld	hl, (_erasingFlash)
	push	hl
	call	_puts
	pop	af
;src\sdxc.c:230: putSlotFrame1(slot);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSlotFrame1
	inc	sp
;src\sdxc.c:231: putSlotFrame2(slot);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSlotFrame2
	inc	sp
;src\sdxc.c:232: for (i = 0; i < 32; i++) {
	ld	hl, #0x0000
	ld	(_i), hl
00102$:
;src\sdxc.c:233: flashSendCmd(FLASHCMD_ERASE);
	ld	a, #0x80
	push	af
	inc	sp
	call	_flashSendCmd
	inc	sp
;src\sdxc.c:234: flashEraseSectorSendCmd(i);
	ld	hl,#_i + 0
	ld	b, (hl)
	push	bc
	inc	sp
	call	_flashEraseSectorSendCmd
	inc	sp
;src\sdxc.c:235: waitErase();
	call	_waitErase
;src\sdxc.c:232: for (i = 0; i < 32; i++) {
	ld	iy, #_i
	inc	0 (iy)
	jr	NZ,00116$
	inc	1 (iy)
00116$:
	ld	a, 0 (iy)
	sub	a, #0x20
	ld	a, 1 (iy)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C,00102$
;src\sdxc.c:237: flashSendCmd(FLASHCMD_SOFTRESET);
	ld	a, #0xf0
	push	af
	inc	sp
	call	_flashSendCmd
	inc	sp
;src\sdxc.c:238: putRamFrame1();
	call	_putRamFrame1
;src\sdxc.c:239: putRamFrame2();
	call	_putRamFrame2
;src\sdxc.c:240: puts(ok0);
	ld	hl, (_ok0)
	push	hl
	call	_puts
	pop	af
;src\sdxc.c:241: }
	ret
;src\sdxc.c:244: unsigned char writeBlock(unsigned char slot, unsigned char segment,
;	---------------------------------
; Function writeBlock
; ---------------------------------
_writeBlock::
;src\sdxc.c:247: mySlot = slot;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_mySlot + 0),a
;src\sdxc.c:248: dest = (unsigned char *)0x8000;
	ld	hl, #0x8000
	ld	(_dest), hl
;src\sdxc.c:249: putSegFrame1(segment);
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSegFrame1
	inc	sp
;src\sdxc.c:250: __asm__("push hl");
	push	hl
;src\sdxc.c:251: __asm__("push de");
	push	de
;src\sdxc.c:252: __asm__("push bc");
	push	bc
;src\sdxc.c:253: __asm__("ld hl, #0x4000");
	ld	hl, #0x4000
;src\sdxc.c:254: __asm__("ld de, #0x2000");
	ld	de, #0x2000
;src\sdxc.c:255: __asm__("ld bc, #0x2000");
	ld	bc, #0x2000
;src\sdxc.c:256: __asm__("ldir");
	ldir
;src\sdxc.c:257: __asm__("pop bc");
	pop	bc
;src\sdxc.c:258: __asm__("pop de");
	pop	de
;src\sdxc.c:259: __asm__("pop hl");
	pop	hl
;src\sdxc.c:260: putSegFrame1(curSegm);
	ld	hl, #4+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSegFrame1
	inc	sp
;src\sdxc.c:261: if (writeHalfBlock(bank) != 0) {
	ld	hl, #5+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_writeHalfBlock
	inc	sp
	ld	a, l
	or	a, a
	jr	Z,00102$
;src\sdxc.c:262: return 0;
	ld	l, #0x00
	ret
00102$:
;src\sdxc.c:264: putchar('*');
	ld	a, #0x2a
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\sdxc.c:265: putSegFrame1(segment);
	ld	hl, #3+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSegFrame1
	inc	sp
;src\sdxc.c:266: __asm__("push hl");
	push	hl
;src\sdxc.c:267: __asm__("push de");
	push	de
;src\sdxc.c:268: __asm__("push bc");
	push	bc
;src\sdxc.c:269: __asm__("ld hl, #0x6000");
	ld	hl, #0x6000
;src\sdxc.c:270: __asm__("ld de, #0x2000");
	ld	de, #0x2000
;src\sdxc.c:271: __asm__("ld bc, #0x2000");
	ld	bc, #0x2000
;src\sdxc.c:272: __asm__("ldir");
	ldir
;src\sdxc.c:273: __asm__("pop bc");
	pop	bc
;src\sdxc.c:274: __asm__("pop de");
	pop	de
;src\sdxc.c:275: __asm__("pop hl");
	pop	hl
;src\sdxc.c:276: putSegFrame1(curSegm);
	ld	hl, #4+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_putSegFrame1
	inc	sp
;src\sdxc.c:277: if (writeHalfBlock(bank) != 0) {
	ld	hl, #5+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_writeHalfBlock
	inc	sp
	ld	a, l
	or	a, a
	jr	Z,00104$
;src\sdxc.c:278: return 0;
	ld	l, #0x00
	ret
00104$:
;src\sdxc.c:280: putchar('*');
	ld	a, #0x2a
	push	af
	inc	sp
	call	_putchar
	inc	sp
;src\sdxc.c:281: return 1;
	ld	l, #0x01
;src\sdxc.c:282: }
	ret
	.area _CODE
___str_1:
	.ascii "FBLabs SDXC programmer utility"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "     fbl-upd /opts <filename.ext>"
	.db 0x0d
	.db 0x0a
	.ascii "Example: fbl-upd DRIVER.ROM"
	.db 0x0d
	.db 0x0a
	.ascii "         fbl-upd /e"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_3:
	.ascii "Found SDXC interface"
	.db 0x00
	.area _INITIALIZER
__xinit__title1:
	.dw ___str_1
__xinit__usage2:
	.dw ___str_2
__xinit__found:
	.dw ___str_3
	.area _CABS (ABS)
