// Simple loopback test
// Receive bits and loop them back to the input, but with case inverted

module top
(
	input clk,

	input uart_rx,
	output uart_tx,

	output [7:0] leds

)
