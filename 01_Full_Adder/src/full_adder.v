module full_adder (
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

    // FSM states
    localparam READ_A = 2'd0,
               READ_B = 2'd1,
               SHOW   = 2'd2;

    reg [1:0] state = READ_A;

    reg [3:0] A, B;
    wire [3:0] SUM;
    wire CARRY;

    reg [3:0] hex0_val, hex1_val;

    // Full adder
    full_adder_4bit FA (
        .a(A),
        .b(B),
        .sum(SUM),
        .carry(CARRY)
    );

    // Debounced KEY0
    wire key_pressed;
    key_debounce DB (
        .clk(CLOCK_50),
        .key_n(KEY[0]),
        .key_pulse(key_pressed)
    );

    // FSM
    always @(posedge CLOCK_50) begin
        if (key_pressed) begin
            case (state)
                READ_A: begin
                    A <= SW[3:0];
                    state <= READ_B;
                end
                READ_B: begin
                    B <= SW[3:0];
                    state <= SHOW;
                end
                SHOW: begin
                    state <= READ_A;
                end
            endcase
        end
    end

    // Display selection
    always @(*) begin
        hex0_val = 4'h0;
        hex1_val = 4'h0;

        case (state)
            READ_A: hex0_val = SW[3:0];
            READ_B: hex0_val = SW[3:0];
            SHOW: begin
                hex0_val = SUM;
                hex1_val = {3'b000, CARRY};
            end
        endcase
    end

    // 7-segment decoders (your code)
    HexDigit_Decoder D0 (.hex_input(hex0_val), .seg_output(HEX0));
    HexDigit_Decoder D1 (.hex_input(hex1_val), .seg_output(HEX1));

    // Disable unused HEX displays
    assign HEX2 = 8'hFF;
    assign HEX3 = 8'hFF;
    assign HEX4 = 8'hFF;
    assign HEX5 = 8'hFF;

endmodule


module full_adder_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [3:0] sum,
    output wire       carry
);
    assign {carry, sum} = a + b;
endmodule


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
            if (cnt < 20'd1_000_000)
                cnt <= cnt + 1;
            else if (!stable_pressed) begin
                stable_pressed <= 1'b1;
                key_pulse <= 1'b1;   // ONE pulse
            end
        end else begin
            cnt <= 0;
            stable_pressed <= 1'b0; // <<< THIS IS CRITICAL
        end
    end
endmodule




// =============================
// Decoder Module
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