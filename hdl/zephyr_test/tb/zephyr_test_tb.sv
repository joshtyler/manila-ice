/*
 *  PicoSoC - A simple example SoC using PicoRV32
 *
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

`timescale 1 ns / 1 ps

module zephyr_test_tb;
	logic clk;
	always #21 clk = (clk === 1'b0);

	localparam ser_half_period = 104;
	event ser_sample;

	initial begin
		$dumpfile("testbench.vcd");
		$dumpvars(0, zephyr_test_tb);

		repeat (6) begin
			repeat (50000) @(posedge clk);
			$display("+50000 cycles");
		end
		$finish;
	end

	wire [7:0] leds;

	wire ser_rx =1'b1;
	wire ser_tx;

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;
	wire flash_io2;
	wire flash_io3;

	always @(leds) begin
		#1 $display("%b", leds);
	end

	top uut (
		.clk      (clk      ),
		.leds     (leds     ),

		.uart_rx   (ser_rx   ),
		.uart_tx   (ser_tx   ),

		.spi_ss(flash_csb),
		.spi_sck(flash_clk),
		.spi_mosi(flash_io0),
		.spi_miso(flash_io1),
		.spi_wp_n(flash_io2),
		.spi_hold_n(flash_io3)
	);

	spiflash spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(flash_io2),
		.io3(flash_io3)
	);

	reg [7:0] buffer;

	always begin
		@(negedge ser_tx);

		repeat (ser_half_period) @(posedge clk);
		-> ser_sample; // start bit

		repeat (8) begin
			repeat (ser_half_period) @(posedge clk);
			repeat (ser_half_period) @(posedge clk);
			buffer = {ser_tx, buffer[7:1]};
			-> ser_sample; // data bit
		end

		repeat (ser_half_period) @(posedge clk);
		repeat (ser_half_period) @(posedge clk);
		-> ser_sample; // stop bit

		if (buffer < 32 || buffer >= 127)
			$display("Serial data: %d", buffer);
		else
			$display("Serial data: '%c'", buffer);
	end
endmodule
