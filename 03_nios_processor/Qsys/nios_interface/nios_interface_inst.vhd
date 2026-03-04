	component nios_interface is
		port (
			button_external_export : in  std_logic := 'X'; -- export
			clk_clk                : in  std_logic := 'X'; -- clk
			led_external_export    : out std_logic         -- export
		);
	end component nios_interface;

	u0 : component nios_interface
		port map (
			button_external_export => CONNECTED_TO_button_external_export, -- button_external.export
			clk_clk                => CONNECTED_TO_clk_clk,                --             clk.clk
			led_external_export    => CONNECTED_TO_led_external_export     --    led_external.export
		);

