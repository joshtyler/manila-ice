// Test to receive a TCP stream from a PC

`include "axis/axis.h"

module top
(
	input logic clk,

	output logic [7:0] leds,

	input  logic       eth_rxclk,
	input  logic [7:0] eth_rxd,
	input  logic       eth_rxdv,
	input  logic       eth_rxer,
	output logic       eth_gtxclk,
	output logic [7:0] eth_txd,
	output logic       eth_txen,
	output logic       eth_txer,
	output logic       eth_phyrst_n

);

	localparam [47:0] OUR_MAC = 48'h0605040302;
	localparam [47:0] OUR_IP  = {8'd10, 8'd10, 8'd168, 8'd192};

	logic sresetn;
	reset_gen #(.POLARITY(0), .COUNT(32767)) reset_gen (.clk(clk), .en('1), .sreset(sresetn));

	logic eth_resetn;
	reset_gen #(.POLARITY(0), .COUNT(32767)) eth_reset_gen (.clk(eth_rxclk), .en('1), .sreset(eth_resetn));
	assign eth_gtxclk = eth_rxclk;
	assign eth_phyrst_n = 1;

	`AXIS_INST_NO_USER(axis_from_mac, 4);

	gmii_rx_mac_async
	#(
		.AXIS_BYTES(4)
	) rx_mac (
		.eth_clk(eth_clk),
		.eth_sresetn(eth_sresetn),

		.eth_rxd(eth_rxd),
		.eth_rxdv(eth_rxdv),
		.eth_rxer(eth_rxer),

		.axis_clk(clk),
		.axis_sresetn(sresetn),

		`AXIS_MAP_NO_USER(axis_o, axis_from_mac)
	);

	eth_deframer
	#(
		.AXIS_BYTES(4),
		.REQUIRE_PACKED_OUTPUT(1)
	) rx_mac (
		.clk(clk),
		.sresetn(sresetn),

		`AXIS_MAP_NO_USER(axis_i, axis_from_mac)
		`AXIS_MAP_NO_USER(axis_o, axis_from_mac_no_eth_unpacked),
		.axis_o_dst_mac(axis_from_mac_no_eth_unpacked_dst_mac),
		.axis_o_src_mac(axis_from_mac_no_eth_unpacked_src_mac),
		.axis_o_ethertype(axis_from_mac_no_eth_unpacked_ethertype),
	);

	logic packet_is_ok;

	// Okay if multicast, or unicast and  intended for us and an ARP packet
	assign packet_is_ok = ((axis_from_mac_no_eth_unpacked_dst_mac[0] == 1) || axis_from_mac_no_eth_unpacked_dst_mac == OUR_MAC)) && (axis_from_mac_no_eth_unpacked_ethertype == ETHERTYPE_ARP)

	`AXIS_INST_NO_USER(axis_arp_tx, 4);
	logic [47:0] arp_dst_mac
	arp_engine
	#(
		.AXIS_BYTES(4)
		.OUR_MAC(OUR_MAC),
		.OUR_IP(OUR_IP)
	) rx_mac (
		.clk(clk),
		.sresetn(sresetn),

		.axis_i_tready(axis_from_mac_no_eth_unpacked_tready)
		.axis_i_tvalid(axis_from_mac_no_eth_unpacked_tvalid && packet_is_ok)
		.axis_i_tlast(axis_from_mac_no_eth_unpacked_tlast)
		.axis_i_tkeep(axis_from_mac_no_eth_unpacked_tkeep)
		.axis_i_tdata(axis_from_mac_no_eth_unpacked_tdata)

		`AXIS_MAP_NO_USER(axis_o, axis_arp_tx),
		.axis_o_dst_mac(arp_dst_mac)
	);

	`AXIS_INST_NO_USER(axis_eth_tx, 4);
	eth_framer
	#(
		.AXIS_BYTES(4)
		.REQUIRE_PACKED_OUTPUT(1)
	) rx_mac (
		.clk(clk),
		.sresetn(sresetn),

		`AXIS_MAP_NO_USER(axis_i, axis_arp_tx),
		.axis_i_dst_mac(arp_dst_mac),
		.axis_i_src_mac(OUR_MAC),
		.axis_i_ethertype(16'h0806)

		`AXIS_MAP_NO_USER(axis_o, axis_eth_tx),
		.axis_o_dst_mac(arp_dst_mac)
	);

	`AXIS_INST_NO_USER(axis_eth_tx_buf, 4);
	axis_packet_fifo_async
	#(
		.AXIS_BYTES(AXIS_BYTES),
		.LOG2_DEPTH($clog2(66)) // Size of ARP packet with ethernet header
	) fifo (
		.i_clk(axis_clk),
		.i_sresetn(axis_sresetn),

		.o_clk(eth_clk),
		.o_sresetn(eth_sresetn),

		`AXIS_MAP_NULL_USER(axis_i, axis_eth_tx)
		`AXIS_MAP_IGNORE_USER(axis_o, axis_eth_tx_buf)
	);

	gmii_tx_mac
	#(
		.AXIS_BYTES(4)
	) fifo (
		.clk(eth_clk),
		.sresetn(eth_sresetn),

		`AXIS_MAP_NO_USER(axis_i, axis_eth_tx)

		.eth_txd (eth_txd),
		.eth_txdv(eth_txdv),
		.eth_txer(eth_txer),
	);


endmodule
