// Application to load new data into SPI flash

module top
(
	input logic clk_raw,

	input  logic uart_rx,
	output logic uart_tx,

	output logic [7:0] leds,
	input logic [1:0] buttons,

	output logic sck,
	output logic ss,
	input logic miso,
	output logic mosi,

	input logic wp_n // Not used for write proect. Used to enable/disable protection
);

// The flow control is broken in the linux kernel, so hard disable for now
logic rts_n;
assign rts_n = 0;
logic cts_n;

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
	.axis_i_tuser(1'b0),

	// Output
	.axis_o_tready(uart_rx_tready),
	.axis_o_tvalid(uart_rx_tvalid),
	.axis_o_tlast(),
	.axis_o_tdata(uart_rx_tdata),
	.axis_o_tuser()
);

// Mux between the boot_manager axis_protect, and the data from the user
logic axis_protect_tready;
logic axis_protect_tvalid;
logic [7:0]  axis_protect_tdata;
logic axis_protect_done;

logic        axis_wb_in_tready;
logic        axis_wb_in_tvalid;
logic [7:0]  axis_wb_in_tdata;

logic        axis_wb_out_tready;
logic        axis_wb_out_tvalid;
logic [7:0]  axis_wb_out_tdata;

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
	.axis_o_tready(axis_wb_out_tready),
	.axis_o_tvalid(axis_wb_out_tvalid),
	.axis_o_tlast(),
	.axis_o_tdata(axis_wb_out_tdata),

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

logic [ADDR_BITS-1:0] wb_boot_manager_addr    , wb_spi_addr;
logic [BYTES*8-1:0]   wb_boot_manager_dat_m2s , wb_spi_dat_m2s;
logic [BYTES*8-1:0]   wb_boot_manager_dat_s2m , wb_spi_dat_s2m;
logic                 wb_boot_manager_we      , wb_spi_we     ;
logic                 wb_boot_manager_stb     , wb_spi_stb    ;
logic [SEL_WIDTH-1:0] wb_boot_manager_sel     , wb_spi_sel    ;
logic                 wb_boot_manager_cyc     , wb_spi_cyc    ;
logic                 wb_boot_manager_ack     , wb_spi_ack    ;
logic                 wb_boot_manager_stall   , wb_spi_stall  ;

wb_interconnect
#(
	.NUM_MASTERS(2),
	.ADDR_BITS(ADDR_BITS),
	.BYTES(BYTES),
	.SEL_WIDTH(SEL_WIDTH),
	.MASTER_ADDRESSES({
		{(ADDR_BITS-3){1'b0}},3'b100,
		{(ADDR_BITS){1'b0}}
	}),
	.MASTER_ADDRESS_MASKS({
		{(ADDR_BITS){1'b1}},
		{(ADDR_BITS-2){1'b1}},2'b00
	})
) ic (
	.s_wb_addr   (wb_addr   ),
	.s_wb_dat_m2s(wb_dat_m2s),
	.s_wb_dat_s2m(wb_dat_s2m),
	.s_wb_we     (wb_we     ),
	.s_wb_sel    (wb_sel    ),
	.s_wb_stb    (wb_stb    ),
	.s_wb_cyc    (wb_cyc    ),
	.s_wb_ack    (wb_ack    ),
	.s_wb_stall  (wb_stall  ),

	.m_wb_addr   ({wb_boot_manager_addr    , wb_spi_addr   }),
	.m_wb_dat_m2s({wb_boot_manager_dat_m2s , wb_spi_dat_m2s}),
	.m_wb_dat_s2m({wb_boot_manager_dat_s2m , wb_spi_dat_s2m}),
	.m_wb_we     ({wb_boot_manager_we      , wb_spi_we     }),
	.m_wb_sel    ({wb_boot_manager_sel     , wb_spi_sel    }),
	.m_wb_stb    ({wb_boot_manager_stb     , wb_spi_stb    }),
	.m_wb_cyc    ({wb_boot_manager_cyc     , wb_spi_cyc    }),
	.m_wb_ack    ({wb_boot_manager_ack     , wb_spi_ack    }),
	.m_wb_stall  ({wb_boot_manager_stall   , wb_spi_stall  })
);


wb_to_spi_master spi_inst (
	.clk(clk),
	.sresetn(sresetn),
	.s_wb_addr   (wb_spi_addr   ),
	.s_wb_dat_m2s(wb_spi_dat_m2s),
	.s_wb_dat_s2m(wb_spi_dat_s2m),
	.s_wb_we     (wb_spi_we     ),
	.s_wb_sel    (wb_spi_sel    ),
	.s_wb_stb    (wb_spi_stb    ),
	.s_wb_cyc    (wb_spi_cyc    ),
	.s_wb_ack    (wb_spi_ack    ),
	.s_wb_stall  (wb_spi_stall  ),
	.sck(sck),
	.ss(ss),
	.miso(miso),
	.mosi(mosi)
);


// Send out the version number over serial before we receive anything
logic       m_axis_version_tready;
logic       m_axis_version_tvalid;
logic [7:0] m_axis_version_tdata;

logic       axis_version_unspaced_tready;
logic       axis_version_unspaced_tvalid;
logic       axis_version_unspaced_tlast;
logic [7:0] axis_version_unspaced_tdata;

localparam MESSAGE_BYTES = 28;
localparam [MESSAGE_BYTES*8-1 :0] message = "Manila iCE bootloader v1.0\r\n";

vector_to_axis
#(
	.AXIS_BYTES(1),
	.VEC_BYTES(MESSAGE_BYTES),
	.MSB_FIRST(1)
) version_axis_inst (
	.clk(clk),
	.sresetn(sresetn),

	.vec(message),

	.axis_tready(axis_version_unspaced_tready),
	.axis_tvalid(axis_version_unspaced_tvalid),
	.axis_tlast (axis_version_unspaced_tlast),
	.axis_tdata (axis_version_unspaced_tdata)
);

localparam integer VERSION_SPACE_CYCLLES = 10.0e-3/(1.0/CLK_FREQ);
axis_spacer
#(
	.AXIS_BYTES(1),
	.GAP_CYCLES(VERSION_SPACE_CYCLLES)
) version_spacer (
	.clk(clk),
	.sresetn(sresetn),

	.axis_i_tready(axis_version_unspaced_tready),
	.axis_i_tvalid(axis_version_unspaced_tvalid),
	.axis_i_tlast (axis_version_unspaced_tlast),
	.axis_i_tdata (axis_version_unspaced_tdata),

	.axis_o_tready(m_axis_version_tready),
	.axis_o_tvalid(m_axis_version_tvalid),
	.axis_o_tlast (),
	.axis_o_tdata (m_axis_version_tdata)
);

logic send_wb = 0;
always_ff @(posedge clk)
	if(parallel_data_valid)
		send_wb <= 1;

assign axis_wb_out_tready    = send_wb? uart_tx_tready                            : 1                    ; // We hold m_axis_version_tready so that the protect code works
assign m_axis_version_tready = send_wb? 0                                         : uart_tx_tready       ;
assign uart_tx_tvalid        = send_wb? (axis_wb_out_tvalid && axis_protect_done) : m_axis_version_tvalid;
assign uart_tx_tdata         = send_wb? axis_wb_out_tdata                         : m_axis_version_tdata ;


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
	.s_axis_tvalid(uart_tx_tvalid), // Discard the data resulting from our memory protection
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
) protect_io_inst (
	.PACKAGE_PIN(wp_n),
	.D_IN_0(enable_protection),
);
`endif

// Debounce the buttons
logic [1:0] buttons_debounced;
logic [1:0] button_events;
genvar i;
generate
	for(i=0; i<2;i++)
	begin
		logic o;
		debouncer
		#(
			.CLK_RATE(CLK_FREQ),
			.SETTLING_TIME_us(10_000)
		) debouncer_inst (
			.clk(clk),
			.sresetn(sresetn),
			.i(buttons[i]),
			.o(o),
			.change(button_events[i])
		);
		// Invert the buttons to make 1 = pressed
		assign buttons_debounced[i] = !o;
	end
endgenerate

boot_manager boot_manager_inst (
	.clk(clk),
	.sresetn(sresetn),

	.uart_rx_valid(parallel_data_valid),

	.enable_protection(enable_protection),

	.buttons(buttons_debounced),
	.button_events(button_events),

	.leds(leds),

	.m_axis_protect_tready(axis_protect_tready),
	.m_axis_protect_tvalid(axis_protect_tvalid),
	.m_axis_protect_tdata(axis_protect_tdata),
	.axis_protect_done(axis_protect_done),

	.s_wb_m2s  (wb_boot_manager_dat_m2s),
	.s_wb_s2m  (wb_boot_manager_dat_s2m),
	.s_wb_we   (wb_boot_manager_we),
	.s_wb_stb  (wb_boot_manager_stb),
	.s_wb_ack  (wb_boot_manager_ack),
	.s_wb_stall(wb_boot_manager_stall)
);

endmodule
