	signal_analyzer u0 (
		.clk_clk               (<connected-to-clk_clk>),               //            clk.clk
		.gpio_interface_export (<connected-to-gpio_interface_export>), // gpio_interface.export
		.hex_interface_hex_0   (<connected-to-hex_interface_hex_0>),   //  hex_interface.hex_0
		.hex_interface_hex_1   (<connected-to-hex_interface_hex_1>),   //               .hex_1
		.hex_interface_hex_2   (<connected-to-hex_interface_hex_2>),   //               .hex_2
		.hex_interface_hex_3   (<connected-to-hex_interface_hex_3>),   //               .hex_3
		.hex_interface_hex_4   (<connected-to-hex_interface_hex_4>),   //               .hex_4
		.hex_interface_hex_5   (<connected-to-hex_interface_hex_5>),   //               .hex_5
		.key_interface_export  (<connected-to-key_interface_export>),  //  key_interface.export
		.pll_areset_export     (<connected-to-pll_areset_export>),     //     pll_areset.export
		.pll_locked_export     (<connected-to-pll_locked_export>),     //     pll_locked.export
		.sdram_clk_clk         (<connected-to-sdram_clk_clk>),         //      sdram_clk.clk
		.sdram_wire_addr       (<connected-to-sdram_wire_addr>),       //     sdram_wire.addr
		.sdram_wire_ba         (<connected-to-sdram_wire_ba>),         //               .ba
		.sdram_wire_cas_n      (<connected-to-sdram_wire_cas_n>),      //               .cas_n
		.sdram_wire_cke        (<connected-to-sdram_wire_cke>),        //               .cke
		.sdram_wire_cs_n       (<connected-to-sdram_wire_cs_n>),       //               .cs_n
		.sdram_wire_dq         (<connected-to-sdram_wire_dq>),         //               .dq
		.sdram_wire_dqm        (<connected-to-sdram_wire_dqm>),        //               .dqm
		.sdram_wire_ras_n      (<connected-to-sdram_wire_ras_n>),      //               .ras_n
		.sdram_wire_we_n       (<connected-to-sdram_wire_we_n>),       //               .we_n
		.sw_interface_export   (<connected-to-sw_interface_export>)    //   sw_interface.export
	);

