	component peripheral_interface is
		port (
			clk_clk                     : in  std_logic                    := 'X';             -- clk
			reset_reset_n               : in  std_logic                    := 'X';             -- reset_n
			full_adder_signals_fa_a     : in  std_logic_vector(3 downto 0) := (others => 'X'); -- fa_a
			full_adder_signals_fa_b     : in  std_logic_vector(3 downto 0) := (others => 'X'); -- fa_b
			full_adder_signals_fa_sum   : out std_logic_vector(3 downto 0);                    -- fa_sum
			full_adder_signals_fa_carry : out std_logic;                                       -- fa_carry
			hex0_display_signals_input  : in  std_logic_vector(3 downto 0) := (others => 'X'); -- input
			hex0_display_signals_output : out std_logic_vector(7 downto 0);                    -- output
			hex1_display_signals_input  : in  std_logic_vector(3 downto 0) := (others => 'X'); -- input
			hex1_display_signals_output : out std_logic_vector(7 downto 0);                    -- output
			key_deboucer_signals_input  : in  std_logic                    := 'X';             -- input
			key_deboucer_signals_output : out std_logic                                        -- output
		);
	end component peripheral_interface;

	u0 : component peripheral_interface
		port map (
			clk_clk                     => CONNECTED_TO_clk_clk,                     --                  clk.clk
			reset_reset_n               => CONNECTED_TO_reset_reset_n,               --                reset.reset_n
			full_adder_signals_fa_a     => CONNECTED_TO_full_adder_signals_fa_a,     --   full_adder_signals.fa_a
			full_adder_signals_fa_b     => CONNECTED_TO_full_adder_signals_fa_b,     --                     .fa_b
			full_adder_signals_fa_sum   => CONNECTED_TO_full_adder_signals_fa_sum,   --                     .fa_sum
			full_adder_signals_fa_carry => CONNECTED_TO_full_adder_signals_fa_carry, --                     .fa_carry
			hex0_display_signals_input  => CONNECTED_TO_hex0_display_signals_input,  -- hex0_display_signals.input
			hex0_display_signals_output => CONNECTED_TO_hex0_display_signals_output, --                     .output
			hex1_display_signals_input  => CONNECTED_TO_hex1_display_signals_input,  -- hex1_display_signals.input
			hex1_display_signals_output => CONNECTED_TO_hex1_display_signals_output, --                     .output
			key_deboucer_signals_input  => CONNECTED_TO_key_deboucer_signals_input,  -- key_deboucer_signals.input
			key_deboucer_signals_output => CONNECTED_TO_key_deboucer_signals_output  --                     .output
		);

