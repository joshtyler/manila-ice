module tb;

    reg clk = 0;
    wire [7:0] leds;
    wire eth_rxclk;
    reg [7:0] eth_rxd;
    reg eth_rxdv;
    reg eth_rxer;
    wire eth_gtxclk;
    wire [7:0] eth_txd;
    wire eth_txen;
    wire eth_txer;
    wire eth_phyrst_n;

	wire        axis_arp_tx_tready;
	wire        axis_arp_tx_tvalid;
	wire        axis_arp_tx_tlast;
	wire [3:0]  axis_arp_tx_tkeep;
	wire [31:0] axis_arp_tx_tdata;

    wire        axis_to_mac_tready;
	wire        axis_to_mac_tvalid;
	wire        axis_to_mac_tlast;
	wire [3:0]  axis_to_mac_tkeep;
	wire [31:0] axis_to_mac_tdata;

    wire        axis_to_mac_packetised_tready;
	wire        axis_to_mac_packetised_tvalid;
	wire        axis_to_mac_packetised_tlast;
	wire [3:0]  axis_to_mac_packetised_tkeep;
	wire [31:0] axis_to_mac_packetised_tdata;

    always #5 clk = ~clk;

    reg eth_rxclk_reg =0;
    always #2 eth_rxclk_reg = ~eth_rxclk_reg;
    assign eth_rxclk = eth_rxclk_reg;

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,tb);

        eth_rxdv <= 0;
        eth_rxd <= 0;
        eth_rxer <= 0;
        repeat (1000) @(posedge eth_rxclk);
        @(negedge eth_rxclk);
        eth_rxdv <= 1;
        // preamble
        eth_rxd <= 8'h55; @(negedge eth_rxclk);
        eth_rxd <= 8'h55; @(negedge eth_rxclk);
        eth_rxd <= 8'h55; @(negedge eth_rxclk);
        eth_rxd <= 8'h55; @(negedge eth_rxclk);
        eth_rxd <= 8'h55; @(negedge eth_rxclk);
        eth_rxd <= 8'h55; @(negedge eth_rxclk);
        eth_rxd <= 8'hD5; @(negedge eth_rxclk);

        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);

        eth_rxd <= 8'h22; @(negedge eth_rxclk);
        eth_rxd <= 8'hAC; @(negedge eth_rxclk);
        eth_rxd <= 8'h10; @(negedge eth_rxclk);
        eth_rxd <= 8'hF7; @(negedge eth_rxclk);
        eth_rxd <= 8'h89; @(negedge eth_rxclk);
        eth_rxd <= 8'hBB; @(negedge eth_rxclk);

        eth_rxd <= 8'h08; @(negedge eth_rxclk);
        eth_rxd <= 8'h06; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h01; @(negedge eth_rxclk);
        eth_rxd <= 8'h08; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h06; @(negedge eth_rxclk);
        eth_rxd <= 8'h04; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h01; @(negedge eth_rxclk);
        eth_rxd <= 8'h22; @(negedge eth_rxclk);
        eth_rxd <= 8'hAC; @(negedge eth_rxclk);
        eth_rxd <= 8'h10; @(negedge eth_rxclk);
        eth_rxd <= 8'hF7; @(negedge eth_rxclk);
        eth_rxd <= 8'h89; @(negedge eth_rxclk);
        eth_rxd <= 8'hBB; @(negedge eth_rxclk);
        eth_rxd <= 8'h0A; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h64; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'hFF; @(negedge eth_rxclk);
        eth_rxd <= 8'h0A; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h6E; @(negedge eth_rxclk);

        // Dummy CRC
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxd <= 8'h00; @(negedge eth_rxclk);
        eth_rxdv <= 0;

        repeat (5000) @(posedge eth_rxclk);
        $finish;
    end

    top uut (.*);

endmodule
