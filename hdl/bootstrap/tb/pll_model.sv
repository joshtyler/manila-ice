module pll(
	input  clock_in,
	output clock_out,
	output locked
	);

// Stupid PLL model...
assign clock_out = clock_in;
assign locked = 1;

endmodule
