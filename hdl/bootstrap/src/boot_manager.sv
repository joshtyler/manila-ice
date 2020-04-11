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

rom_to_axis
#(
	.AXIS_BYTES(1),
	.DEPTH(40),
	.MEM({
		{8'b00000001}, // SS high don't discard data
		{8'b00000001}, // One byte
		{8'b00000001}, // To config reg
		{8'b00000001}, // Write

		{8'h24}, // Data
		{8'h01}, // Write status register 1
		{8'b00000010}, // Two bytes
		{8'b00000010}, // To data reg
		{8'b00000001}, // Write

		{8'b00000010}, // Discard data and SS low
		{8'b00000001}, // One byte
		{8'b00000001}, // To config reg
		{8'b00000001}, // Write



		{8'b00000001}, // SS high don't discard data
		{8'b00000001}, // One byte
		{8'b00000001}, // To config reg
		{8'b00000001}, // Write

		{8'h50}, // Volatile bits Write enable
		{8'b00000001}, // One byte
		{8'b00000010}, // To data reg
		{8'b00000001}, // Write

		{8'b00000010}, // Discard data and SS low
		{8'b00000001}, // One byte
		{8'b00000001}, // To config reg
		{8'b00000001}, // Write



		// Waste time to get us out of sleep
		{8'b11111111}, // 255 bytes
		{8'b00000001}, // From config reg
		{8'b00000000}, // Read

		{8'b00000001}, // SS high don't discard data
		{8'b00000001}, // One byte
		{8'b00000001}, // To config reg
		{8'b00000001}, // Write




		{8'hAB}, // Release from power down
		{8'b00000001}, // One byte
		{8'b00000010}, // To data reg
		{8'b00000001}, // Write

		{8'b00000010}, // Discard data and SS low
		{8'b00000001}, // One byte
		{8'b00000001}, // To config reg
		{8'b00000001} // Write
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
