SYNTH_OUTPUT_NAME = bootstrap
PACKAGE = tq144:4k

SRC_DIR = ./src
HDL_COMMON_DIR = ../hdl_common
HDL_COMMON_SYNTH_DIR = $(HDL_COMMON_DIR)/synth

HDL_SRC_FILES += $(SRC_DIR)/top.sv
HDL_SRC_FILES += $(SRC_DIR)/pll.sv
HDL_SRC_FILES += $(SRC_DIR)/boot_manager.sv
HDL_SRC_FILES += $(SRC_DIR)/unlocker.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/reset_gen.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/fifo.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_fifo.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_register.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_spi_bridge.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/rom_to_axis.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/vector_to_axis.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_width_converter.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_spacer.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_rx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/uart_tx.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/logic_cross_clock.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/debouncer.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/serial_wb_master.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/simple_wb_slave.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/wb_to_spi_master.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/wb_axis_bridge.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/wishbone/wb_interconnect.sv

SYNTH_HDL_TOP = $(SRC_DIR)/top.sv
SIM_HDL_TOP   = $(SRC_DIR)/top.sv

SIM_CPP_SRC_FILES += tb/test_bootstrap.cpp
PCF_FILE = $(SRC_DIR)/pins.pcf
CLOCK_CONSTRAINTS_FILE = $(SRC_DIR)/clk.py

VERILATOR_CFLAGS += -Wall -Wextra -g -I../../hdl_common/sim

include $(HDL_COMMON_DIR)/other/ice40_rules.mk
