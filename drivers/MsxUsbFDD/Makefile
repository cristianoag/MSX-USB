SJASM = .\tools\sjasm
DIST_OUTPUT_DIR = .\dist
ROM := $(DIST_OUTPUT_DIR)\USBFDD.rom

all: clean $(ROM)

$(ROM): msxusbfdd.asm
	$(SJASM) $< $(ROM)

clean:
	del /f $(ROM)