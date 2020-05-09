// Simple loopback test
// Receive bits and loop them back to the input, but with case inverted

module loopback_test
(
	input logic clk,

	input logic uart_rx,
	output logic uart_tx,

	output logic [7:0] leds,
	output logic eth_phyrst_n
);

localparam integer CLK_FREQ = $rtoi(50e6);
localparam integer UART_BAUD_RATE = 9600;

// Generate a power on reset
logic sresetn;
reset_gen #(.POLARITY(0)) reset_gen (.clk(clk), .en(1), .sreset(sresetn));


// Turn ethernet phy on
assign eth_phyrst_n  = 1;

// UARTs
logic parallel_data_valid;
logic[7:0] parallel_data;
uart_rx
#(
	.CLK_FREQ(CLK_FREQ),
	.BAUD_RATE(UART_BAUD_RATE)
) uart_rx_inst (
	.clk(clk),
	.sresetn(sresetn),

	.serial_data(uart_rx),

	.parallel_data_valid(parallel_data_valid),
	.parallel_data(parallel_data)
);

// Display last received byte on LEDs
logic [7:0] parallel_data_latch;
always_ff @(posedge clk)
begin
	if(!sresetn)
	begin
		parallel_data_latch <= 0;
	end else if(parallel_data_valid) begin
		parallel_data_latch <= parallel_data;
	end
end

// Make the top LED blink
logic [24:0] ctr;
always_ff @(posedge clk)
begin
	ctr <= ctr + 1;
end
assign leds = { ctr[24], parallel_data_latch[6:0] };

logic uart_tx_tready;
logic uart_tx_tvalid;
logic [7:0] uart_tx_tdata;

axis_fifo
#(
	.AXIS_BYTES(1),
	.DEPTH(1024)
) fifo_inst (
	.clk(clk),
	.sresetn(sresetn),

	.axis_i_tready(), // If it fills up we will just drop data
	.axis_i_tvalid(parallel_data_valid),
	.axis_i_tlast(1),
	.axis_i_tdata(parallel_data),
	.axis_i_tuser(1'b0),

	// Output
	.axis_o_tready(uart_tx_tready),
	.axis_o_tvalid(uart_tx_tvalid),
	.axis_o_tlast(),
	.axis_o_tdata(uart_tx_tdata),
	.axis_o_tuser()
);

uart_tx
#(
	.CLK_FREQ(CLK_FREQ),
	.BAUD_RATE(UART_BAUD_RATE)
) uart_tx_inst (
	.clk(clk),
	.sresetn(sresetn),

	.serial_ready(1'b1),

	.serial_data(uart_tx),

	.s_axis_tready(uart_tx_tready),
	.s_axis_tvalid(uart_tx_tvalid),
	.s_axis_tdata(uart_tx_tdata)
);

endmodule
