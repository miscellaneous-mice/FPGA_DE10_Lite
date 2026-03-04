
module avalon_design (
	clk_clk,
	hex_interface_hex_0,
	hex_interface_hex_1,
	hex_interface_hex_2,
	hex_interface_hex_3,
	hex_interface_hex_4,
	hex_interface_hex_5,
	led_interface_export,
	button_interface_export);	

	input		clk_clk;
	output	[7:0]	hex_interface_hex_0;
	output	[7:0]	hex_interface_hex_1;
	output	[7:0]	hex_interface_hex_2;
	output	[7:0]	hex_interface_hex_3;
	output	[7:0]	hex_interface_hex_4;
	output	[7:0]	hex_interface_hex_5;
	output		led_interface_export;
	input	[1:0]	button_interface_export;
endmodule
