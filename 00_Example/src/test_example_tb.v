`timescale 1ns/1ps

module test_example_tb;

    // Testbench signals
    reg        clk;          // 1. Declare clock signal
    reg  [9:0] SW;
    wire [7:0] HEX0;
    wire [7:0] HEX1;
    wire [7:0] HEX2;
    wire [7:0] HEX3;
    wire [7:0] HEX4;
    wire [7:0] HEX5;

    // 2. Clock Generation (50 MHz = 20ns period)
    // #10 means toggle every 10ns, resulting in a 20ns cycle.
    always #10 clk = ~clk;

    // 3. Update the instantiation to include .clk(clk)
    test_example DUT (
        .clk(clk),           // Connect the clock
        .SW(SW),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;             // Initialize clock
        SW = 10'b0;

        // Wait a few cycles
        #20;

        // Note: Even though the logic is combinatorial, 
        // it is good practice to change inputs on the clock edge 
        // in simulation to keep waveforms clean.

        @(posedge clk);
        SW[3:0] = 4'h0;   // HEX0 should display 0
        SW[7:4] = 4'h1;   // HEX1 should display 1

        @(posedge clk);
        SW[3:0] = 4'h5;   // HEX0 = 5
        SW[7:4] = 4'hA;   // HEX1 = A

        @(posedge clk);
        SW[3:0] = 4'hF;   // HEX0 = F
        SW[7:4] = 4'hC;   // HEX1 = C

        @(posedge clk);
        SW[3:0] = 4'h2;   // HEX0 = 2
        SW[7:4] = 4'h9;   // HEX1 = 9

        #40;
        $display("Simulation complete.");
        $finish;
    end

endmodule