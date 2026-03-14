	signal_analyzer u0 (
		.clk_clk                              (<connected-to-clk_clk>),                              //                clk.clk
		.gpio_dma_interface_writebyteenable_n (<connected-to-gpio_dma_interface_writebyteenable_n>), // gpio_dma_interface.writebyteenable_n
		.gpio_interface_export                (<connected-to-gpio_interface_export>),                //     gpio_interface.export
		.pll_areset_export                    (<connected-to-pll_areset_export>),                    //         pll_areset.export
		.pll_locked_export                    (<connected-to-pll_locked_export>),                    //         pll_locked.export
		.sdram_clk_clk                        (<connected-to-sdram_clk_clk>),                        //          sdram_clk.clk
		.sdram_wire_addr                      (<connected-to-sdram_wire_addr>),                      //         sdram_wire.addr
		.sdram_wire_ba                        (<connected-to-sdram_wire_ba>),                        //                   .ba
		.sdram_wire_cas_n                     (<connected-to-sdram_wire_cas_n>),                     //                   .cas_n
		.sdram_wire_cke                       (<connected-to-sdram_wire_cke>),                       //                   .cke
		.sdram_wire_cs_n                      (<connected-to-sdram_wire_cs_n>),                      //                   .cs_n
		.sdram_wire_dq                        (<connected-to-sdram_wire_dq>),                        //                   .dq
		.sdram_wire_dqm                       (<connected-to-sdram_wire_dqm>),                       //                   .dqm
		.sdram_wire_ras_n                     (<connected-to-sdram_wire_ras_n>),                     //                   .ras_n
		.sdram_wire_we_n                      (<connected-to-sdram_wire_we_n>)                       //                   .we_n
	);

