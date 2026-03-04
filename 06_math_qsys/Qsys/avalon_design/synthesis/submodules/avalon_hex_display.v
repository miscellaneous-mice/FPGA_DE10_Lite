module avalon_display_logic (
    // 1. Clock and Reset
    input  wire        clk,
    input  wire        reset,

    // 2. Avalon Memory Mapped Slave Interface
    input  wire [0:0]  avs_s0_address,     // Address (We only need 1 register)
    input  wire        avs_s0_write,       
    input  wire [31:0] avs_s0_writedata,   
    input  wire        avs_s0_read,        
    output reg  [31:0] avs_s0_readdata,

    // 3. Conduit Interface (The physical pins)
    output wire [7:0]  HEX0,
    output wire [7:0]  HEX1,
    output wire [7:0]  HEX2,
    output wire [7:0]  HEX3,
    output wire [7:0]  HEX4,
    output wire [7:0]  HEX5
);

    // This register holds the value Nios wants to display
    // [3:0]   -> HEX0
    // [7:4]   -> HEX1
    // [11:8]  -> HEX2
    // [15:12] -> HEX3
    // [19:16] -> HEX4
    // [23:20] -> HEX5
    reg [23:0] display_value;

    // ==========================================
    // Avalon Write Logic
    // ==========================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            display_value <= 24'h000000;
        end 
        else if (avs_s0_write) begin
            // We only have one register at address 0
            display_value <= avs_s0_writedata[23:0];
        end
    end

    // ==========================================
    // Avalon Read Logic
    // ==========================================
    always @(*) begin
        avs_s0_readdata = {8'b0, display_value};
    end

    // ==========================================
    // 7-Segment Mapping
    // ==========================================
    
    // Map nibbles of the register to the Decoders
    HexDigit_Decoder D0 (.hex_input(display_value[3:0]),   .seg_output(HEX0));
    HexDigit_Decoder D1 (.hex_input(display_value[7:4]),   .seg_output(HEX1));
    HexDigit_Decoder D2 (.hex_input(display_value[11:8]),  .seg_output(HEX2));
    HexDigit_Decoder D3 (.hex_input(display_value[15:12]), .seg_output(HEX3));
    HexDigit_Decoder D4 (.hex_input(display_value[19:16]), .seg_output(HEX4));
    HexDigit_Decoder D5 (.hex_input(display_value[23:20]), .seg_output(HEX5));

endmodule

// ==========================================
// Hex Decoder Module (Included in same file)
// ==========================================
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
            default: seg_output = 8'b11111111; // Off
        endcase
    end
endmodule