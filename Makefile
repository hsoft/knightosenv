export PATH := $(PATH):$(PWD)/build/bin
export SHELL := env PATH=$(PATH) /bin/bash
PLATFORM := TI84p

.PHONY: all
all: $(addprefix build/bin/, scas z80e-sdl genkfs) $(PLATFORM).rom

build/bin/sass:
	$(MAKE) -C sass DESTDIR=../build PREFIX=$(PWD)/build all install

build/bin/scas:
	cd scas && cmake . -DCMAKE_INSTALL_PREFIX:PATH=/build
	$(MAKE) -C scas DESTDIR=.. install

build/bin/mktiupgrade:
	cd mktiupgrade && cmake . -DCMAKE_INSTALL_PREFIX:PATH=/build
	$(MAKE) -C mktiupgrade DESTDIR=.. install

build/bin/mkrom:
	cd mkrom && cmake . -DCMAKE_INSTALL_PREFIX:PATH=/build
	$(MAKE) -C mkrom DESTDIR=.. install

build/bin/patchrom:
	cd patchrom && cmake . -DCMAKE_INSTALL_PREFIX:PATH=/build
	$(MAKE) -C patchrom DESTDIR=.. install

$(PLATFORM).rom: $(addprefix build/bin/, sass mktiupgrade mkrom patchrom)
	$(MAKE) -C kernel $(PLATFORM)
	cp kernel/bin/$(PLATFORM)/kernel.rom $@

build/bin/z80e-sdl:
	cd z80e && cmake . -DCMAKE_INSTALL_PREFIX:PATH=/build -Denable-sdl=YES
	$(MAKE) -C z80e DESTDIR=.. install

build/bin/genkfs:
	cd genkfs && cmake . -DCMAKE_INSTALL_PREFIX:PATH=/build
	$(MAKE) -C genkfs DESTDIR=.. install

