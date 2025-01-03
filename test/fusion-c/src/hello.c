
// FUSION-C 2.0 SDK
// EXAMPLE test file
// HELLO.C

#include <msx_fusion.h>
#include <string.h>
#include <stdio.h>
#include "msxDOS.h"

#define __SDK_MSXVERSION__ 2
#define __SDK_ROM__ 32K

FCB file; // Initialisatio de la structure pour le systeme de fichiers

void FT_SetName(FCB *p_fcb, const char *p_name) 
{
  char i, j;
  memset(p_fcb, 0, sizeof(FCB));
  for (i = 0; i < 11; i++) {
    p_fcb->name[i] = ' ';
  }
  for (i = 0; (i < 8) && (p_name[i] != 0) && (p_name[i] != '.'); i++) {
    p_fcb->name[i] = p_name[i];
  }
  if (p_name[i] == '.') {
    i++;
    for (j = 0; (j < 3) && (p_name[i + j] != 0) && (p_name[i + j] != '.'); j++) {
      p_fcb->ext[j] = p_name[i + j];
    }
  }
}

void FT_errorHandler(char n, char *name) // Gère les erreurs
{
  Screen(0);
  SetColors(15,6,6);
  switch (n)
  {
      case 1:
          Print("\n\rFAILED: fcb_open(): ");
          Print(name);
      break;
 
      case 2:
          Print("\n\rFAILED: fcb_close():");
          Print(name);
      break;  
 
      case 3:
          Print("\n\rStop Kidding, run me on MSX2 !");
      break; 
  }
Exit(0);
}

void main (void)
{
	Screen(0);
	Width(40);
	Print("Hello ! \n\n");
	Print("Your are using FUSION-C \n\rversion:");
	//PrintDec(_FusionVer/10);
	Print("  Rev.");
	//PrintDec(_FusionRev);

  char file_name[] = "nextor.rom";

  FT_SetName( &file, file_name );
  if(fcb_open( &file ) != FCB_SUCCESS) 
    {
      FT_errorHandler(1, file_name);
    }

  printf("\n\r\n\rSize: %lu\n\r",file.file_size);
	WaitKey();
	Exit(0);

}
