// Application to load new data into SPI flash

module top
(
	input logic clk_raw,

	input  logic uart_rx,
	output logic uart_tx,
	input  logic rts_n,
	output logic cts_n,

	output logic [7:0] leds,

	output logic sck,
	output logic ss,
	input logic miso,
	output logic mosi,

	input logic wp_n, // Not used for write proect. Used to enable/disable protection

	output logic [7:0] pmod1
);

/* verilator lint_off REALCVT */
localparam integer CLK_FREQ = 50e6; // Can't use int'(50e6) because yosys doesn't support
/* verilator lint_on REALCVT */
localparam integer UART_BAUD_RATE = 460800;

// Generate a power on reset
logic sresetn;

// Nice long reset to ensure the SPI pins are available for us to use
reset_gen #(.POLARITY(0), .COUNT(32767)) reset_gen (.clk(clk), .en(1), .sreset(sresetn));

logic clk;
assign clk = clk_raw;
//pll pll_inst (.clock_in(clk_raw), .clock_out(clk), .locked());


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
logic [7:0] uart_rx_tdata;

logic uart_tx_tready;
logic uart_tx_tvalid;
logic [7:0] uart_tx_tdata;

// Our FIFO is sufficiently deep that we are always ready to recieve
// In the future we should tie this to a FIFO nearly full line
assign cts_n = 0;
axis_fifo
#(
	.AXIS_BYTES(1),
	.DEPTH(1024)
) fifo_inst (
	.clk(clk),
	.sresetn(sresetn),

	.axis_i_tready(),
	.axis_i_tvalid(parallel_data_valid),
	.axis_i_tlast(1),
	.axis_i_tdata(parallel_data),

	// Output
	.axis_o_tready(uart_rx_tready),
	.axis_o_tvalid(uart_rx_tvalid),
	.axis_o_tlast(),
	.axis_o_tdata(uart_rx_tdata)
);

// Mux between the boot_manager axis_protect, and the data from the user
logic axis_protect_tready;
logic axis_protect_tvalid;
logic [7:0]  axis_protect_tdata;
logic axis_protect_done;

logic axis_wb_in_tready;
logic axis_wb_in_tvalid;
logic [7:0]  axis_wb_in_tdata;

assign axis_wb_in_tvalid   = axis_protect_done? uart_rx_tvalid    : axis_protect_tvalid;
assign axis_wb_in_tdata    = axis_protect_done? uart_rx_tdata     : axis_protect_tdata ;
assign uart_rx_tready      = axis_protect_done? axis_wb_in_tready : 0                  ;
assign axis_protect_tready = axis_protect_done? 0                 : axis_wb_in_tready  ;

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


serial_wb_master
#(
	.BYTES(1),
	.ADDR_BITS(8)
) serial_wb_master_inst (
	.clk(clk),
	.sresetn(sresetn),

	.axis_i_tready(axis_wb_in_tready),
	.axis_i_tvalid(axis_wb_in_tvalid),
	.axis_i_tlast(0),
	.axis_i_tdata(axis_wb_in_tdata),

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
	.m_wb_stall  (wb_stall  )
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

/*
always_ff @ (posedge clk)
begin
	if(uart_rx_tvalid)
		leds <= uart_rx_tdata;
end
*/

uart_tx
#(
	.CLK_FREQ(CLK_FREQ),
	.BAUD_RATE(UART_BAUD_RATE)
) uart_tx_inst (
	.clk(clk),
	.sresetn(sresetn),

	.serial_ready(!rts_n),
	.serial_data(uart_tx),

	.s_axis_tready(uart_tx_tready),
	.s_axis_tvalid(uart_tx_tvalid && axis_protect_done), // Discard the data resulting from our memory protection
	.s_axis_tdata(uart_tx_tdata)
);


// Enable the internal pullup on the wp_n pin by manually instantiating the IO
logic enable_protection;
`ifdef VERILATOR
assign enable_protection = wp_n;
`else
SB_IO
#(
	.PIN_TYPE(6'b0000_01), // Simple input pin, no output capability
	.PULLUP(1), // Enable pullup. Only available on banks 0,1,and 2
	//.NEG_TRIGGER(0), // Unused
	//.IO_STANDARD("SB_LVCMOS")
) protect_io_inst (
	.PACKAGE_PIN(wp_n),
	//.LATCH_INPUT_VALUE(0), // Not Used
	//.CLOCK_ENABLE(0), // No clock
	//.INPUT_CLK(0), // No clock
	//.OUTPUT_CLK(0), // No clock
	//.OUTPUT_ENABLE(0), // Input only
	//.D_OUT_0(0), // Input only
	//.D_OUT_1(0), // Input only
	.D_IN_0(enable_protection),
	//.D_IN_1()
);
`endif

logic reboot;
boot_manager boot_manager_inst (
		.clk(clk),
		.sresetn(sresetn),

		.uart_rx_valid(parallel_data_valid),

		.enable_protection(enable_protection),

		.reboot(reboot),

		.leds(leds),

		.m_axis_protect_tready(axis_protect_tready),
		.m_axis_protect_tvalid(axis_protect_tvalid),
		.m_axis_protect_tdata(axis_protect_tdata),
		.axis_protect_done(axis_protect_done)
);

`ifndef VERILATOR
SB_WARMBOOT warmboot (
	.BOOT(reboot),
	.S0(1),
	.S1(0)
);
`endif

assign pmod1[0] = axis_protect_tvalid;
assign pmod1[2] = axis_protect_done;
assign pmod1[4] = axis_protect_tdata[0];
assign pmod1[6] = axis_protect_tdata[1];
assign pmod1[7] = sresetn;

assign pmod1[1] = 0;
assign pmod1[3] = 0;
assign pmod1[5] = 0;


endmodule
