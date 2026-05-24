`timescale 1 ns / 1 ps

module qmult_tb;

    parameter Q = 18;
    parameter N = 32;

    reg signed [N-1:0] tb_a;
    reg signed [N-1:0] tb_b;

    wire signed [N-1:0] tb_o_result;
    wire tb_ovr;

    reg signed [63:0] expected_mult;
    reg signed [N-1:0] expected_result;
    integer error_count;
    integer i;

    reg signed [N-1:0] rand_val_a;
    reg signed [N-1:0] rand_val_b;

    qmult #(
        .Q(Q),
        .N(N)
    ) uut (
        .a(tb_a),
        .b(tb_b),
        .o_result(tb_o_result),
        .ovr(tb_ovr)
    );

    real scale;

    initial begin
        scale = 262144.0; 
        error_count = 0;
        tb_a = 0;
        tb_b = 0;

        #100;

        $display("Starting Signed Fixed-Point Multiplier (Q14.18) Testbench...");
        $display("-----------------------------------------------------------------");

        // Specific Test Cases
        $display("\n[Test Case 1: Positive * Positive]");
        run_test(32'h0008_0000, 32'h000C_0000); 

        $display("\n[Test Case 2: Positive * Negative (Fractional)]");
        run_test(32'h0006_0000, 32'hFFFE_0000); 

        $display("\n[Test Case 3: Negative * Negative]");
        run_test(32'hFFF8_0000, 32'hFFFA_0000); 

        $display("\n[Test Case 4: Identity Multiplication]");
        run_test(32'hFFF0_0000, 32'h0004_0000); 

        $display("\n[Test Case 5: Underflow Check]");
        run_test(32'h0000_0400, 32'h0000_0080); 

        // Random Test Cases
        $display("\n[Running 15 Random Tests within safe range [-64.0, 64.0]]");
        for (i = 0; i < 15; i = i + 1) begin
            rand_val_a = ($urandom % 16777216) - 8388608; 
            rand_val_b = ($urandom % 16777216) - 8388608; 
            run_test(rand_val_a, rand_val_b);
        end

        #10;
        $display("-----------------------------------------------------------------");
        if (error_count == 0) begin
            $display("Simulation Finished: ALL TESTS PASSED.");
        end else begin
            $display("Simulation Finished: Failed with %d mismatches.", error_count);
        end
        $display("-----------------------------------------------------------------");
        $finish;
    end

    task run_test(input signed [N-1:0] a, input signed [N-1:0] b);
        begin
            tb_a = a;
            tb_b = b;

            expected_mult = $signed(a) * $signed(b);

            // Align verification math with the DUT's Symmetric Truncation
            if (expected_mult < 0) begin
                // For negative products: convert to positive, shift, then negate
                expected_result = -((-expected_mult) >>> Q);
            end else begin
                // For positive products: shift directly
                expected_result = expected_mult >>> Q;
            end

            #10;

            if (tb_o_result !== expected_result) begin
                $display("  ERROR: %f * %f", $itor(tb_a)/scale, $itor(tb_b)/scale);
                $display("    Expected: Hex %h (%f)", expected_result, $itor(expected_result)/scale);
                $display("    Got     : Hex %h (%f)", tb_o_result, $itor(tb_o_result)/scale);
                error_count = error_count + 1;
            end else begin
                $display("  PASS : %f * %f = %f (Hex: %h)", 
                         $itor(tb_a)/scale, 
                         $itor(tb_b)/scale, 
                         $itor(tb_o_result)/scale, 
                         tb_o_result);
            end
        end
    endtask

endmodule