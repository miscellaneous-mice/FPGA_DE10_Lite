module d_flip_flop (
    input  wire        CLOCK_50,
    input  wire [9:0]  SW,
    input  wire [0:0]  KEY,
    output wire [7:0]  HEX0,
    output wire [7:0]  HEX1,
    output wire [7:0]  HEX2,
    output wire [7:0]  HEX3,
    output wire [7:0]  HEX4,
    output wire [7:0]  HEX5
);

    // =============================
    // Registers (D Flip-Flops)
    // =============================
    reg [3:0]  counter;      // Stores the current count value
    reg        is_running;   // Status flag: 0 = Setup/Done, 1 = Counting
    reg [24:0] timer;        // Large counter for clock division (speed control)

    // Constant for speed (25,000,000 cycles @ 50MHz = 0.5 seconds)
    localparam SPEED_LIMIT = 25000000;

    // =============================
    // Debounced KEY0
    // =============================
    wire key_pressed;
    
    key_debounce DB (
        .clk(CLOCK_50),
        .key_n(KEY[0]),
        .key_pulse(key_pressed)
    );

    // =============================
    // Main Sequential Logic 
    // (Infers D Flip-Flops)
    // =============================
    always @(posedge CLOCK_50) begin
        
        // 1. Handle Key Press (Highest Priority)
        // Whenever Key0 is pressed, load switch value and start/restart
        if (key_pressed) begin
            counter    <= SW[3:0];       // Load input from switches
            is_running <= 1'b1;          // Start the counter
            timer      <= SPEED_LIMIT;   // Reset timer so we see the start value
        end
        
        // 2. Handle Automatic Counting
        else if (is_running) begin
            if (timer > 0) begin
                // Wait for timer to expire
                timer <= timer - 1'b1;
            end 
            else begin
                // Timer expired (approx 0.5s passed)
                timer <= SPEED_LIMIT; // Reset timer
                
                if (counter == 4'd0) begin
                    is_running <= 1'b0; // Stop when we hit 0
                end else begin
                    counter <= counter - 1'b1; // Decrement (DFF Update)
                end
            end
        end
        
        // 3. Idle State (is_running == 0)
        // No logic needed here, variables hold their state (D-Latch behavior avoided)
    end

    // =============================
    // Display Logic
    // =============================
    reg [3:0] hex_display_val;

    always @(*) begin
        // If counting, show the internal counter.
        // If done or waiting, show the current Switch settings so user knows what they are picking.
        if (is_running)
            hex_display_val = counter;
        else
            hex_display_val = SW[3:0];
    end

    // =============================
    // 7-segment Decoder Instantiation
    // =============================
    HexDigit_Decoder D0 (
        .hex_input(hex_display_val),
        .seg_output(HEX0)
    );

    // Turn off other displays
    assign HEX1 = 8'hFF;
    assign HEX2 = 8'hFF;
    assign HEX3 = 8'hFF;
    assign HEX4 = 8'hFF;
    assign HEX5 = 8'hFF;

endmodule


// =============================
// Debounce Module (Unchanged)
// =============================
module key_debounce (
    input  wire clk,
    input  wire key_n,
    output reg  key_pulse
);
    reg [19:0] cnt = 0;
    reg stable_pressed = 0;

    always @(posedge clk) begin
        key_pulse <= 1'b0;

        if (!key_n) begin
            // Wait ~20ms
            if (cnt < 20'd1_000_000)
                cnt <= cnt + 1;
            else if (!stable_pressed) begin
                stable_pressed <= 1'b1;
                key_pulse <= 1'b1;   // Generate one single pulse
            end
        end else begin
            cnt <= 0;
            stable_pressed <= 1'b0; 
        end
    end
endmodule


// =============================
// Hex Decoder (Unchanged)
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