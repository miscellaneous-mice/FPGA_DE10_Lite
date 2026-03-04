module nios_sw (
    input  wire       clk_50,
	 input  wire [1:0] KEY,      // Hardware Keys (KEY[0] and KEY[1])
    output wire       fpga_led, // Physical LED pin
    output wire [7:0] HEX0,     // 7-Seg Display
    output wire [7:0] HEX1,
    output wire [7:0] HEX2,
    output wire [7:0] HEX3,
    output wire [7:0] HEX4,
    output wire [7:0] HEX5
);

    // Internal wire to carry the signal from Nios to our Logic
    wire nios_pio_signal;

    // Assign the internal signal to the physical pin as well
    assign fpga_led = nios_pio_signal;

    // 1. Instantiate the Qsys system
    nios_interface u0 (
		  .button_external_export   (KEY[0]),
        .clk_clk                  (clk_50),   // System clock
        .led_external_export      (fpga_led)  // The new PIO connection
    );

    // 2. Instantiate the Custom Counter Logic
    counter_logic my_counter (
        .clk     (clk_50),
        .trigger (nios_pio_signal), // The Nios controls this input
        .HEX0    (HEX0),
        .HEX1    (HEX1),
        .HEX2    (HEX2),
        .HEX3    (HEX3),
        .HEX4    (HEX4),
        .HEX5    (HEX5)
    );

endmodule