; MSXUSB USB FDD BIOS
; Based on the Rookie Drive USB FDD BIOS created by Konamiman in 2018
; This version is adapted to work with the latest version of the MSXUSB project
;
; This file contains the code to call a routine in another ROM bank.
; This code needs to exist in both ROM banks 0 and 1, and at the same address.
;
; Labels are defined at the main file, not here, so that this file can be included twice.

; Adjusted for the Konami SCC mapper with proper bank-switching addresses by The Retro Hacker
; This is to support MSXUSB which uses the Konami SCC mapper for bank-switching
; Date: 2024-12-22
; 
; Key Changes:
; - Bank switching now uses the addresses for the Konami SCC mapper:
;   Bank 1: 5000h (4000h-5FFFh region)
;   Bank 2: 7000h (6000h-7FFFh region)
;   Bank 3: 9000h (8000h-9FFFh region)
;   Bank 4: B000h (A000h-BFFFh region)
; - Fixed layout of the SCC mapper is assumed for other regions.

;CALL_IX:
    jp (ix) ; Jump to the address in IX (routine in the switched bank)


; Call a routine in another bank
; Input:  IX = Routine address
;         IYl = Bank number
;         All others registers = input for the routine
; Output: All registers = output from the routine

;CALL_BANK:
    push hl ; Save HL (used to track the current bank)
    ld hl,(7FFFh) ; Load the current bank number into HL (L=Current bank)
    ex (sp),hl ; Swap HL with the top of the stack (store previous bank)
    push af ; Save AF (to preserve flags)

    ; Switch to the target bank
    ld a,iyl ; Load the target bank number into A
    if USE_ALTERNATIVE_PORTS=1
    or 80h
    endif

    sla a ; Shift the bank number to the left
    ld (ROM_BANK_SWITCH),a ; Switch bank for 4000h-5FFFh region
    inc a ; Increment the bank number
    ld (7000h),a ; Switch bank for 6000h-7FFFh region

    pop af ; Restore AF (flags)
    call CALL_IX ; Call the routine in the switched bank
    ex (sp),hl ; Retrieve the previous bank number into HL
    push af ; Save AF again (to preserve flags during restoration)
    ld a,l ; Load the previous bank number into A

    if USE_ALTERNATIVE_PORTS=1
    or 80h
    endif
    
    sla a ; Shift the bank number to the left
    ld (ROM_BANK_SWITCH),a ; Switch bank for 4000h-5FFFh region
    inc a ; Increment the bank number
    ld (7000h),a ; Switch bank for 6000h-7FFFh region
    
    pop af ; Restore AF (flags)
    pop hl ; Restore HL
    ret ; Return to the calling routine


