module data_sampler (
    input  wire        clk,
    input  wire        reset,
    
    // 1. The Raw Physical Pins (Conduit)
    input  wire [35:0] gpio_in,
    
    // 2. The Avalon Streaming Output (to DMA)
    output reg  [63:0] aso_data,    // DMA data width must be 64 bits
    output reg         aso_valid,
    input  wire        aso_ready
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            aso_data  <= 64'd0;
            aso_valid <= 1'b0;
        end else begin
            if (aso_ready) begin
                // Pad the 36 pins with 28 zeros to make a perfect 64-bit word
                aso_data  <= {28'd0, gpio_in}; 
                aso_valid <= 1'b1; 
            end else begin
                aso_valid <= 1'b0;
            end
        end
    end

endmodule