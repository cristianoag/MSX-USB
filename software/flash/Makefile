CC = sdcc
ASM = sdasz80
PLATFORM = -mz80
HEXBIN = hex2bin

INCLUDES =  -IC:\DevArea\libraries\fusion-c\header -IC:\DevArea\libraries\fusion-c\include -IC:\DevArea\libraries\asmlib
FUSIONLIB = C:\DevArea\libraries\fusion-c\include
LIBS = "C:\DevArea\libraries\fusion-c\lib\fusion_min_printf.lib" #fusion-c-1.3 minus printf
OBJECTSDIR = C:\DevArea\libraries\fusion-c\include
SRCDIR = src
BINDIR = dist

# See startup files for the correct ADDR_CODE and ADDR_DATA
CRT0 = crt0_msxdos_advanced.rel
ADDR_CODE = 0x0180
#CRT0 = crt0_msxdos.rel
#ADDR_CODE = 0x106
ADDR_DATA = 0

VERBOSE = --verbose -V
CCFLAGS = $(VERBOSE) $(PLATFORM) --code-loc $(ADDR_CODE) --data-loc $(ADDR_DATA) --no-std-crt0 --out-fmt-ihx --legacy-banking
OBJECTS = $(FUSIONLIB)\$(CRT0)
SOURCES = flash.c
OUTFILE = flash.com

.PHONY: all compile link package clean

all: clean compile link package

compile: $(SOURCES)

%.c:
		@echo "Compiling $@"
		$(CC) $(CCFLAGS) $(PLATFORM) $(INCLUDES) -c -o $(BINDIR)\$(notdir $(@:.c=.rel)) $(SRCDIR)\$@ 

link:
		@echo "Linking"
		$(CC) $(CCFLAGS) $(addprefix $(BINDIR)\,$(SOURCES:.c=.rel)) $(LIBS) $(OBJECTS) -o $(BINDIR)\$(basename $(OUTFILE)).ihx

package: 
		@echo "Building $(OUTFILE)..."
		@$(HEXBIN) -e com $(BINDIR)\$(basename $(OUTFILE)).ihx
		@echo "Done."

clean:
		@echo "Cleaning ...."
		del /f $(BINDIR)\*.asm $(BINDIR)\*.bin $(BINDIR)\*.cdb $(BINDIR)\*.ihx $(BINDIR)\*.lk $(BINDIR)\*.lst \
			$(BINDIR)\*.map $(BINDIR)\*.mem $(BINDIR)\*.omf $(BINDIR)\*.rst $(BINDIR)\*.rel $(BINDIR)\*.sym \
			$(BINDIR)\*.noi $(BINDIR)\*.hex $(BINDIR)\*.lnk $(BINDIR)\*.dep
		del /f $(BINDIR)\$(OUTFILE)

test:
	@echo $(BINDIR)\$(basename $(OUTFILE)).ihx