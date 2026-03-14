	component signal_analyzer is
		port (
			clk_clk               : in    std_logic                     := 'X';             -- clk
			gpio_interface_export : inout std_logic_vector(35 downto 0) := (others => 'X'); -- export
			hex_interface_hex_0   : out   std_logic_vector(7 downto 0);                     -- hex_0
			hex_interface_hex_1   : out   std_logic_vector(7 downto 0);                     -- hex_1
			hex_interface_hex_2   : out   std_logic_vector(7 downto 0);                     -- hex_2
			hex_interface_hex_3   : out   std_logic_vector(7 downto 0);                     -- hex_3
			hex_interface_hex_4   : out   std_logic_vector(7 downto 0);                     -- hex_4
			hex_interface_hex_5   : out   std_logic_vector(7 downto 0);                     -- hex_5
			key_interface_export  : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			pll_areset_export     : in    std_logic                     := 'X';             -- export
			pll_locked_export     : out   std_logic;                                        -- export
			sdram_clk_clk         : out   std_logic;                                        -- clk
			sdram_wire_addr       : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba         : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n      : out   std_logic;                                        -- cas_n
			sdram_wire_cke        : out   std_logic;                                        -- cke
			sdram_wire_cs_n       : out   std_logic;                                        -- cs_n
			sdram_wire_dq         : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm        : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n      : out   std_logic;                                        -- ras_n
			sdram_wire_we_n       : out   std_logic;                                        -- we_n
			sw_interface_export   : in    std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component signal_analyzer;

	u0 : component signal_analyzer
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --            clk.clk
			gpio_interface_export => CONNECTED_TO_gpio_interface_export, -- gpio_interface.export
			hex_interface_hex_0   => CONNECTED_TO_hex_interface_hex_0,   --  hex_interface.hex_0
			hex_interface_hex_1   => CONNECTED_TO_hex_interface_hex_1,   --               .hex_1
			hex_interface_hex_2   => CONNECTED_TO_hex_interface_hex_2,   --               .hex_2
			hex_interface_hex_3   => CONNECTED_TO_hex_interface_hex_3,   --               .hex_3
			hex_interface_hex_4   => CONNECTED_TO_hex_interface_hex_4,   --               .hex_4
			hex_interface_hex_5   => CONNECTED_TO_hex_interface_hex_5,   --               .hex_5
			key_interface_export  => CONNECTED_TO_key_interface_export,  --  key_interface.export
			pll_areset_export     => CONNECTED_TO_pll_areset_export,     --     pll_areset.export
			pll_locked_export     => CONNECTED_TO_pll_locked_export,     --     pll_locked.export
			sdram_clk_clk         => CONNECTED_TO_sdram_clk_clk,         --      sdram_clk.clk
			sdram_wire_addr       => CONNECTED_TO_sdram_wire_addr,       --     sdram_wire.addr
			sdram_wire_ba         => CONNECTED_TO_sdram_wire_ba,         --               .ba
			sdram_wire_cas_n      => CONNECTED_TO_sdram_wire_cas_n,      --               .cas_n
			sdram_wire_cke        => CONNECTED_TO_sdram_wire_cke,        --               .cke
			sdram_wire_cs_n       => CONNECTED_TO_sdram_wire_cs_n,       --               .cs_n
			sdram_wire_dq         => CONNECTED_TO_sdram_wire_dq,         --               .dq
			sdram_wire_dqm        => CONNECTED_TO_sdram_wire_dqm,        --               .dqm
			sdram_wire_ras_n      => CONNECTED_TO_sdram_wire_ras_n,      --               .ras_n
			sdram_wire_we_n       => CONNECTED_TO_sdram_wire_we_n,       --               .we_n
			sw_interface_export   => CONNECTED_TO_sw_interface_export    --   sw_interface.export
		);

