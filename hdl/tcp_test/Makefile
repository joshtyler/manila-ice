SYNTH_OUTPUT_NAME = tcp_test
PACKAGE = tq144:4k

SRC_DIR = ./src
HDL_COMMON_DIR = ../hdl_common
HDL_COMMON_SYNTH_DIR = $(HDL_COMMON_DIR)/synth

HDL_INC_DIRS += -I$(HDL_COMMON_SYNTH_DIR)
HDL_INC_DIRS += -I$(HDL_COMMON_SYNTH_DIR)/axis

HDL_SRC_FILES += $(SRC_DIR)/top.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/reset_gen.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/network/tb/arp_engine_harness_with_mac.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/network/gmii_rx_mac_async.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/network/eth_deframer.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/network/arp_engine.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/network/eth_framer.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/network/gmii_tx_mac.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_error_filter_async.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_header_tagger.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_width_converter.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_joiner.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_packet_fifo_async.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_register.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/axis/axis_packer.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/simple_dual_port_two_clocks.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/cdc_vector.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/cdc_sync.sv
HDL_SRC_FILES += $(HDL_COMMON_SYNTH_DIR)/other/cdc_pulse.sv


SYNTH_HDL_TOP = $(SRC_DIR)/top.sv

PCF_FILE = ../pins.pcf
CLOCK_CONSTRAINTS_FILE = $(SRC_DIR)/clk.py

include $(HDL_COMMON_DIR)/other/ice40_rules.mk

.PHONY: prog
prog : $(SYNTH_OUTPUT_NAME).bin
	manila prog $^
