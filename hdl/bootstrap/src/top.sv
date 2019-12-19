// Application to load new data into SPI flash

module top
(
	input logic clk,

	input logic uart_rx,
	output logic uart_tx,

	output logic [7:0] leds
);

localparam integer CLK_FREQ = 12e6;
localparam integer UART_BAUD_RATE = 9600;

// Generate a power on reset
logic sresetn;
reset_gen #(.POLARITY(0)) reset_gen (.clk(clk), .en(1), .sreset(sresetn));


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
always_ff @(posedge clk)
begin
	if(!sresetn)
	begin
		leds <= 0;
	end else if(parallel_data_valid) begin
		leds <= parallel_data;
	end
end

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

	// Output
	.axis_o_tready(uart_tx_tready),
	.axis_o_tvalid(uart_tx_tvalid),
	.axis_o_tlast(),
	.axis_o_tdata(uart_tx_tdata)
);

uart_tx
#(
	.CLK_FREQ(CLK_FREQ),
	.BAUD_RATE(UART_BAUD_RATE)
) uart_tx_inst (
	.clk(clk),
	.sresetn(sresetn),

	.serial_data(uart_tx),

	.s_axis_tready(uart_tx_tready),
	.s_axis_tvalid(uart_tx_tvalid),
	.s_axis_tdata(uart_tx_tdata)
);

endmodule
