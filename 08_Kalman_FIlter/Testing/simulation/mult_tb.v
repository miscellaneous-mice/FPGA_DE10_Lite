`timescale 1 ns / 1 ps

module mult_tb;

    // Inputs to the DUT (Device Under Test)
    reg [31:0] tb_dataa;
    reg [31:0] tb_datab;

    // Outputs from the DUT
    wire [63:0] tb_result;

    // Variables for verification
    reg [63:0] expected_result;
    integer i;
    integer error_count;

    // Instantiate the Device Under Test (DUT)
    mult uut (
        .dataa(tb_dataa),
        .datab(tb_datab),
        .result(tb_result)
    );

    // Stimulus generation
    initial begin
        // Initialize inputs and error counter
        tb_dataa = 32'h0;
        tb_datab = 32'h0;
        error_count = 0;

        // Wait for simulator initialization
        #100;

        // Test Case 1: Zero multiplication
        run_test(32'h0, 32'h0);

        // Test Case 2: Multiplications with 1
        run_test(32'h1, 32'h1);
        run_test(32'hA5A5_A5A5, 32'h1);

        // Test Case 3: Typical small values
        run_test(32'd1234, 32'd5678);

        // Test Case 4: Larger values
        run_test(32'h0000_FFFF, 32'h0000_FFFF);
        run_test(32'hFFFF_0000, 32'h0000_FFFF);

        // Test Case 5: Maximum unsigned values (Boundary conditions)
        run_test(32'hFFFF_FFFF, 32'h2);
        run_test(32'hFFFF_FFFF, 32'hFFFF_FFFF);

        // Test Case 6: Random values
        for (i = 0; i < 20; i = i + 1) begin
            run_test($urandom, $urandom);
        end

        // Simulation Summary
        #10;
        if (error_count == 0) begin
            $display("Simulation finished. All tests passed successfully.");
        end else begin
            $display("Simulation finished with %d mismatch(es).", error_count);
        end
        $finish;
    end

    // Task to apply inputs and verify output
    task run_test(input [31:0] a, input [31:0] b);
        begin
            tb_dataa = a;
            tb_datab = b;
            
            // Expected result calculated using 64-bit precision
            expected_result = {32'b0, a} * {32'b0, b};
            
            // Wait for combinational logic delay
            #10;
            
            if (tb_result !== expected_result) begin
                $display("ERROR at time %t: %d * %d = %d (Expected: %d)", 
                         $time, tb_dataa, tb_datab, tb_result, expected_result);
                error_count = error_count + 1;
            end else begin
                $display("PASS: %d * %d = %d", tb_dataa, tb_datab, tb_result);
            end
        end
    endtask

endmodule