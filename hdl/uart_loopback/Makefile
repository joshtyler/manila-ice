SYNTH_OUTPUT_NAME = uart_loopback
PACKAGE = tq144:4k

SRC_DIR = ./src
HDL_COMMON_DIR = ../hdl_common
HDL_COMMON_SYNTH_DIR = $(HDL_COMMON_DIR)/synth

# Input files
HDL_SRC_FILES += $(SRC_DIR)/loopback_test.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/logic_cross_clock.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_rx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_tx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/reset_gen.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/fifo.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_fifo.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_register.sv

SYNTH_HDL_TOP = $(SRC_DIR)/loopback_test.sv
SIM_HDL_TOP   = $(SRC_DIR)/loopback_test.sv

SIM_CPP_SRC_FILES += tb/test_loopback_test.cpp
PCF_FILE = $(SRC_DIR)/pins.pcf
CLOCK_CONSTRAINTS_FILE = $(SRC_DIR)/clk.py

VERILATOR_CFLAGS += -Wall -Wextra -g -I../../hdl_common/sim

.PHONY: prog
prog : $(SYNTH_OUTPUT_NAME).bin
	manila prog $^

include $(HDL_COMMON_DIR)/other/ice40_rules.mk
