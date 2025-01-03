CC = sdcc
ASM = sdasz80
PLATFORM = -mz80
HEXBIN = hex2bin

FUSIONINC = /DevArea/libraries/fusion-c/include
FUSIONHEADER = /DevArea/libraries/fusion-c/header
FUSIONLIBDIR = /DevArea/libraries/fusion-c/lib
FUSIONLIB = $(FUSIONLIBDIR)/fusion.lib


SRCDIR = src
BINDIR = dist

CRT0 = $(FUSIONINC)\crt0_msxdos_advanced.rel
ADDR_CODE = 0x0180
#CRT0 = $(FUSIONINC)/crt0_msxdos.rel
#ADDR_CODE = 0x106
ADDR_DATA = 0x0

VERBOSE = --verbose
CCFLAGS = $(VERBOSE) --code-loc $(ADDR_CODE) --data-loc $(ADDR_DATA) --use-stdout --disable-warning 196 --no-std-crt0 --opt-code-size  
SOURCES = hello.c
OUTFILE = hello.com

.PHONY: all compile package clean

all: clean compile package

compile: $(SOURCES)

%.c:
		@echo "Compiling $@"
		$(CC) $(CCFLAGS) $(PLATFORM) ${CRT0} $(FUSIONLIB) -L $(FUSIONLIBDIR) -I $(FUSIONHEADER) $(SRCDIR)/$@ -o $(BINDIR)/$(notdir $(@:.c=.ihx))

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