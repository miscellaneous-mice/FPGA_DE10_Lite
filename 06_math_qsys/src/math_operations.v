module math_operations (
    input  wire        clk_50,
    input  wire  [1:0] KEY,      // Pushbuttons (Active Low)
    input  wire  [9:0] SW,       // 10 Slide Switches
    output wire        fpga_led, // We will use this to show "PLL Locked"
    
    // 7-Segment Displays
    output wire  [7:0] HEX0,     
    output wire  [7:0] HEX1,
    output wire  [7:0] HEX2,
    output wire  [7:0] HEX3,
    output wire  [7:0] HEX4,
    output wire  [7:0] HEX5,

    // ---------------------------------------------------------
    // Physical SDRAM Pins (Must match DE10-Lite Pin Assignments)
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

    // Instantiate the Qsys system
    // The left side (.name) MUST exactly match the Qsys module ports.
    // The right side (name) MUST match the variables in this top-level module.
    avalon_design u0 (
        .clk_clk                 (clk_50),                 // 50MHz Clock input
        
        // 7-Segment Interfaces
        .display_interface_hex_0 (HEX0), 
        .display_interface_hex_1 (HEX1), 
        .display_interface_hex_2 (HEX2), 
        .display_interface_hex_3 (HEX3), 
        .display_interface_hex_4 (HEX4), 
        .display_interface_hex_5 (HEX5), 
        
        // Switch Interface
        .switch_interface_export (SW),                     // Map to physical switches
		  
		  // button Interface
		  .button_interface_export (KEY),                  
        
        // PLL Reset & Lock Signals
        // KEYs are active-low on DE10-Lite. PLL reset is active-high.
        // Therefore, we invert the KEY (~KEY[0]) to reset the PLL.
        .pll_areset_export       (~KEY[1]),                
        .pll_locked_export       (fpga_led),               // LED turns ON when clock is stable

        // ---------------------------------------------------------
        // SDRAM Interface Mapping
        // ---------------------------------------------------------
        .sdram_clk_clk           (DRAM_CLK),               // The -3ns shifted clock
        .sdram_wire_addr         (DRAM_ADDR),         
        .sdram_wire_ba           (DRAM_BA),           
        .sdram_wire_cas_n        (DRAM_CAS_N),        
        .sdram_wire_cke          (DRAM_CKE),          
        .sdram_wire_cs_n         (DRAM_CS_N),         
        .sdram_wire_dq           (DRAM_DQ),           
        
        // Qsys outputs a 2-bit DQM. DE10-Lite splits this into Upper and Lower.
        // We concatenate {Upper, Lower} to match the 2-bit Qsys bus.
        .sdram_wire_dqm          ({DRAM_UDQM, DRAM_LDQM}), 
        
        .sdram_wire_ras_n        (DRAM_RAS_N),        
        .sdram_wire_we_n         (DRAM_WE_N)          
    );

endmodule