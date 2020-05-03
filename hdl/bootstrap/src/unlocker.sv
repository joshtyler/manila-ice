// Unlock the FPGA by receiving the expected string over serial

module unlocker
#(
	parameter MAGIC_BYTES = 1,
	parameter [8*MAGIC_BYTES-1 : 0] MAGIC = '0
) (
	input logic clk,
	input logic sresetn,

	input logic       s_axis_tvalid,
	input logic [7:0] s_axis_tdata,

	output logic unlocked
);

localparam integer CTR_WIDTH = MAGIC_BYTES == 1? 1 : $clog2(MAGIC_BYTES);
logic [CTR_WIDTH-1:0] ctr;

always_ff @(posedge clk)
begin
	if(!sresetn)
	begin
		ctr <= 0;
		unlocked <= 0;
	end else begin
		if(s_axis_tvalid)
		begin
			// N.B. We start at the top of the magic and work down
			if(s_axis_tdata == MAGIC[(MAGIC_BYTES-ctr)*8-1 -: 8])
			begin
				ctr <= ctr + 1;
				if(ctr == MAGIC_BYTES-1)
				begin
					unlocked <= 1;
				end
			end else begin
				ctr <= 0;
			end
		end
	end
end

endmodule
