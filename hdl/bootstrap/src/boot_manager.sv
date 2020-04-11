module boot_manager
(
	input  logic clk,
	input  logic sresetn,

	// High if anything is received on the uart
	// Means that we should stop the autoboot process
	input  logic uart_rx_valid,
	// Sampled from externally, pulled high, then the user ties low if they want a firmware update
	input  logic enable_protection,

	// Goes high if we should boot the next image
	output logic reboot,

	// Display status of the autoboot process
	output logic [7:0] leds,

	// Connect this to the serial_wb_master block in order to proctect the SPI flash
	input  logic m_axis_protect_tready,
	output logic m_axis_protect_tvalid,
	output logic [7:0]  m_axis_protect_tdata,
	// This tells the main logic when to start listening to the UART rather than this state machine
	output logic axis_protect_done
);

localparam CTR_BITS = 28;
logic [CTR_BITS-1:0] ctr;

logic halt_ctr;
logic normal_mode;

logic m_axis_protect_tlast;

always @(posedge clk)
begin
	if(!sresetn) begin
		halt_ctr <= 0;
		ctr <= 0;
		reboot <= 0;
		normal_mode <= enable_protection;
		axis_protect_done <= 0;
	end else begin

		if(!halt_ctr) begin
			ctr <= ctr + 1;
		end

		if(normal_mode) begin
			// This is the "normal" mode
			// Protect the memory
			// Halt the automatic reboot process if we receive any serial data

			// If we ever receive any serial data, halt the counterr
			if(uart_rx_valid) begin
				halt_ctr <= 1;
			end

			// If the counter gets high enough, boot into the other image
			if(ctr[CTR_BITS-1]) begin
				reboot <= 1;
			end

			if(m_axis_protect_tready && m_axis_protect_tvalid && m_axis_protect_tlast) begin
				axis_protect_done <= 1;
			end

		end else begin
			// This is the firmware upgrade mode
			// DONT proctect the memory
			// Don't ever auto reboot
			axis_protect_done <= 1;

			// Flash the LEDs to show the user that they are not in the normal mode

		end
	end
end


// Assign the LEDS.
// In normal mode, assign the counter to the LEDs in a linear fashion
// This indicates reboot status to the user
// In unprotected mode flash the LEDs to warn the user
// Doesn't need to be clocked, but it can only help timing
genvar i;
generate
	for(i=0; i<8;i++)
		always @(posedge clk)
		begin
			if(normal_mode)
			begin
				if(ctr == 0)
				begin
					leds[i] <= 0;
				end else if(ctr > ((2**(CTR_BITS-1))/8)*i) begin
					leds[i] <= 1;
				end
			end else begin
				leds[i] <= ctr[CTR_BITS-3];
			end
		end
endgenerate

localparam [23:0] setup_data_write_one_byte =
{
	{8'b00000001}, // One byte
	{8'b00000010}, // To data reg
	{8'b00000001}  // Write
};

localparam [23:0] setup_data_write_two_bytes =
{
	{8'b00000010}, // Two bytes
	{8'b00000010}, // To data reg
	{8'b00000001}  // Write, constant address
};

localparam [23:0] setup_config_write_one_byte =
{
	{8'b00000001}, // One byte
	{8'b00000001}, // To config reg
	{8'b00000001}  // Write
};

localparam [31:0] ss_high_keep_data =
{
	{8'b00000001}, // SS high don't discard data
	setup_config_write_one_byte
};

localparam [31:0] ss_low_discard_data =
{
	{8'b00000010}, // Discard data and SS low
	setup_config_write_one_byte
};

localparam [23:0] waste_time =
{
	{8'b11111111}, // 255 bytes
	{8'b00000001}, // From config reg
	{8'b00000000}  // Read
};

localparam [95:0] enable_volatile_status_register_write =
{
	ss_high_keep_data,
	{8'h50}, // Enable write to staus register (treat all bits as volatile)
	setup_data_write_one_byte,
	ss_low_discard_data
};

rom_to_axis
#(
	.AXIS_BYTES(1),
	.DEPTH(96),
	.MEM({
		ss_high_keep_data,
		{8'h03}, // dont invert memory proection range, don't lock security registers, enable QSPI, *prevent changes to stastus registers until power cycle*
		{8'h31}, // Write status register 2
		setup_data_write_two_bytes,
		ss_low_discard_data,

		enable_volatile_status_register_write,

		ss_high_keep_data,
		{8'h60}, // driver strength=11,use CMP, SEC, TB, BP to protect memory
		{8'h11}, // Write status register 3
		setup_data_write_two_bytes,
		ss_low_discard_data,

		enable_volatile_status_register_write,

		ss_high_keep_data,
		{8'h24}, // Ignore WP pin, protect 64kB blocks. Protect bottom of memory. BP=001
		{8'h01}, // Write status register 1
		setup_data_write_two_bytes,
		ss_low_discard_data,

		enable_volatile_status_register_write,


		// Waste time to get us out of sleep
		// The chip can take 3us to wake up
		// At 1 read per clock cycle, these three reads will waste :
		// 3*255*1/f
		// This is enough for even a 250MHz clock - far beyond what the iCE40 can do!
		waste_time,
		waste_time,
		waste_time,

		ss_high_keep_data,
		{8'hAB}, // Release from power down
		setup_data_write_one_byte,
		ss_low_discard_data
		})
) rom_to_axis_inst (
	.clk(clk),
	.sresetn(sresetn && normal_mode),

	.axis_tready(m_axis_protect_tready),
	.axis_tvalid(m_axis_protect_tvalid),
	.axis_tlast(m_axis_protect_tlast),
	.axis_tdata(m_axis_protect_tdata)
);


endmodule
