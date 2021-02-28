// Test to receive a TCP stream from a PC

`include "axis/axis.h"

module top
(
	input logic clk,

	output logic [7:0] leds,

	input  logic       eth_rxclk,
	input  logic [7:0] eth_rxd,
	input  logic       eth_rxdv,
	input  logic       eth_rxer,
	output logic       eth_gtxclk,
	output logic [7:0] eth_txd,
	output logic       eth_txen,
	output logic       eth_txer,
	output logic       eth_phyrst_n,

	// Debug
	output logic        axis_arp_tx_tready,
	output logic        axis_arp_tx_tvalid,
	output logic        axis_arp_tx_tlast,
	output logic [3:0]  axis_arp_tx_tkeep,
	output logic [31:0] axis_arp_tx_tdata,

	output logic        axis_to_mac_tready,
	output logic        axis_to_mac_tvalid,
	output logic        axis_to_mac_tlast,
	output logic [3:0]  axis_to_mac_tkeep,
	output logic [31:0] axis_to_mac_tdata,

	output logic        axis_to_mac_packetised_tready,
	output logic        axis_to_mac_packetised_tvalid,
	output logic        axis_to_mac_packetised_tlast,
	output logic [3:0]  axis_to_mac_packetised_tkeep,
	output logic [31:0] axis_to_mac_packetised_tdata

);

/*
wire        axis_arp_tx_tready;
wire        axis_arp_tx_tvalid;
wire        axis_arp_tx_tlast;
wire [3:0]  axis_arp_tx_tkeep;
wire [31:0] axis_arp_tx_tdata;

wire        axis_to_mac_tready;
wire        axis_to_mac_tvalid;
wire        axis_to_mac_tlast;
wire [3:0]  axis_to_mac_tkeep;
wire [31:0] axis_to_mac_tdata;

wire        axis_to_mac_packetised_tready;
wire        axis_to_mac_packetised_tvalid;
wire        axis_to_mac_packetised_tlast;
wire [3:0]  axis_to_mac_packetised_tkeep;
wire [31:0] axis_to_mac_packetised_tdata;
*/

	// For now our test has exactly the same ports as the test harness(!)
	arp_engine_harness_with_mac inst (.*);

	always_ff @(posedge eth_gtxclk)
		if(eth_txen)
			leds <= eth_txd;


endmodule
