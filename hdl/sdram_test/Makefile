SYNTH_OUTPUT_NAME = sdram_test
PACKAGE = tq144:4k

SRC_DIR = ./src
HDL_COMMON_DIR = ../hdl_common
HDL_COMMON_SYNTH_DIR = $(HDL_COMMON_DIR)/synth

HDL_SRC_FILES += $(SRC_DIR)/top.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/reset_gen.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_fifo.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_register.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_width_converter.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_rx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_tx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/cdc_sync.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/serial_wb_master.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/wb_sdram.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/wb_sdram_controller.sv

SYNTH_HDL_TOP = $(SRC_DIR)/top.sv

PCF_FILE = ../pins.pcf
CLOCK_CONSTRAINTS_FILE = $(SRC_DIR)/clk.py

include $(HDL_COMMON_DIR)/other/ice40_rules.mk

.PHONY: prog
prog : $(SYNTH_OUTPUT_NAME).bin
	manila prog $^
