// Test Ethernet by looping all traffic back onto itself

module top
(
	input logic        eth_rxclk,
	input logic [7:0]  eth_rxd,
	input logic        eth_rxdv,

	output logic        eth_gtxclk,
	output logic [7:0]  eth_txd,
	output logic        eth_txen,
	output logic        eth_txer,

	output logic       eth_phyrst_n,

	output logic [7:0] leds
);

// This assumes the the phy has negotiated gigabit speeds
// AND that ALL preamble bytes are detected
// AND that nothing ever goes wrong with the link!
// And the flow control is a bit dodgy because it makes (valid) assumptions about the nature of the data
// But is is sufficient to demonstrate the functionality of the ethernet interface

assign eth_gtxclk = eth_rxclk;
assign eth_phyrst_n = 1;
assign eth_txer = 0;

always_ff @(posedge eth_rxclk)
begin
	if(eth_rxdv)
	begin
		leds <= eth_rxd;
	end
end

logic [7:0] dat_reg;
logic valid_reg;

logic sresetn;

reset_gen #(.POLARITY(0)) reset_gen (.clk(eth_rxclk), .en(1), .sreset(sresetn));


// Delay data and valid by one cycle
// This lets us use the invalid signal as a last
always_ff @ (posedge eth_rxclk)
begin
	dat_reg   <= eth_rxd;
	valid_reg <= eth_rxdv;
end

logic       axis_inbetween_ready;
logic       axis_inbetween_valid;
logic       axis_inbetween_last;
logic [7:0] axis_inbetween_data;

logic       axis_preamble_ready;
logic       axis_preamble_valid;
logic       axis_preamble_last;
logic [7:0] axis_preamble_data;

logic dummy_ready;


// Add some preamble bytes to the received data, in case we lost some when receiving
vector_to_axis
#(
	.VEC_BYTES(5),
	.AXIS_BYTES(1)
) vector_to_axis_inst (
	.clk(eth_rxclk),
	.sresetn(sresetn),

	.vec(40'hAAAAAAAAAA),

	.axis_tready(axis_preamble_ready),
	.axis_tvalid(axis_preamble_valid),
	.axis_tlast(axis_preamble_last),
	.axis_tdata(axis_preamble_data)
);

axis_joiner
#(
	.NUM_STREAMS(2)
) joiner_inst (
	.clk(eth_rxclk),
	.sresetn(sresetn),

	// Input
	.axis_i_tready({dummy_ready, axis_preamble_ready}),
	.axis_i_tvalid({valid_reg, axis_preamble_valid}),
	.axis_i_tlast({!eth_rxdv, axis_preamble_last}),
	.axis_i_tdata({dat_reg, axis_preamble_data}),

	// Output
	.axis_o_tready(axis_inbetween_ready),
	.axis_o_tvalid(axis_inbetween_valid),
	.axis_o_tlast(axis_inbetween_last),
	.axis_o_tdata(axis_inbetween_data)
);


axis_packet_fifo fifo
(
	.clk(eth_rxclk),
	.sresetn(sresetn),

	.axis_i_tready(axis_inbetween_ready),
	.axis_i_tvalid(axis_inbetween_valid),
	.axis_i_tlast(axis_inbetween_last),
	.axis_i_tdata(axis_inbetween_data),

	.axis_o_tready(1'b1),
	.axis_o_tvalid(eth_txen),
	.axis_o_tlast(),
	.axis_o_tdata(eth_txd)
);


endmodule
