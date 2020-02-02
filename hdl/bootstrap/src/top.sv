// Application to load new data into SPI flash

module top
(
	input logic clk,

	input logic uart_rx,
	output logic uart_tx,

	output logic [7:0] leds
);

/* verilator lint_off REALCVT */
localparam integer CLK_FREQ = 50e6; // Can't use int'(50e6) because yosys doesn't support
/* verilator lint_on REALCVT */
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

logic uart_rx_tready;
logic uart_rx_tvalid;
logic uart_rx_tlast;
logic [7:0] uart_rx_tdata;

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
	.axis_o_tready(uart_rx_tready),
	.axis_o_tvalid(uart_rx_tvalid),
	.axis_o_tlast(uart_rx_tlast),
	.axis_o_tdata(uart_rx_tdata)
);

wishbone wb();

//logic [wb.BYTES*8-1:0] regs [2**wb.ADDR_BITS-1:0];
//logic [8-1:0] regs [2**8-1:0];

serial_wb_master
#(
	.BYTES(1),
	.ADDR_BITS(8)
) serial_wb_master_inst (
	.clk(clk),
	.sresetn(sresetn),

	.axis_i_tready(uart_rx_tready),
	.axis_i_tvalid(uart_rx_tvalid),
	.axis_i_tlast(uart_rx_tlast),
	.axis_i_tdata(uart_rx_tdata),

	// Output
	.axis_o_tready(uart_tx_tready),
	.axis_o_tvalid(uart_tx_tvalid),
	.axis_o_tlast(),
	.axis_o_tdata(uart_tx_tdata),

	.wb(wb)
);

//logic [(2**8)*1-1:0]  regs;
simple_wb_slave
#(
	.BYTES(1),
	.ADDR_BITS(8)
) wb_slave_inst (
	.clk(clk),
	.sresetn(sresetn),
	.wb(wb),
	.regs(),
	.leds(leds)
);

//assign leds = regs[7:0];

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
