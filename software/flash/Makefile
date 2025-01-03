CC = sdcc
ASM = sdasz80
PLATFORM = -mz80
HEXBIN = hex2bin

FUSIONINC = /DevArea/libraries/fusion-c/include
FUSIONHEADER = /DevArea/libraries/fusion-c/header
FUSIONLIBDIR = /DevArea/libraries/fusion-c/lib
FUSIONLIB = $(FUSIONLIBDIR)\fusion_min_printf.lib
#FUSIONLIB = $(FUSIONLIBDIR)/fusion.lib
SRCDIR = src
BINDIR = dist

# See startup files for the correct ADDR_CODE and ADDR_DATA
CRT0 = $(FUSIONINC)\crt0_msxdos_advanced.rel
ADDR_CODE = 0x0180
#ADDR_DATA = 0
#CRT0 = $(FUSIONINC)/crt0_msxdos.rel
#ADDR_CODE = 0x0106
ADDR_DATA = 0x0

VERBOSE = --verbose 
CCFLAGS = $(VERBOSE) --code-loc $(ADDR_CODE) --data-loc $(ADDR_DATA) --disable-warning 196 --no-std-crt0 --opt-code-size  
SOURCES = flash.c
OUTFILE = flash.com

.PHONY: all compile package clean

all: clean compile package

compile: $(SOURCES)

%.c:
		@echo "Compiling $@"
		$(CC) $(CCFLAGS) $(PLATFORM) $(FUSIONLIB) ${CRT0} -L $(FUSIONLIBDIR) -I $(FUSIONHEADER) $(SRCDIR)/$@ -o $(BINDIR)/$(notdir $(@:.c=.ihx))

package: 
		@echo "Building $(OUTFILE)..."
		@$(HEXBIN) -e com $(BINDIR)/$(basename $(OUTFILE)).ihx
		@echo "Done."

clean:
		@echo "Cleaning ...."
		rm -f $(BINDIR)/*.asm $(BINDIR)/*.bin $(BINDIR)/*.cdb $(BINDIR)/*.ihx $(BINDIR)/*.lk $(BINDIR)/*.lst \
			$(BINDIR)/*.map $(BINDIR)/*.mem $(BINDIR)/*.omf $(BINDIR)/*.rst $(BINDIR)/*.rel $(BINDIR)/*.sym \
			$(BINDIR)/*.noi $(BINDIR)/*.hex $(BINDIR)/*.lnk $(BINDIR)/*.dep
		rm -f $(BINDIR)/$(OUTFILE)

test:
	@echo $(BINDIR)\$(basename $(OUTFILE)).ihx