module kalman_filter (
    input  wire        clk_50,
	 input  wire  [1:0] KEY,      // Pushbuttons (Active Low)
	 output wire        fpga_led, // PLL Locked status

    // ---------------------------------------------------------
    // Physical SDRAM Pins
    // ---------------------------------------------------------
    output wire [12:0] DRAM_ADDR,
    output wire [1:0]  DRAM_BA,
    output wire        DRAM_CAS_N,
    output wire        DRAM_CKE,
    output wire        DRAM_CLK,
    output wire        DRAM_CS_N,
    inout  wire [15:0] DRAM_DQ,
    output wire        DRAM_LDQM,  // Lower byte mask
    output wire        DRAM_UDQM,  // Upper byte mask
    output wire        DRAM_RAS_N,
    output wire        DRAM_WE_N
);

	kalman_interface u0 (
		.clk_clk          					(clk_50),
		
		// PLL Reset & Lock Signals
		.pll_areset_export               (~KEY[1]),                
		.pll_locked_export               (fpga_led), 
		
		// SDRAM Interface Mapping
		.sdram_clk_clk                   (DRAM_CLK),               
		.sdram_wire_addr                 (DRAM_ADDR),         
		.sdram_wire_ba                   (DRAM_BA),           
		.sdram_wire_cas_n                (DRAM_CAS_N),        
		.sdram_wire_cke                  (DRAM_CKE),          
		.sdram_wire_cs_n                 (DRAM_CS_N),         
		.sdram_wire_dq                   (DRAM_DQ),           

		// Concatenate Upper and Lower masks for the 2-bit Qsys bus
		.sdram_wire_dqm                  ({DRAM_UDQM, DRAM_LDQM}), 

		.sdram_wire_ras_n                (DRAM_RAS_N),        
		.sdram_wire_we_n                 (DRAM_WE_N)  
	);

endmodule