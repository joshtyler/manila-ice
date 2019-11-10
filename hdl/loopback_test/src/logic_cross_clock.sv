// Register and re-register a single bit onto a different clock domain
// Avoid metastability

module logic_cross_clock
#(
	paramter integer STAGES = 2;
) (
	input clk,
	input i,
	output o
);

logic[STAGES:0] tmp;

always_comb
begin
	tmp[0] <= i;
	o <= tmp[STAGES];
end

generate
	genvar i;
	for(i=0; i<STAGES; i++)
	begin
		always @posedge(clk)
		begin
			tmp[i+1] <= tmp[i];
		end
	end
endgenerate
