# This file is adapted from project icestorm example
# It is licensed under the ISC license:

#  Permission to use, copy, modify, and/or distribute this software for any
#  purpose with or without fee is hereby granted, provided that the above
#  copyright notice and this permission notice appear in all copies.
#
#  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


# Constants
SRC_DIR = ./src
PROJ = top
DEVICE = 8k
PACKAGE = tq144:4k

COMMON_SYNTH_DIR = ../hdl_common/synth

# Input files
SRC_FILES += $(COMMON_SYNTH_DIR)/wishbone/wishbone.sv
SRC_FILES += $(SRC_DIR)/pll.sv
SRC_FILES += $(SRC_DIR)/top.sv
SRC_FILES += $(SRC_DIR)/boot_manager.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/other/reset_gen.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/other/fifo.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/axis/axis_fifo.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/axis/axis_register.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/axis/axis_spi_bridge.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/axis/rom_to_axis.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/other/uart_rx.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/other/uart_tx.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/other/logic_cross_clock.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/wishbone/serial_wb_master.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/wishbone/simple_wb_slave.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/wishbone/wb_to_spi_master.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/wishbone/wb_axis_bridge.sv
SRC_FILES += $(COMMON_SYNTH_DIR)/wishbone/wb_interconnect.sv

PCF_FILE = $(SRC_DIR)/pins.pcf

.PHONY: all
all: $(PROJ).rpt $(PROJ).bin multi.bin

%.json: $(SRC_FILES)
	@echo "Begin synthesis"
#	yosys -p "synth_ice40; delete t:$$assert; write_json $(PROJ).json" $(SRC_FILES) > yosys.log
	yosys -p "synth_ice40 -json $(PROJ).json" $(SRC_FILES) > yosys.log
	@echo "Yosys warnings:"
	@cat yosys.log | grep -in "warning"

%.asc: $(PCF_FILE) %.json
	@echo "Begin pnr"
	nextpnr-ice40 --hx8k --package $(PACKAGE) --json $(PROJ).json --pcf $(PCF_FILE) --asc $(PROJ).asc --pre-pack ./src/clk.py

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d hx$(DEVICE) -mtr $@ $<

prog: $(PROJ).bin
	iceprog $<

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).rpt $(PROJ).bin yosys.log multi.bin

# Icemulti makes us have the images we want to boot to ready
# These files let us fake it
.INTERMEDIATE: foo bar baz
foo bar baz :
	dd if=/dev/zero of=$@ bs=1 count=1

# 16 address bits aligns us with spi flash pages
# The head command strips out our dummy images
multi.bin: $(PROJ).bin foo bar baz
	icemulti -a 16 $(PROJ).bin foo bar baz | head -c 192K > multi.bin

.SECONDARY:
.PHONY: all clean prog time
