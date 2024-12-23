/*
; flash.c - flash the ROM in the MSXUSB cartridge
; Copyright (c) 2020 Mario Smit (S0urceror)
; Copyright (c) 2024 Cristiano Goncalves (The Retro Hacker)
; 
; This program writes a KonamiSCC ROM to a flash ROM in the MSXUSB cartridge
; 
; Requirements to compile and use this code:
; - SDCC compiler 3.9 (only!)
; - Fusion-C library 1.3 (also works with 1.2)
; - MSXUSB cartridge with flash ROM
;
*/
#include <msx_fusion.h>
#include <io.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <math.h>
#include "flash.h"
#include "bios.h"

#define SEGMENT_SIZE 8*1024

__at 0x8000 uint8_t file_segment[SEGMENT_SIZE];
__at 0x4000 uint8_t flash_segment[];

void FT_SetName( FCB *p_fcb, const char *p_name )  // Routine servant à vérifier le format du nom de fichier
{
  char i, j;
  memset( p_fcb, 0, sizeof(FCB) );
  for( i = 0; i < 11; i++ ) {
    p_fcb->name[i] = ' ';
  }
  for( i = 0; (i < 8) && (p_name[i] != 0) && (p_name[i] != '.'); i++ ) {
    p_fcb->name[i] =  p_name[i];
  }
  if( p_name[i] == '.' ) {
    i++;
    for( j = 0; (j < 3) && (p_name[i + j] != 0) && (p_name[i + j] != '.'); j++ ) {
      p_fcb->ext[j] =  p_name[i + j] ;
    }
  }
}

int putchar (int character)
{
    __asm
    ld      hl, #2 
    add     hl, sp   ;Bypass the return address of the function 
    ld     a, (hl)

    ld     iy,(#BIOS_EXPTBL-1)       ;BIOS slot in iyh
    push ix
    ld     ix,#BIOS_CHPUT       ;address of BIOS routine
    call   BIOS_CALSLT          ;interslot call
    pop ix
    __endasm;

    return character;
}

int main(char *argv[], int argc)
{   
    uint8_t slot=0;
    uint8_t argnr=0;
    printf ("MSXUSB Flash Loader 1.0\r\n");
    printf ("(c) 2024 The Retro Hacker\r\n");
    printf ("Based on the original code by S0urceror\r\n\r\n");
    if (argc < 1)
    {
        printf ("FLASH.COM [flags] [romfile]\r\n\r\nOptions:\r\n/S0 - skip detection and select slot 0\r\n/S1 - skip detection and select slot 1\r\n/S2 - skip detection and select slot 2\r\n/S3 - skip detection and select slot 3\r\n");
        return (0);
    }
    if (ReadSP ()<(0x8000+SEGMENT_SIZE))
    {
        printf ("Not enough memory to read file segment");
        return (0);
    }
    if (strcmp (argv[0],"/S0")==0) {
        slot = 0;argnr++;
    } 
    if (strcmp (argv[0],"/S1")==0) {
        slot = 1;argnr++;
    } 
    if (strcmp (argv[0],"/S2")==0) {
        slot = 2;argnr++;
    } 
    if (strcmp (argv[0],"/S3")==0) {
        slot = 3;argnr++;
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
   
    // files
    FCB fcb;
    FCB fcb1;

    FT_SetName (&fcb,argv[argnr]);
    if(fcb_open( &fcb ) != FCB_SUCCESS) 
    {
        printf ("Error: opening file\r\n");
        return (0);   
    }
    printf ("Opened: %s\r\n",argv[0]);

    // for some reazon fcb.file_size is always zero in fusion-c 1.2 (and with fusion-c 1.3)
    // using an alternative method to get the rom file size
    // get ROM size
    // Digging into the problem it looks like the issue only arises with larger files (over 32KB), for small files the FCB.file_size is correct
    unsigned long romsize_test = fcb.file_size;
    printf ("Filesize from fusion-c is %lu bytes\r\n",romsize_test);

    // calculate ROM size manually due to the fusion-c bug with FCB.file_size
    unsigned long romsize = 0;
    int bytes_read = 0;

    while (1)
    {
        MemFill(file_segment, 0xff, SEGMENT_SIZE);
        bytes_read = fcb_read(&fcb, file_segment, SEGMENT_SIZE);
        romsize += bytes_read;

        if (bytes_read < SEGMENT_SIZE)
        {
            break; // EOF reached
        }
    }

    // Reset file pointer to the beginning
    fcb_close(&fcb);

    printf("Filesize is %ld bytes\r\n", romsize);

    // also noticed that we need a second FCB file as fusion-c is returning zero bytes when trying to read from the
    // file descriptor we used before to calculate size :(
    FT_SetName (&fcb1,argv[argnr]);
    if (fcb_open(&fcb1) != FCB_SUCCESS)
    {
        printf("Error: reopening file\r\n");
        return (0);
    }

    // erase flash sectors
    float endsector = romsize;
    endsector = endsector / 65536;
    endsector = ceilf (endsector);
    if (!erase_flash_sectors (slot,0,(uint8_t)endsector)) // 64Kb sectors
        return (0); 
    
    // read file from beginning to end and write to flash
    unsigned long total_bytes_written = 0;
    uint8_t segmentnr = 0;
    // while we haven't written the entire file
    while ( total_bytes_written < romsize) 
    {
        // read 8k segment
        MemFill (file_segment,0xff,SEGMENT_SIZE);
        bytes_read = fcb_read( &fcb1, file_segment,SEGMENT_SIZE);
        //printf ("Reading %d bytes, segment %d\r\n",bytes_read,segmentnr);

        // check if we read something
        if (bytes_read > 0) {
            // Gauge display (20 chars) - weird behavior with mode 40 that still needs investigation
            int progress = (int)((total_bytes_written + bytes_read) * 20 / romsize); // Scale to 20 chars
            printf("[%-20s] %ld/%ld \r", "####################" + (20 - progress), total_bytes_written + bytes_read, romsize); // write 8k segment (or partial segment)
            
            // write 8k segment (or partial segment)
            if (!write_flash_segment(slot, segmentnr))
                break;

            // update counters
            total_bytes_written += bytes_read;
            segmentnr++;
        }
        else
        {
            printf("Error reading file or end of file reached\r\n");
            break;
        }
        
    }

    // close file
    printf("\nWrite operation complete!\r\n");
    fcb_close (&fcb1);
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

// select ram slot 40
void select_ramslot_40 ()
{
    __asm
    ld	a,(#0xf342) ; RAMAD1
	ld	h,#0x40
	jp	0x24 ; ENASLT
    __endasm;
}

// flash identification
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
    //printf ("M: %x, D: %x\r\n",manufacturer,device);
    
    // The following flash chips are supported:
    // AMD_AM29F040 = A4
    // SST_SST39SF040 = B7
    // AMIC_A29040B = 86
    // AMD_AM29F010 = 20
    // AMD_29F002B = 2F

    // check if flash is supported
    switch (device) {
        case 0xA4:
            printf("Found device: AMD_AM29F040\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        case 0xB7:
            printf("Found device: SST_SST39SF040\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        case 0x86:
            printf("Found device: AMIC_A29040B\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        case 0x20:
            printf("Found device: AMD_AM29F010\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        case 0x2F:
            printf("Found device: AMD_29F002B\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        default:
            return FALSE;
    }
    
}

// find flash
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

void print_hex_buffer (uint8_t* start, uint8_t* end)
{
    char str[3];
    uint8_t* cur = start;
    uint8_t cnt=0;
    while (cur<end)
    {
        char hex[]="0\0\0";
        uint8_t len = sprintf (str,"%x",*cur);
        if (len<2)
        {
            strcat (hex,str);
            printf (hex);
        }
        else
            printf (str);
        
        cur++;
        cnt++;
        if ((cnt%8)==0)
            printf ("\r\n");
    }
}

BOOL erase_flash_sectors (uint8_t slot,uint8_t sector_start,uint8_t sector_end)
{
    // select flash in slot
    select_slot_40 (slot);
    // main loop
    int i;
    for (i=sector_start;i<sector_end;i++)
    {
        printf ("Erasing sector: %d\r\n",i);
        // select start segment in sector
        flash_segment[0x1000] = i*8;
        // debug purposes
        // print_hex_buffer (flash_segment, flash_segment+16);
        // write autoselect code
        flash_segment[0x555] = 0xaa;
        flash_segment[0x2aa] = 0x55;
        flash_segment[0x555] = 0x80;
        flash_segment[0x555] = 0xaa;
        flash_segment[0x2aa] = 0x55;
        flash_segment[0] = 0x30;
        // check if ready
        if (!flash_command_okay (0,0xff))
        {
            // reset
            flash_segment[0] = 0xf0;
            printf ("Error erasing sector: %d, segment: %d\r\n",i,i*8);
            break;   
        }
        // debug purposes
        // print_hex_buffer (flash_segment, flash_segment+16);
    }
    // select ram in slot
    select_ramslot_40 ();
    if (i<sector_start)
        return FALSE;
    else
        return TRUE;
}
BOOL flash_command_okay (uint16_t address,uint8_t expected_value)
{
    uint8_t value=0;
    while (TRUE)
    {
        value = flash_segment[address];
        if (value==expected_value)
            return TRUE;
        if ((value & 0x20) != 0)
            break;
    }
    value = flash_segment[address];
    if (value==expected_value)
        return TRUE;
    else
    {
        printf ("=> address: %x, value: %x, response: %x\r\n",address,expected_value,value);
        return FALSE;
    }
}
BOOL write_flash_segment (uint8_t slot,uint8_t segment)
{
    // select flash in slot
    select_slot_40 (slot);
    // select segment
    flash_segment[0x1000] = segment;
    // debug purposes
    // print_hex_buffer (flash_segment, flash_segment+16);
    // write 8k bytes from 0x8000 to 0x4000
    int i;
    for (i=0;i<(8*1024);i++)
    {
        // write autoselect code
        flash_segment[0x555] = 0xaa;
        flash_segment[0x2aa] = 0x55;
        flash_segment[0x555] = 0xa0;
        flash_segment[i] = file_segment[i];
        // check if ready
        if (i>=0x1000) // addresses 0x5000 to 0x5fff
            flash_segment[0x1000] = segment; // necessary to switch back
        if (!flash_command_okay (i,file_segment[i]))
        {
            printf ("Error writing byte: %x in segment: %d\r\n",i,segment);
            break;   
        }
    }

    // debug purposes
    // print_hex_buffer (flash_segment, flash_segment+16);
    // select ram in slot
    select_ramslot_40 ();

    if (i<(8*1024))
        return FALSE;
    else
        return TRUE;
}