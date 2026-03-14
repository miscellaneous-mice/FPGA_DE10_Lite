
module signal_analyzer (
	clk_clk,
	gpio_interface_export,
	hex_interface_hex_0,
	hex_interface_hex_1,
	hex_interface_hex_2,
	hex_interface_hex_3,
	hex_interface_hex_4,
	hex_interface_hex_5,
	key_interface_export,
	pll_areset_export,
	pll_locked_export,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	sw_interface_export);	

	input		clk_clk;
	inout	[35:0]	gpio_interface_export;
	output	[7:0]	hex_interface_hex_0;
	output	[7:0]	hex_interface_hex_1;
	output	[7:0]	hex_interface_hex_2;
	output	[7:0]	hex_interface_hex_3;
	output	[7:0]	hex_interface_hex_4;
	output	[7:0]	hex_interface_hex_5;
	input	[1:0]	key_interface_export;
	input		pll_areset_export;
	output		pll_locked_export;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input	[9:0]	sw_interface_export;
endmodule
