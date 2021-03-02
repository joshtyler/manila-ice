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

);

	// For now our test has exactly the same ports as the test harness(!)
	arp_engine_harness_with_mac inst (.*);

	always_ff @(posedge eth_gtxclk)
		if(eth_txen)
			leds <= eth_txd;


endmodule
