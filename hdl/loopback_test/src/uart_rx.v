// UART Receiver
// No parity bits, any number of stop bits

module uart_rx
#(
	parameter integer CLK_FREQ;
	parameter integer BAUD_RATE;
	parameter integer DATA_BITS = 8
) (
	input clk,
	input sresetn,

	input serial_data,

	output parallel_data_valid,
	output [DATA_BITS-1:0] parallel_data
);

// Avoid metastability
logic serial_data_reg;
logic_cross_clock logic_cross_clock_inst (.clk(clk), .i(serial_data), .o(serial_data_reg));


localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
logic [$clog2(CLKS_PER_BIT)-1:0] baud_ctr;
logic [$clog2(DATA_BITS+2)-1:0] data_ctr; // Data bits+2 because we also count the start and stop bit

logic[0:0] state;
localparam RESET     = 1'b0; // Wait for start of transmission
localparam CAPTURE   = 1'b1; // Capture values of all bits except start bit

logic next_bit, sample_bit;
always_comb
begin
	next_bit = baud_ctr == CLKS_PER_BIT-1; // Go to next bit when our baud counter reaches the max value
	sample_bit = baud_ctr == CLKS_PER_BIT/2; // Sample the value of the current bit when we are half way through the bit
end
always @(posedge clk)
begin
	if(!n_reset)
		state <= RESET;
	else begin

			baud_ctr <= baud_ctr + 1;
			if(baud_ctr == CLKS_PER_BIT)
			begin
				data_ctr <= data_ctr + 1;
				baud_ctr <= 0;
			end

		case(state)
			RESET : begin
				baud_ctr <= 0; // Number of clock cycles per bit
				data_ctr <= 0; // Current data bit
				parallel_data_valid <= 0;

				// If transmission starts
				if(!serial_data_reg) begin
					state <= CAPTURE;
				end
			end
			CAPTURE : begin
				// Bit(0) is the start bit, don't sample this
				// Bit(DATA_BITS+1) is the stop bit, go back to RESET on this
				if(sample_bit)
				begin
					if(data_ctr = DATA_BITS+1) // Stop bit
					begin
						assert serial_data_reg;
						state <= RESET;
						parallel_data_valid <= 1;
					end elseif(data_ctr > 0) begin // Data bit
						parallel_data[data_ctr-1] <= serial_data_reg;
					end else begin // Start bit
						assert data_ctr = 0;
						assert !serial_data_reg
					end
				end
			end
		endcase
	end
end
endmodule
