`timescale 1ns/1ps

module full_adder_tb;

    // -------------------------
    // DUT signals
    // -------------------------
    reg         CLOCK_50;
    reg  [9:0]  SW;
    reg  [0:0]  KEY;

    wire [7:0]  HEX0;
    wire [7:0]  HEX1;
    wire [7:0]  HEX2;
    wire [7:0]  HEX3;
    wire [7:0]  HEX4;
    wire [7:0]  HEX5;

    // -------------------------
    // Instantiate DUT
    // -------------------------
    full_adder dut (
        .CLOCK_50(CLOCK_50),
        .SW(SW),
        .KEY(KEY),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

    // -------------------------
    // 50 MHz clock (20 ns period)
    // -------------------------
    initial CLOCK_50 = 0;
    always #10 CLOCK_50 = ~CLOCK_50;

    // -------------------------
    // Task: press KEY0 (debounced)
    // -------------------------
    task press_key0;
    begin
        KEY[0] = 1'b0;                  // press (active-low)
        #(20_000_000);                  // 20 ms > debounce time
        KEY[0] = 1'b1;                  // release
        #(5_000_000);                   // wait
    end
    endtask

    // -------------------------
    // Test sequence
    // -------------------------
    initial begin
        // ---------------------
        // Initial conditions
        // ---------------------
        SW  = 10'd0;
        KEY = 1'b1;                     // not pressed

        // Wait for power-up
        #(100_000);

        // =====================
        // STEP 1: Enter A = 5
        // =====================
        SW[3:0] = 4'd5;
        #(1_000_000);

        press_key0;                     // latch A

        // =====================
        // STEP 2: Enter B = 3
        // =====================
        SW[3:0] = 4'd3;
        #(1_000_000);

        press_key0;                     // latch B

        // =====================
        // STEP 3: SHOW result
        // Expected: SUM=8, CARRY=0
        // =====================
        #(5_000_000);

        // =====================
        // STEP 4: Advance FSM
        // =====================
        press_key0;                     // return to READ_A

        // =====================
        // STEP 5: Another test
        // A=15, B=1 → SUM=0, C=1
        // =====================
        SW[3:0] = 4'd15;
        #(1_000_000);
        press_key0;

        SW[3:0] = 4'd1;
        #(1_000_000);
        press_key0;

        #(5_000_000);

        $finish;
    end

endmodule