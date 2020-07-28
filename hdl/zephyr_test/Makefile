SYNTH_OUTPUT_NAME = zephyr_test
PACKAGE = tq144:4k

SRC_DIR = ./src
PICORV32_DIR = ./picorv32
HDL_COMMON_DIR = ../hdl_common
HDL_COMMON_SYNTH_DIR = $(HDL_COMMON_DIR)/synth

# Input files
HDL_SRC_FILES += $(SRC_DIR)/top.sv
HDL_SRC_FILES += $(SRC_DIR)/pll.v
HDL_SRC_FILES += $(SRC_DIR)/picosoc.sv
HDL_SRC_FILES += $(PICORV32_DIR)/picosoc/spimemio.v
HDL_SRC_FILES += $(PICORV32_DIR)/picorv32.v
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/reset_gen.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_tx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_rx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/logic_cross_clock.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_register.sv

SYNTH_HDL_TOP = $(SRC_DIR)/top.sv

PCF_FILE = ../pins.pcf
CLOCK_CONSTRAINTS_FILE = $(SRC_DIR)/clk.py

.PHONY: iverilog_sim
iverilog_sim: tb.vvp fw.hex
	vvp -N $< +firmware=fw.hex

tb.vvp: $(HDL_SRC_FILES) $(PICORV32_DIR)/picosoc/spimemio.v $(PICORV32_DIR)/picosoc/spiflash.v tb/zephyr_test_tb.sv
	iverilog -DIVERILOG -g2012 -s zephyr_test_tb -o $@ $^ `yosys-config --datdir/ice40/cells_sim.v`

.PHONY: prog fpga_prog sw_prog
prog : fpga_prog sw_prog
fpga_prog : $(SYNTH_OUTPUT_NAME).bin
	manila prog $^
sw_prog : fw.bin
	manila prog -a 0x00100000 $^

FIRMWARE_DIR = ./firmware
UIP_DIR = ./uip
FIRMWARE_SRCS += $(FIRMWARE_DIR)/start.s
FIRMWARE_SRCS += $(FIRMWARE_DIR)/firmware.c
FIRMWARE_SRCS += $(FIRMWARE_DIR)/string.c
FIRMWARE_SRCS += $(FIRMWARE_DIR)/clock-arch.c
FIRMWARE_SRCS += $(FIRMWARE_DIR)/stdio.c
FIRMWARE_SRCS += $(UIP_DIR)/uip/uip.c
FIRMWARE_SRCS += $(UIP_DIR)/uip/uip_arp.c
FIRMWARE_SRCS += $(UIP_DIR)/uip/uiplib.c
FIRMWARE_SRCS += $(UIP_DIR)/uip/timer.c
FIRMWARE_SRCS += $(UIP_DIR)/uip/psock.c
FIRMWARE_SRCS += $(UIP_DIR)/uip/uip-neighbor.c
FIRMWARE_SRCS += $(UIP_DIR)/apps/hello-world/hello-world.c
fw.elf: $(FIRMWARE_DIR)/sections.lds $(FIRMWARE_SRCS)
	# We should be able to compile with -ffunction-sections -fdata-sections and link with --gc-sections
	# But for some reason this discards everything...
	riscv64-unknown-elf-gcc -I$(FIRMWARE_DIR) -I$(UIP_DIR)/apps/hello-world -I$(UIP_DIR)/uip -mabi=ilp32 -march=rv32imc -Wl,-Bstatic,-T,$(FIRMWARE_DIR)/sections.lds,--strip-debug,-Map=output.map -ffreestanding -nostdlib -o $@ $(filter-out $<,$^)

fw.hex: fw.elf
	riscv64-unknown-elf-objcopy -O verilog $< $@

fw.bin: fw.elf
	riscv64-unknown-elf-objcopy -O binary $< $@

.PHONY: fw_clean
fw_clean:
	rm -f fw.elf fw.hex fw.bin

.PHONY: sim_clean
sim_clean:
	rm -f *.vcd *.vvp

.PHONY: all_clean
all_clean: clean fw_clean sim_clean

include $(HDL_COMMON_DIR)/other/ice40_rules.mk
