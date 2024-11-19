;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (MINGW64)
;--------------------------------------------------------
	.module strings
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ce
	.globl _anyKeyToReset
	.globl _systemHalted
	.globl _ok0
	.globl _errorWriting
	.globl _writingFlash
	.globl _erasingFlash
	.globl _pauseMsg
	.globl _errorSeek
	.globl _errorWrongDrv
	.globl _errorNotNxtDrv
	.globl _filesizeError
	.globl _readingError1
	.globl _readingError0
	.globl _readingFile
	.globl _openingError
	.globl _errorAllocMapper
	.globl _noMemAvailable
	.globl _errorNoExtBios
	.globl _confirmReset3
	.globl _confirmReset2
	.globl _confirmReset1
	.globl _confirmReset0
	.globl _notfound
	.globl _found3
	.globl _searching
	.globl _whatsubslot
	.globl _whatslot
	.globl _crlf
	.globl _usage3
	.globl _usage1
	.globl _title2
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
_title2::
	.ds 2
_usage1::
	.ds 2
_usage3::
	.ds 2
_crlf::
	.ds 2
_whatslot::
	.ds 2
_whatsubslot::
	.ds 2
_searching::
	.ds 2
_found3::
	.ds 2
_notfound::
	.ds 2
_confirmReset0::
	.ds 2
_confirmReset1::
	.ds 2
_confirmReset2::
	.ds 2
_confirmReset3::
	.ds 2
_errorNoExtBios::
	.ds 2
_noMemAvailable::
	.ds 2
_errorAllocMapper::
	.ds 2
_openingError::
	.ds 2
_readingFile::
	.ds 2
_readingError0::
	.ds 2
_readingError1::
	.ds 2
_filesizeError::
	.ds 2
_errorNotNxtDrv::
	.ds 2
_errorWrongDrv::
	.ds 2
_errorSeek::
	.ds 2
_pauseMsg::
	.ds 2
_erasingFlash::
	.ds 2
_writingFlash::
	.ds 2
_errorWriting::
	.ds 2
_ok0::
	.ds 2
_systemHalted::
	.ds 2
_anyKeyToReset::
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
	.area _CODE
_ce:
	.db 0x5c
	.ascii "|/-"
	.db 0x00
___str_0:
	.ascii "(c) 2014-2017 FBLabs"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_1:
	.db 0x0d
	.db 0x0a
	.ascii "Usage:"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_2:
	.db 0x0d
	.db 0x0a
	.ascii "Options:"
	.db 0x0d
	.db 0x0a
	.ascii "     /h : Show this help."
	.db 0x0d
	.db 0x0a
	.ascii "     /s : Ask the interface slot."
	.db 0x0d
	.db 0x0a
	.ascii "     /e : Only erase flash and exit."
	.db 0x0d
	.db 0x0a
	.ascii "     /p : Pause before flashing."
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_3:
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "What is the interface slot? (0-3)"
	.db 0x00
___str_5:
	.ascii "What is the subslot? (0-3)"
	.db 0x00
___str_6:
	.ascii "Searching interface ..."
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_7:
	.ascii " in slot "
	.db 0x00
___str_8:
	.ascii "Oops! Interface not found!!"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_9:
	.ascii "The system will have to be reset at the end of the "
	.db 0x00
___str_10:
	.ascii "erase"
	.db 0x00
___str_11:
	.ascii "update"
	.db 0x00
___str_12:
	.ascii " process. Do you want to proceed? (y/n)"
	.db 0x00
___str_13:
	.ascii "Memory Mapper management EXTBIOS not found. Falling back to "
	.ascii "direct I/O."
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_14:
	.ascii "No memory available."
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_15:
	.db 0x0d
	.db 0x0a
	.ascii "Error allocating mapper segment."
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_16:
	.ascii "Error opening file!"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_17:
	.ascii "Reading file: "
	.db 0x00
___str_18:
	.db 0x0d
	.db 0x0a
	.ascii "Reading error: "
	.db 0x00
___str_19:
	.ascii "!"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_20:
	.ascii "ERROR: File size must be 128KB"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_21:
	.ascii "This file is not a Nextor driver!"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_22:
	.ascii "Wrong driver!"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_23:
	.ascii "Error seeking!"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_24:
	.ascii "Press any key to continue."
	.db 0x00
___str_25:
	.ascii "Erasing flash: "
	.db 0x00
___str_26:
	.ascii "Writing flash: "
	.db 0x00
___str_27:
	.db 0x0d
	.db 0x0a
	.ascii "Error!"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_28:
	.ascii "OK"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_29:
	.ascii "System halted."
	.db 0x00
___str_30:
	.ascii "The BIOS was successfully updated. Press any key to reboot."
	.db 0x00
	.area _INITIALIZER
__xinit__title2:
	.dw ___str_0
__xinit__usage1:
	.dw ___str_1
__xinit__usage3:
	.dw ___str_2
__xinit__crlf:
	.dw ___str_3
__xinit__whatslot:
	.dw ___str_4
__xinit__whatsubslot:
	.dw ___str_5
__xinit__searching:
	.dw ___str_6
__xinit__found3:
	.dw ___str_7
__xinit__notfound:
	.dw ___str_8
__xinit__confirmReset0:
	.dw ___str_9
__xinit__confirmReset1:
	.dw ___str_10
__xinit__confirmReset2:
	.dw ___str_11
__xinit__confirmReset3:
	.dw ___str_12
__xinit__errorNoExtBios:
	.dw ___str_13
__xinit__noMemAvailable:
	.dw ___str_14
__xinit__errorAllocMapper:
	.dw ___str_15
__xinit__openingError:
	.dw ___str_16
__xinit__readingFile:
	.dw ___str_17
__xinit__readingError0:
	.dw ___str_18
__xinit__readingError1:
	.dw ___str_19
__xinit__filesizeError:
	.dw ___str_20
__xinit__errorNotNxtDrv:
	.dw ___str_21
__xinit__errorWrongDrv:
	.dw ___str_22
__xinit__errorSeek:
	.dw ___str_23
__xinit__pauseMsg:
	.dw ___str_24
__xinit__erasingFlash:
	.dw ___str_25
__xinit__writingFlash:
	.dw ___str_26
__xinit__errorWriting:
	.dw ___str_27
__xinit__ok0:
	.dw ___str_28
__xinit__systemHalted:
	.dw ___str_29
__xinit__anyKeyToReset:
	.dw ___str_30
	.area _CABS (ABS)
