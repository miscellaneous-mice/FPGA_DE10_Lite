`timescale 1 ns / 1 ps

module div2_tb;

    // Inputs to the DUT (Device Under Test) - Declared as signed
    reg signed [31:0] tb_denom;
    reg signed [31:0] tb_numer;

    // Outputs from the DUT - Declared as signed
    wire signed [31:0] tb_quotient;
    wire signed [31:0] tb_remain;

    // Expected results
    reg signed [31:0] expected_quotient;
    reg signed [31:0] expected_remain;

    // Loop and temporary variables declared at module scope
    reg signed [31:0] rand_num;
    reg signed [31:0] rand_den;
    integer error_count;
    integer i;

    // Instantiate the Device Under Test (DUT)
    div2 uut (
        .denom(tb_denom),
        .numer(tb_numer),
        .quotient(tb_quotient),
        .remain(tb_remain)
    );

    // Stimulus block
    initial begin
        // Initialize inputs and error tracking
        tb_denom = 32'sd1;
        tb_numer = 32'sd0;
        error_count = 0;

        // Wait for global reset/initialization
        #100;

        $display("Starting Signed Division Testbench...");

        // Test Case 1: Positive / Positive
        run_test(32'sd100, 32'sd3);

        // Test Case 2: Negative / Positive
        run_test(-32'sd100, 32'sd3);

        // Test Case 3: Positive / Negative
        run_test(32'sd100, -32'sd3);

        // Test Case 4: Negative / Negative
        run_test(-32'sd100, -32'sd3);

        // Test Case 5: Numerator smaller than denominator
        run_test(32'sd5, 32'sd12);
        run_test(-32'sd5, 32'sd12);

        // Test Case 6: Division resulting in no remainder
        run_test(32'sd120, 32'sd10);
        run_test(-32'sd120, -32'sd10);

        // Test Case 7: Large signed values
        run_test(32'sd2147483647, 32'sd2);       // Max positive 32-bit signed
        run_test(-32'sd2147483648, 32'sd2);      // Min negative 32-bit signed
        run_test(-32'sd2147483648, -32'sd1);     // Overflow boundary case

        // Test Case 8: Random signed testing
        for (i = 0; i < 20; i = i + 1) begin
				// $urandom -> generate a pseudo-random, unsigned 32-bit integer
            rand_num = $urandom;
            rand_den = $urandom;
            
            // Ensure denominator is not zero to avoid division-by-zero exceptions in verification
            if (rand_den == 32'sd0) begin
                rand_den = 32'sd1;
            end
            
            run_test(rand_num, rand_den);
        end

        // Test Case 9: Division by Zero (Observation only)
        $display("\nTesting Division by Zero behavior (results may vary):");
        tb_numer = 32'sd50;
        tb_denom = 32'sd0;
        #10;
        $display("Input: %d / %d | Output Quotient: %d, Remainder: %d", 
                 tb_numer, tb_denom, tb_result_to_signed(tb_quotient), tb_result_to_signed(tb_remain));

        // Simulation Summary
        #10;
        $display("\n==================================");
        if (error_count == 0) begin
            $display("Simulation completed. All checked tests passed.");
        end else begin
            $display("Simulation completed with %d error(s).", error_count);
        end
        $display("==================================");
        $finish;
    end

    // Helper function to represent wire signals clearly in display
    function signed [31:0] tb_result_to_signed(input [31:0] val);
        tb_result_to_signed = val;
    endfunction
	 
	 
	 // Define signed limits (makes the code adaptable and self-documenting)
    localparam WIDTH = 32;
    localparam signed [WIDTH-1:0] SIGNED_MIN = {1'b1, {(WIDTH-1){1'b0}}}; // 32'h8000_0000 (-2147483648)
    localparam signed [WIDTH-1:0] SIGNED_MAX = {1'b0, {(WIDTH-1){1'b1}}}; // 32'h7FFF_FFFF ( 2147483647)
	 

    // Task to apply inputs and verify results
    task run_test(input signed [WIDTH-1:0] n, input signed [WIDTH-1:0] d);
        begin
            tb_numer = n;
            tb_denom = d;
            
            // General check for signed division overflow: MIN_INT / -1
            if (n == SIGNED_MIN && d == -1) begin
                // Typical hardware wrap-around behavior 
                expected_quotient = SIGNED_MIN; 
                expected_remain   = 0;
            end else begin
                expected_quotient = n / d;
                expected_remain   = n % d;
            end
            
            #10;
            
            if ((tb_quotient !== expected_quotient) || (tb_remain !== expected_remain)) begin
                $display("ERROR: %d / %d -> Got (Q: %d, R: %d) | Expected (Q: %d, R: %d)", 
                         tb_numer, tb_denom, 
                         tb_quotient, tb_remain, 
                         expected_quotient, expected_remain);
                error_count = error_count + 1;
            end else begin
                $display("PASS : %d / %d -> Q: %d, R: %d", 
                         tb_numer, tb_denom, tb_quotient, tb_remain);
            end
        end
    endtask

endmodule