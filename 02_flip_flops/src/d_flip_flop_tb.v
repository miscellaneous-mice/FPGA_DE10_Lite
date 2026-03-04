`timescale 1ns/1ps

module d_flip_flop_tb;

    reg         CLOCK_50;
    reg  [9:0]  SW;
    reg  [0:0]  KEY;
    wire [7:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    // Instantiate with the name UUT
    d_flip_flop UUT (
        .CLOCK_50(CLOCK_50),
        .SW(SW),
        .KEY(KEY),
        .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), 
        .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5)
    );

    always #10 CLOCK_50 = ~CLOCK_50;

    initial begin
        CLOCK_50 = 0;
        SW = 10'b0;
        KEY = 1'b1;     
        
        #100;
        
        // 1. Set Switches
        SW[3:0] = 4'h3; 
        
        // 2. Press Key (Hold for a long time to pass debouncer)
        // If you don't use 'force', you must wait > 20ms in simulation time
        KEY[0] = 0; 
        #25000000; // Wait 25ms for the debouncer
        KEY[0] = 1;

        #1000000;
        $stop; // Pauses simulation so you can look at waveforms
    end

endmodule