/*
; flash.c - flash the ROM in the MSXUSB cartridge
; Copyright (c) 2020 Mario Smit (S0urceror)
; 
; This program is free software: you can redistribute it and/or modify  
; it under the terms of the GNU General Public License as published by  
; the Free Software Foundation, version 3.
;
; This program is distributed in the hope that it will be useful, but 
; WITHOUT ANY WARRANTY; without even the implied warranty of 
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
; General Public License for more details.
;
; You should have received a copy of the GNU General Public License 
; along with this program. If not, see <http://www.gnu.org/licenses/>.
;
*/
#include <msx_fusion.h>
#include <io.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <math.h>
//#include "mystdio.h"
#include "flash-v5.h"

#define SEGMENT_SIZE 8*1024

__at 0x8000 uint8_t file_segment[SEGMENT_SIZE];
__at 0x4000 uint8_t flash_segment[];

int main(char *argv[], int argc)
{   
    uint8_t slot=0;
    uint8_t argnr=0;
    printf ("MSXUSB Flash, (c) 2020 S0urceror\r\n\r\n");
    if (argc < 1)
    {
        printf ("FLASH.COM [flags] [romfile]\r\n\r\n");
        return (0);
    }

    if (argnr==0)
    {   
        // find the slot where the flash rom is sitting
        if (!((slot = find_flash())<4))
        {
            printf ("Cannot find slot with flash\r\n");
            return (0);
        } 
    }

    printf ("Found flash in slot: %d\r\n",slot);

    return(0);
}

void select_slot_40 (uint8_t slot)
{
    slot;
    __asm
    ld iy,#2
    add iy,sp ;Bypass the return address of the function 

    ld a,(iy)   ;slot
    ld h,#0x40
    jp	0x24 ; ENASLT
    __endasm;
}

void select_ramslot_40 ()
{
    __asm
    ld	a,(#0xf342) ; RAMAD1
	ld	h,#0x40
	jp	0x24 ; ENASLT
    __endasm;
}
BOOL flash_ident ()
{
    uint8_t dummy;
    // reset
    flash_segment[0] = 0xf0;
    // write autoselect code
    dummy = flash_segment [0x555];
    flash_segment[0x555] = 0xaa;
    dummy = flash_segment [0x2aa];
    flash_segment[0x2aa] = 0x55;
    dummy = flash_segment [0x555];
    flash_segment[0x555] = 0x90;
    // read response
    uint8_t manufacturer = flash_segment[0];
    uint8_t device = flash_segment[1];
    printf ("M: %x, D: %x\r\n",manufacturer,device);
    // AMD_AM29F040 = A4
    // SST_SST39SF040 = B7
    // AMIC_A29040B = 86
    if (device==0xA4)  // device ID is correct
    {
        printf ("Found device: AMD_AM29F040\r\n");
        // reset
        flash_segment[0] = 0xf0;
        return TRUE;
    }
    if (device==0xB7)  // device ID is correct
    {
        printf ("Found device: SST_SST39SF040\r\n");
        // reset
        flash_segment[0] = 0xf0;
        return TRUE;
    }
    if (device==0x86)  // device ID is correct
    {
        printf ("Found device: AMIC_A29040B\r\n");
        // reset
        flash_segment[0] = 0xf0;
        return TRUE;
    }
    return FALSE;
}

uint8_t find_flash ()
{
    uint8_t i;
    uint8_t highest_slot = 4;
    for (i=0;i<4;i++)
    {
        // select slot in 0x4000-0x7fff
        select_slot_40 (i);
        // do flash identification
        if (flash_ident ())
            highest_slot=i; // yes? save slot number
    }
    select_ramslot_40 ();
    return highest_slot;
}

