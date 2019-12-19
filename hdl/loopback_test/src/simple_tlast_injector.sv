// Copyright (C) 2019 Joshua Tyler
//
//  This Source Code Form is subject to the terms of the
//  Open Hardware Description License, v. 1.0. If a copy
//  of the OHDL was not distributed with this file, You
//  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

// Strip off a length, and use that to set the length of the packet
// At the moment only a single byte header is supported, but could be extended

module simple_tlast_injector
#(
	parameter AXIS_BYTES = 1,
	localparam COUNT_BYTES = 1
) (
	input logic clk,
	input logic sresetn,

	// Input
	output logic                    axis_i_tready,
	input logic                     axis_i_tvalid,
	input logic[(AXIS_BYTES*8)-1:0] axis_i_tdata,

	// Output
	input logic                       axis_o_tready,
	output logic                      axis_o_tvalid,
	output logic                      axis_o_tlast,
	output logic [(AXIS_BYTES*8)-1:0] axis_o_tdata
);

logic [8*COUNT_BYTES-1:0] byte_ctr;

logic [0:0] state;
localparam SM_GET_COUNT = 1'b0;
localparam SM_PASS_DATA = 1'b1;

// Pass through most of the data
assign axis_i_tready = axis_o_tready;
assign axis_o_tdata  = axis_i_tdata;

always_comb
begin
	if(state = SM_PASS_DATA)
	begin
		axis_o_tvalid = axis_i_tvalid;
	end else begin
		axis_o_tvalid = 0;
	end
end

always_comb
begin
	// Don't need to gate on state becuase tvalid is low if in SM_GET_COUNT
	if(byte_ctr = 0)
	begin
		axis_o_tlast = 1;
	end else begin
		axis_o_tvalid = 0;
	end
end


always_ff @(posedge clk)
begin
	if(!sresetn)
	begin
		state <= SM_GET_COUNT;
	end else begin
		case(state)
			SM_GET_COUNT : begin
				if(axis_i_tready && axis_i_tvalid)
				begin
					byte_ctr <= axis_i_tdata;

					if(axis_i_tdata > 0)
					begin
						state <= SM_PASS_DATA;
					end
				end
			end

			SM_PASS_DATA : begin
				if(axis_i_tready && axis_i_tvalid)
				begin
					byte_ctr <= byte_ctr -1;
					if(byte_ctr = 1)
					begin
						state <= SM_GET_COUNT;
					end
				end
			end
		endcase
	end
end

endmodule
