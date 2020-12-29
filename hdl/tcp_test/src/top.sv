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
	output logic       eth_phyrst_n

);

	logic sresetn;
	reset_gen #(.POLARITY(0), .COUNT(32767)) reset_gen (.clk(clk), .en('1), .sreset(sresetn));



		logic eth_resetn;
		reset_gen #(.POLARITY(0), .COUNT(32767)) eth_reset_gen (.clk(eth_rxclk), .en('1), .sreset(eth_resetn));
		assign eth_gtxclk = eth_rxclk;
		assign eth_phyrst_n = 1;
		assign eth_txer = 0;

endmodule
