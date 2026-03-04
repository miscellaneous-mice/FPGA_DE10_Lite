module counter_logic (
    input  wire        clk,          // System Clock (50MHz)
    input  wire        trigger,      // Signal from Nios II (The LED pin)
    output wire [7:0]  HEX0,         // Lower digit
    output wire [7:0]  HEX1,         // Upper digit
    output wire [7:0]  HEX2,         // Off
    output wire [7:0]  HEX3,         // Off
    output wire [7:0]  HEX4,         // Off
    output wire [7:0]  HEX5          // Off
);

    // =============================
    // Registers
    // =============================
    reg [7:0]  counter_val;  // 8-bit counter (00 to FF)
    reg        is_running;   // State flag
    reg [24:0] timer;        // Speed control
    
    // Previous state of the trigger to detect rising edge
    reg        trigger_prev; 

    // Speed: 50MHz / 5,000,000 = 10 increments per second (approx)
    localparam SPEED_LIMIT = 5000000; 

    // =============================
    // Edge Detection Logic (Fixed)
    // =============================
    // logic to detect 0 -> 1 transition must be OUTSIDE the always block
    wire trigger_rising_edge;
    assign trigger_rising_edge = (trigger == 1'b1 && trigger_prev == 1'b0);

    // =============================
    // Main Logic
    // =============================
    always @(posedge clk) begin
        
        // Update the history register for the NEXT cycle
        trigger_prev <= trigger;

        // 1. State Machine
        if (trigger_rising_edge) begin
            counter_val <= 8'd0;      // Reset counter to 0
            is_running  <= 1'b1;      // Start counting
            timer       <= SPEED_LIMIT;
        end
        else if (is_running) begin
            if (timer > 0) begin
                timer <= timer - 1'b1;
            end 
            else begin
                timer <= SPEED_LIMIT; // Reset timer
                
                // Check if we reached FF (255)
                if (counter_val == 8'hFF) begin
                    is_running <= 1'b0; // Stop
                end else begin
                    counter_val <= counter_val + 1'b1; // Increment
                end
            end
        end
    end

    // =============================
    // Display Instantiation
    // =============================
    
    // Lower 4 bits -> HEX0
    HexDigit_Decoder D0 (
        .hex_input(counter_val[3:0]),
        .seg_output(HEX0)
    );

    // Upper 4 bits -> HEX1
    HexDigit_Decoder D1 (
        .hex_input(counter_val[7:4]),
        .seg_output(HEX1)
    );

    // Turn off others
    assign HEX2 = 8'hFF;
    assign HEX3 = 8'hFF;
    assign HEX4 = 8'hFF;
    assign HEX5 = 8'hFF;

endmodule

// =============================
// Hex Decoder Helper
// =============================
module HexDigit_Decoder(
    input [3:0] hex_input,
    output reg [7:0] seg_output
);
    always @(*) begin
        case(hex_input)
            4'h0: seg_output = 8'b11000000;
            4'h1: seg_output = 8'b11111001; 
            4'h2: seg_output = 8'b10100100;
            4'h3: seg_output = 8'b10110000;
            4'h4: seg_output = 8'b10011001;
            4'h5: seg_output = 8'b10010010;
            4'h6: seg_output = 8'b10000010;
            4'h7: seg_output = 8'b11111000;
            4'h8: seg_output = 8'b10000000;
            4'h9: seg_output = 8'b10010000;
            4'hA: seg_output = 8'b10001000; 
            4'hB: seg_output = 8'b10000011;
            4'hC: seg_output = 8'b11000110;
            4'hD: seg_output = 8'b10100001;
            4'hE: seg_output = 8'b10000110;
            4'hF: seg_output = 8'b10001110;
            default: seg_output = 8'b11111111;
        endcase
    end
endmodule