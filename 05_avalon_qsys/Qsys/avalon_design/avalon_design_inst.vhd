	component avalon_design is
		port (
			clk_clk                 : in  std_logic                    := 'X';             -- clk
			hex_interface_hex_0     : out std_logic_vector(7 downto 0);                    -- hex_0
			hex_interface_hex_1     : out std_logic_vector(7 downto 0);                    -- hex_1
			hex_interface_hex_2     : out std_logic_vector(7 downto 0);                    -- hex_2
			hex_interface_hex_3     : out std_logic_vector(7 downto 0);                    -- hex_3
			hex_interface_hex_4     : out std_logic_vector(7 downto 0);                    -- hex_4
			hex_interface_hex_5     : out std_logic_vector(7 downto 0);                    -- hex_5
			led_interface_export    : out std_logic;                                       -- export
			button_interface_export : in  std_logic_vector(1 downto 0) := (others => 'X')  -- export
		);
	end component avalon_design;

	u0 : component avalon_design
		port map (
			clk_clk                 => CONNECTED_TO_clk_clk,                 --              clk.clk
			hex_interface_hex_0     => CONNECTED_TO_hex_interface_hex_0,     --    hex_interface.hex_0
			hex_interface_hex_1     => CONNECTED_TO_hex_interface_hex_1,     --                 .hex_1
			hex_interface_hex_2     => CONNECTED_TO_hex_interface_hex_2,     --                 .hex_2
			hex_interface_hex_3     => CONNECTED_TO_hex_interface_hex_3,     --                 .hex_3
			hex_interface_hex_4     => CONNECTED_TO_hex_interface_hex_4,     --                 .hex_4
			hex_interface_hex_5     => CONNECTED_TO_hex_interface_hex_5,     --                 .hex_5
			led_interface_export    => CONNECTED_TO_led_interface_export,    --    led_interface.export
			button_interface_export => CONNECTED_TO_button_interface_export  -- button_interface.export
		);

