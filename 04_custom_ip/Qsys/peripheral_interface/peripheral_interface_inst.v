	peripheral_interface u0 (
		.clk_clk                     (<connected-to-clk_clk>),                     //                  clk.clk
		.reset_reset_n               (<connected-to-reset_reset_n>),               //                reset.reset_n
		.full_adder_signals_fa_a     (<connected-to-full_adder_signals_fa_a>),     //   full_adder_signals.fa_a
		.full_adder_signals_fa_b     (<connected-to-full_adder_signals_fa_b>),     //                     .fa_b
		.full_adder_signals_fa_sum   (<connected-to-full_adder_signals_fa_sum>),   //                     .fa_sum
		.full_adder_signals_fa_carry (<connected-to-full_adder_signals_fa_carry>), //                     .fa_carry
		.hex0_display_signals_input  (<connected-to-hex0_display_signals_input>),  // hex0_display_signals.input
		.hex0_display_signals_output (<connected-to-hex0_display_signals_output>), //                     .output
		.hex1_display_signals_input  (<connected-to-hex1_display_signals_input>),  // hex1_display_signals.input
		.hex1_display_signals_output (<connected-to-hex1_display_signals_output>), //                     .output
		.key_deboucer_signals_input  (<connected-to-key_deboucer_signals_input>),  // key_deboucer_signals.input
		.key_deboucer_signals_output (<connected-to-key_deboucer_signals_output>)  //                     .output
	);

