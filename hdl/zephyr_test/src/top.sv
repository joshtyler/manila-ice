module top (
	input clk,

	output [7:0] leds,

	output spi_sck,
	output spi_ss,
	inout  spi_mosi,
	inout  spi_miso,
	inout  spi_wp_n,
	inout  spi_hold_n,

	output uart_tx,
	input  uart_rx,

	input logic        eth_rxclk,
	input logic [7:0]  eth_rxd,
	input logic        eth_rxdv,
	input logic        eth_rxer,

	output logic        eth_gtxclk,
	output logic [7:0]  eth_txd,
	output logic        eth_txen,
	output logic        eth_txer,

	output logic       eth_phyrst_n
);

	logic clk25;

	logic pll_locked;
	pll pll_inst (.clock_in(clk), .clock_out(clk25), .locked(pll_locked));

	logic resetn;
	reset_gen #(.POLARITY(0), .COUNT(32767)) main_reset_gen (.clk(clk), .en(pll_locked), .sreset(resetn));

	always_ff @(posedge eth_rxclk)
		if(eth_txen)
			leds <= eth_txd;
/*
	wire flash_io0_oe, flash_io0_do, flash_io0_di;
	wire flash_io1_oe, flash_io1_do, flash_io1_di;
	wire flash_io2_oe, flash_io2_do, flash_io2_di;
	wire flash_io3_oe, flash_io3_do, flash_io3_di;

	SB_IO #(
		.PIN_TYPE(6'b 1010_01),
		.PULLUP(1'b 0)
	) flash_io_buf [3:0] (
		.PACKAGE_PIN({spi_hold_n, spi_wp_n, spi_miso, spi_mosi}),
		.OUTPUT_ENABLE({flash_io3_oe, flash_io2_oe, flash_io1_oe, flash_io0_oe}),
		.D_OUT_0({flash_io3_do, flash_io2_do, flash_io1_do, flash_io0_do}),
		.D_IN_0({flash_io3_di, flash_io2_di, flash_io1_di, flash_io0_di})
	);

	wire        iomem_valid;
	reg         iomem_ready;
	wire [3:0]  iomem_wstrb;
	wire [31:0] iomem_addr;
	wire [31:0] iomem_wdata;
	reg  [31:0] iomem_rdata;

	reg [31:0] gpio;
	assign leds = gpio;

	always @(posedge clk25) begin
		if (!resetn) begin
			gpio <= 0;
		end else begin
			iomem_ready <= 0;
			if (iomem_valid && !iomem_ready && iomem_addr[31:24] == 8'h 03) begin
				iomem_ready <= 1;
				iomem_rdata <= gpio;
				if (iomem_wstrb[0]) gpio[ 7: 0] <= iomem_wdata[ 7: 0];
				if (iomem_wstrb[1]) gpio[15: 8] <= iomem_wdata[15: 8];
				if (iomem_wstrb[2]) gpio[23:16] <= iomem_wdata[23:16];
				if (iomem_wstrb[3]) gpio[31:24] <= iomem_wdata[31:24];
			end
		end
	end

	picosoc soc (
		.clk          (clk25         ),
		.resetn       (resetn      ),

		.ser_tx       (uart_tx      ),
		.ser_rx       (uart_rx      ),

		.flash_csb    (spi_ss   ),
		.flash_clk    (spi_sck   ),

		.flash_io0_oe (flash_io0_oe),
		.flash_io1_oe (flash_io1_oe),
		.flash_io2_oe (flash_io2_oe),
		.flash_io3_oe (flash_io3_oe),

		.flash_io0_do (flash_io0_do),
		.flash_io1_do (flash_io1_do),
		.flash_io2_do (flash_io2_do),
		.flash_io3_do (flash_io3_do),

		.flash_io0_di (flash_io0_di),
		.flash_io1_di (flash_io1_di),
		.flash_io2_di (flash_io2_di),
		.flash_io3_di (flash_io3_di),

		.irq_5        (1'b0        ),
		.irq_6        (1'b0        ),
		.irq_7        (1'b0        ),

		.iomem_valid  (iomem_valid ),
		.iomem_ready  (iomem_ready ),
		.iomem_wstrb  (iomem_wstrb ),
		.iomem_addr   (iomem_addr  ),
		.iomem_wdata  (iomem_wdata ),
		.iomem_rdata  (iomem_rdata )
	);
*/

	// This assumes the the phy has negotiated gigabit speeds
	logic eth_resetn;
	reset_gen #(.POLARITY(0), .COUNT(32767)) eth_reset_gen (.clk(eth_rxclk), .en('1), .sreset(eth_resetn));

	assign eth_gtxclk = eth_rxclk;
	assign eth_phyrst_n = 1;
	assign eth_txer = 0;

	logic [7:0] dat_reg;
	logic valid_reg;
	logic error_reg;

	// Delay data and valid by one cycle
	// This lets us use the invalid signal as a last
	always_ff @ (posedge eth_rxclk)
	begin
		dat_reg   <= eth_rxd;
		valid_reg <= eth_rxdv;
		error_reg <= eth_rxer;
	end

	logic error_filter_ready;

	logic axis_in_fifo_ready;
	logic axis_in_fifo_valid;
	logic axis_in_fifo_last;
	logic [7:0] axis_in_fifo_data;
	logic axis_in_fifo_error;

	axis_register
	#(
		.AXIS_BYTES(1)
	) in_reg (
		.clk(eth_rxclk),
		.sresetn(eth_resetn),

		.axis_i_tready(error_filter_ready),
		.axis_i_tvalid(valid_reg),
		.axis_i_tlast(!eth_rxdv),
		.axis_i_tdata(dat_reg),
		.axis_i_tuser((!error_filter_ready) || error_reg),

		.axis_o_tready(axis_in_fifo_ready),
		.axis_o_tvalid(axis_in_fifo_valid),
		.axis_o_tlast (axis_in_fifo_last),
		.axis_o_tdata (axis_in_fifo_data),
		.axis_o_tuser (axis_in_fifo_error),
	);

	axis_error_filter_async
	#(
		.AXIS_BYTES(1),
		.LOG2_DEPTH(10)
	) in_fifo (
		.i_clk(eth_rxclk),
		.i_sresetn(eth_resetn),

		.o_clk(clk25),
		.o_sresetn(resetn),

		.axis_i_tready(axis_in_fifo_ready),
		.axis_i_tvalid(axis_in_fifo_valid),
		.axis_i_tlast(axis_in_fifo_last),
		.axis_i_tdata(axis_in_fifo_data),
		.axis_i_tuser(1'b1),
		.axis_i_error(axis_in_fifo_error),

		.axis_o_tready(axis_fifo_out_ready),
		.axis_o_tvalid(axis_fifo_out_valid),
		.axis_o_tlast (axis_fifo_out_last),
		.axis_o_tdata (axis_fifo_out_data)
	);


	logic       axis_fifo_out_ready;
	logic       axis_fifo_out_valid;
	logic       axis_fifo_out_last;
	logic [7:0] axis_fifo_out_data;

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
		.clk(clk25),
		.sresetn(resetn),

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
		.clk(clk25),
		.sresetn(resetn),

		// Input
		.axis_i_tready({axis_fifo_out_ready, axis_preamble_ready}),
		.axis_i_tvalid({axis_fifo_out_valid, axis_preamble_valid}),
		.axis_i_tlast({axis_fifo_out_last, axis_preamble_last}),
		.axis_i_tdata({axis_fifo_out_data, axis_preamble_data}),

		// Output
		.axis_o_tready(axis_inbetween_ready),
		.axis_o_tvalid(axis_inbetween_valid),
		.axis_o_tlast(axis_inbetween_last),
		.axis_o_tdata(axis_inbetween_data)
	);

	logic       axis_eth_tx_ready;
	logic       axis_eth_tx_valid;
	logic       axis_eth_tx_last;
	logic [7:0] axis_eth_tx_data;

	axis_packet_fifo_async
	#(
		.AXIS_BYTES(1),
		.LOG2_DEPTH(10)
	) out_fifo (
		.i_clk(clk25),
		.i_sresetn(resetn),

		.o_clk(eth_rxclk),
		.o_sresetn(eth_resetn),

		.axis_i_tready(axis_inbetween_ready),
		.axis_i_tvalid(axis_inbetween_valid),
		.axis_i_tlast(axis_inbetween_last),
		.axis_i_tdata(axis_inbetween_data),
		.axis_i_tuser(1'b1),
		.axis_i_drop(1'b0),

		.axis_o_tready(axis_eth_tx_ready),
		.axis_o_tvalid(axis_eth_tx_valid),
		.axis_o_tlast (axis_eth_tx_last),
		.axis_o_tdata (axis_eth_tx_data)
	);

	axis_spacer
	#(
		.AXIS_BYTES(1),
		.GAP_CYCLES(12) // For 96 ns inter packet gap
	) spacer (
		.clk(eth_rxclk),
		.sresetn(eth_resetn),

		.axis_i_tready(axis_eth_tx_ready),
		.axis_i_tvalid(axis_eth_tx_valid),
		.axis_i_tlast (axis_eth_tx_last),
		.axis_i_tdata (axis_eth_tx_data),

		// Output
		.axis_o_tready(1'b1),
		.axis_o_tvalid(eth_txen),
		.axis_o_tlast(),
		.axis_o_tdata(eth_txd)
	);

endmodule
