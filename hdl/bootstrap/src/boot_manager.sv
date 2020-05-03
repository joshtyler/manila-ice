module boot_manager
(
	input  logic clk,
	input  logic sresetn,

	// High once we have recevied the magic over the UART
	// Means that we should stop the autoboot process
	input  logic unlocked,
	// Sampled from externally, pulled high, then the user ties low if they want a firmware update
	input  logic enable_protection,

	// Buttons to manually control boot image
	// The event pulses high if the button changes
	// This lets us know an event occurred
	input logic [1:0] buttons,
	input logic [1:0] button_events,

	// Display status of the autoboot process
	output logic [7:0] leds,

	// Connect this to the serial_wb_master block in order to proctect the SPI flash
	input  logic m_axis_protect_tready,
	output logic m_axis_protect_tvalid,
	output logic [7:0]  m_axis_protect_tdata,
	// This tells the main logic when to start listening to the UART rather than this state machine
	output logic axis_protect_done,

	// Wishbone port to reboot by serial
	input logic [7:0] s_wb_m2s,
	output logic [7:0] s_wb_s2m,
	input logic  s_wb_we,
	input logic  s_wb_stb,
	output logic  s_wb_ack,
	output logic s_wb_stall
);

logic reboot = 0; // Bitstream initialise to zero to make sure we don't immediately reboot
logic [1:0] boot_partition;

localparam CTR_BITS = 28;
logic [CTR_BITS-1:0] ctr;

logic m_axis_protect_tlast;

logic [1:0] state;
localparam [1:0] SM_PROTECT          = 2'b00;
localparam [1:0] SM_FIRMWARE_UPGRADE = 2'b01;
localparam [1:0] SM_WAIT_AUTOBOOT    = 2'b10;
localparam [1:0] SM_MANUAL_CONTROL   = 2'b11;


assign axis_protect_done = state != SM_PROTECT;

logic [7:0] linear_leds;

always @(posedge clk)
begin
	if(!sresetn) begin
		ctr <= 0;
		reboot <= 0;
		boot_partition <= 2'b01;
		state <= enable_protection? SM_PROTECT : SM_FIRMWARE_UPGRADE;
		leds <= '0;
	end else begin

		ctr <= ctr + 1;
		s_wb_ack <= 0;

		case(state)
			SM_PROTECT:
			begin
				// Wait until we have protected the memory
				if(m_axis_protect_tready && m_axis_protect_tvalid && m_axis_protect_tlast)
				begin
					state <= SM_WAIT_AUTOBOOT;
				end
			end

			SM_FIRMWARE_UPGRADE:
			begin
				// This is the firmware upgrade mode
				// DONT protect the memory
				// Don't ever auto reboot

				// Flash the LEDs to show the user that they are not in the normal mode
				leds <= {8{ctr[CTR_BITS-3]}};
			end

			SM_WAIT_AUTOBOOT:
			begin
				// This is the "normal" mode
				// Memory is protected
				// Wait until a timeout has passed and boot into the default partition

				// If the counter gets high enough, boot into the other image
				if(ctr[CTR_BITS-1]) begin
					reboot <= 1;
				end

				// Show timer progress on LEDS
				leds <= linear_leds;

				// If we ever receive any serial data, halt the counter and go to manual control
				// Or if the user pressed a button
				if(unlocked || (| button_events))
				begin
					state <= SM_MANUAL_CONTROL;
				end
			end

			SM_MANUAL_CONTROL:
			begin
				// Here we use the buttons to decide whether to reboot or not
				// button 0 cycles through the images
				// button 1 commits to booting an image
				// N.B. the buttons are active low (pressed = 0)
				// We also listen to register reads/writes which will reboot us immediately

				// Show the boot partition on the LEDs
				// Very lazy binary to one hot
				case(boot_partition)
					2'b00: leds <= 8'b00000001;
					2'b01: leds <= 8'b00000010;
					2'b10: leds <= 8'b00000100;
					2'b11: leds <= 8'b00001000;
				endcase

				if(button_events[0] && buttons[0])
				begin
					boot_partition <= boot_partition + 1;
				end

				if(button_events[1] && buttons[1])
				begin
					reboot <= 1;
				end

				// Reboot if the user writes to the register
				if(s_wb_stb)
				begin
					if(s_wb_we)
					begin
						boot_partition <= s_wb_m2s[1:0];
						reboot <= 1;
					end
					s_wb_ack <= 1;
				end

			end

		endcase
	end
end

assign s_wb_stall = state != SM_MANUAL_CONTROL;
assign s_wb_s2m = {6'b000000, boot_partition};

// In normal mode, assign the counter to the LEDs in a linear fashion
// This indicates reboot status to the user
genvar i;
generate
	for(i=0; i<8;i++)
		always_comb
		begin
			linear_leds[i] = 0;
			if(ctr > ((2**(CTR_BITS-1))/8)*i) begin
				linear_leds[i] = 1;
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
	{8'b11111111}, // 1 byte
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
	.sresetn(sresetn && (state == SM_PROTECT)),

	.axis_tready(m_axis_protect_tready),
	.axis_tvalid(m_axis_protect_tvalid),
	.axis_tlast(m_axis_protect_tlast),
	.axis_tdata(m_axis_protect_tdata)
);

`ifndef VERILATOR
SB_WARMBOOT warmboot (
	.BOOT(reboot),
	.S0(boot_partition[0]),
	.S1(boot_partition[1])
);
`endif


endmodule
