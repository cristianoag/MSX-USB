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
; - KonamiSCC ROM file
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

/*
    ; main
    ; input: argv, argc
    ; output: none

    ; This program writes a KonamiSCC ROM to a flash ROM in the MSXUSB cartridge
*/
int main(char *argv[], int argc)
{   
    uint8_t slot=0;
    uint8_t argnr=0;
    printf ("MSXUSB Flash Loader 1.2\r\n");
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
    if (strcmp (argv[0],"/S0")==0 || strcmp (argv[0],"/s0")==0) {
        slot = 0;argnr++;
    } 
    if (strcmp (argv[0],"/S1")==0 || strcmp (argv[0],"/s1")==0) {
        slot = 1;argnr++;
    } 
    if (strcmp (argv[0],"/S2")==0 || strcmp (argv[0],"/s2")==0) {
        slot = 2;argnr++;
    } 
    if (strcmp (argv[0],"/S3")==0 || strcmp (argv[0],"/s3")==0) {
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
   
    // file
    FCB fcb;

    FT_SetName (&fcb,argv[argnr]);
    if(fcb_open( &fcb ) != FCB_SUCCESS) 
    {
        printf ("Error: opening file\r\n");
        return (0);   
    }
    printf ("Opened: %s\r\n",argv[0]);

    unsigned long romsize = fcb.file_size;
    printf("Filesize is %ld bytes\r\n", romsize);

    // erase flash sectors
    float endsector = romsize;
    endsector = endsector / 65536;
    endsector = ceilf (endsector);
    if (!erase_flash (slot)) 
        return (0); 
    
    // read file from beginning to end and write to flash
    unsigned long total_bytes_written = 0;
    uint8_t segmentnr = 0;
    int bytes_read = 0;

    // while we haven't written the entire file
    while ( total_bytes_written < romsize) 
    {
        // read 8k segment
        MemFill (file_segment,0xff,SEGMENT_SIZE);
        bytes_read = fcb_read( &fcb, file_segment,SEGMENT_SIZE);
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
    fcb_close (&fcb);
    return(0);
}

/*
    ; select slot 40
    ; input: slot
    ; output: none
*/
void select_slot_40 (uint8_t slot)
{
    slot;
    __asm
    ld  iy,#2
    add iy,sp       
    ld  a,(iy)      
    ld  h,#0x40
    jp	0x24 
    __endasm;
}

/*
    ; select ram slot 40
    ; input: none
    ; output: none
*/
void select_ramslot_40 ()
{
    __asm
    ld	a,(#0xf342) ; RAMAD1
	ld	h,#0x40
	jp	0x24 ; ENASLT
    __endasm;
}

void delay() {
    for (volatile int i = 0; i < 1000; i++);
}

void hexdump_flash_segment() {
    for (uint16_t i = 0; i < 32768; i += 24) {
        printf("%04X: ", i);
        for (uint16_t j = 0; j < 24; j++) {
            if (i + j < 32768) {
                printf("%02X ", flash_segment[i + j]);
            } else {
                printf("  ");
            }
        }
        printf("\r\n");
    }
}

/*
    ; flash identification
    ; input: none
    ; output: TRUE if flash is found, FALSE if not
*/
BOOL flash_ident ()
{
    flash_segment[0] = 0xF0;
    
    flash_segment[0x555] = 0xaa;
    flash_segment[0x2aa] = 0x55;
    flash_segment[0x555] = 0x90;

    // read response
    uint8_t manufacturer = flash_segment[0x0000];
    uint8_t device = flash_segment[0x0001];
    
    // debug line to identify new flash chips
   // printf ("M: %x, D: %x\r\n",manufacturer,device);
    
    // The following flash chips are supported:
    // AMC_A29040B = 86
    // AMD_29F040 = A4
    // AMS_29F010 = 20
    // SST_39SF040 = B7 - still not working

    switch (device) {
        case 0x86:
            printf("Found device: AMC_A29040B\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        case 0xA4:
            printf("Found device: AMD_AM29F040\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        case 0x20:
            printf("Found device: AMD_AM29F010\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        case 0xB7:
            printf("Found device: SST_SST39SF040\r\n");
            flash_segment[0] = 0xf0;
            return TRUE;
            break;
        default:
            return FALSE;
    }
    
}

/*
    ; find flash in slot 40
    ; input: none
    ; output: slot number
*/
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

/*
    ; print hex buffer
    ; input: start, end
    ; output: none
*/
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

/*
    ; erase flash chip
    ; input: slot
    ; output: TRUE if successful, FALSE if not

    ; supports the following flash chips:
    ; AMD_AM29F040 = A4
    ; AMD_AM29F010 = 20
*/
BOOL erase_flash(uint8_t slot)
{
    // select flash in slot
    select_slot_40 (slot);

    printf ("Erasing flash: ");
    // sequence to activate the chip erase
    flash_segment[0x555] = 0xaa; //ok
    flash_segment[0x2aa] = 0x55; //ok
    flash_segment[0x555] = 0x80; //ok
    flash_segment[0x555] = 0xaa; //ok
    flash_segment[0x2aa] = 0x55; //ok
    flash_segment[0x555] = 0x10; //ok

    if (!flash_command_okay (0,0xff))
    {
            // reset
            flash_segment[0] = 0xf0;
            printf ("error erasing flash!\r\n");
            return FALSE;
    }

    printf ("done!\r\n");
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