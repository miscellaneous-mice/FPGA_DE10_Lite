
module peripheral_interface (
	clk_clk,
	reset_reset_n,
	full_adder_signals_fa_a,
	full_adder_signals_fa_b,
	full_adder_signals_fa_sum,
	full_adder_signals_fa_carry,
	hex0_display_signals_input,
	hex0_display_signals_output,
	hex1_display_signals_input,
	hex1_display_signals_output,
	key_deboucer_signals_input,
	key_deboucer_signals_output);	

	input		clk_clk;
	input		reset_reset_n;
	input	[3:0]	full_adder_signals_fa_a;
	input	[3:0]	full_adder_signals_fa_b;
	output	[3:0]	full_adder_signals_fa_sum;
	output		full_adder_signals_fa_carry;
	input	[3:0]	hex0_display_signals_input;
	output	[7:0]	hex0_display_signals_output;
	input	[3:0]	hex1_display_signals_input;
	output	[7:0]	hex1_display_signals_output;
	input		key_deboucer_signals_input;
	output		key_deboucer_signals_output;
endmodule
