// Test SDRAM

module top
(
	input logic clk,

	input  logic uart_rx,
	output logic uart_tx,

	output logic [7:0] leds,

	output logic        sdram_clk,
	output logic        sdram_cke,
	output logic        sdram_cs_n,
	output logic        sdram_ras_n,
	output logic        sdram_cas_n,
	output logic        sdram_we_n,
	output logic [1:0]  sdram_bs,
	output logic [11:0] sdram_addr,
	inout  logic [15:0] sdram_data,
	output logic [1:0]  sdram_dqm
);


/* verilator lint_off REALCVT */
localparam integer CLK_FREQ = 50e6; // Can't use int'(50e6) because yosys doesn't support
/* verilator lint_on REALCVT */
localparam integer UART_BAUD_RATE = 460800;

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

// Our FIFO is sufficiently deep that we are always ready to recieve
// In the future we should tie this to a FIFO nearly full line
axis_fifo
#(
	.AXIS_BYTES(1),
	.LOG2_DEPTH(10)
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
	.axis_o_tlast(uart_rx_tlast),
	.axis_o_tdata(uart_rx_tdata)
);

localparam WB_ADDR_BITS = 23;
localparam WB_BYTES = 2;
localparam SEL_WIDTH = 1;
logic [WB_ADDR_BITS-1:0] wb_addr   ;
logic [WB_BYTES*8-1:0]   wb_dat_m2s;
logic [WB_BYTES*8-1:0]   wb_dat_s2m;
logic                 wb_we     ;
logic                 wb_stb    ;
logic                 wb_cyc    ;
logic                 wb_ack    ;
logic                 wb_stall  ;


serial_wb_master
#(
	.BYTES(WB_BYTES),
	.ADDR_BITS(WB_ADDR_BITS)
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
	.m_wb_sel    (),
	.m_wb_stb    (wb_stb    ),
	.m_wb_cyc    (wb_cyc    ),
	.m_wb_ack    (wb_ack    ),
	.m_wb_stall  (wb_stall  )
);

// N.B We are casually discarding most of the data here!
// wbsdram uses 32-bit wide data bus
// Also naturally a wider address bus
logic        sdram_drive_data;
logic [15:0] sdram_data_out;
wb_sdram sdram_inst (
	.clk(clk),
	.sresetn(sresetn),

	.s_wb_stb   (wb_stb),
	.s_wb_we    (wb_we),
	.s_wb_addr  (wb_addr),
	.s_wb_dat_m2s  (wb_dat_m2s),
	.s_wb_ack   (wb_ack),
	.s_wb_stall (wb_stall),
	.s_wb_dat_s2m (wb_dat_s2m),

	.ram_cke   (sdram_cke),
	.ram_cs_n  (sdram_cs_n),
	.ram_ras_n (sdram_ras_n),
	.ram_cas_n (sdram_cas_n),
	.ram_we_n  (sdram_we_n),
	.ram_bs    (sdram_bs),
	.ram_a     (sdram_addr),
	.ram_dq_oe (sdram_drive_data),
	.ram_dq_i  (sdram_data),
	.ram_dq_o  (sdram_data_out),
	.ram_dqm   (sdram_dqm)
);
assign sdram_data = sdram_drive_data ? sdram_data_out : 'z;
assign sdram_clk = clk;
always_ff @ (posedge clk)
begin
	if(uart_tx_tvalid)
	begin
		leds <= uart_tx_tdata;
		//leds[7] <= 1;
	end
end

uart_tx
#(
	.CLK_FREQ(CLK_FREQ),
	.BAUD_RATE(UART_BAUD_RATE)
) uart_tx_inst (
	.clk(clk),
	.sresetn(sresetn),

	.serial_ready(1),
	.serial_data(uart_tx),

	.s_axis_tready(uart_tx_tready),
	.s_axis_tvalid(uart_tx_tvalid),
	.s_axis_tdata(uart_tx_tdata)
);


endmodule
