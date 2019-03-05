PLATFORM = TI84p
BINDIR = ../build/bin
AS = $(BINDIR)/scas
EMU = $(BINDIR)/z80e-sdl
GENKFS = $(BINDIR)/genkfs
INCLUDE = ../kernel/bin/include
KERNEL = ../$(PLATFORM).rom

.PHONY: all
all: debug.rom

hello.bin: main.asm
	$(AS) --include $(INCLUDE) $< $@

root/bin/init: hello.bin
	mkdir -p root/bin
	cp $< $@
	
debug.rom: $(KERNEL) root/bin/init
	cp $< $@
	$(GENKFS) $@ root
	
.PHONY: run
run: debug.rom
	$(EMU) -d $(PLATFORM) $<
