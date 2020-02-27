// Application to load new data into SPI flash

module top
(
	input logic clk,

	input logic uart_rx,
	output logic uart_tx,

	output logic [7:0] leds,

	output logic sck,
	output logic ss,
	input logic miso,
	output logic mosi,
	output logic hold,
	output logic wp
);

assign hold = 1;
assign wp = 1;

/* verilator lint_off REALCVT */
localparam integer CLK_FREQ = 50e6; // Can't use int'(50e6) because yosys doesn't support
/* verilator lint_on REALCVT */
localparam integer UART_BAUD_RATE = 2000000;

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

localparam ADDR_BITS = 8;
localparam BYTES = 1;
localparam SEL_WIDTH = 1;
logic [ADDR_BITS-1:0] wb_addr   ;
logic [BYTES*8-1:0]   wb_dat_m2s;
logic [BYTES*8-1:0]   wb_dat_s2m;
logic                 wb_we     ;
logic [SEL_WIDTH-1:0] wb_sel    ;
logic                 wb_stb    ;
logic                 wb_cyc    ;
logic                 wb_ack    ;
logic                 wb_stall  ;

logic [1:0] wb_state;
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

	.m_wb_addr   (wb_addr   ),
	.m_wb_dat_m2s(wb_dat_m2s),
	.m_wb_dat_s2m(wb_dat_s2m),
	.m_wb_we     (wb_we     ),
	.m_wb_sel    (wb_sel    ),
	.m_wb_stb    (wb_stb    ),
	.m_wb_cyc    (wb_cyc    ),
	.m_wb_ack    (wb_ack    ),
	.m_wb_stall  (wb_stall  ),
	.state(wb_state)
);

wb_to_spi_master spi_inst (
	.clk(clk),
	.sresetn(sresetn),
	.s_wb_addr   (wb_addr   ),
	.s_wb_dat_m2s(wb_dat_m2s),
	.s_wb_dat_s2m(wb_dat_s2m),
	.s_wb_we     (wb_we     ),
	.s_wb_sel    (wb_sel    ),
	.s_wb_stb    (wb_stb    ),
	.s_wb_cyc    (wb_cyc    ),
	.s_wb_ack    (wb_ack    ),
	.s_wb_stall  (wb_stall  ),
	.sck(sck),
	.ss(ss),
	.miso(miso),
	.mosi(mosi)
);

always_ff @ (posedge clk)
begin
	if(uart_rx_tvalid)
		leds <= ~uart_rx_tdata;
	//	leds[5:0] <= uart_rx_tdata[5:0];
	//leds[7:6] <= wb_state;
end

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
