module avalon_switches_logic (
    // 1. Clock and Reset
    input  wire        clk,
    input  wire        reset,

    // 2. Avalon Memory Mapped Slave Interface
    // Even if we have only 1 register, we include address/read for the bus
    input  wire [0:0]  avs_s0_address,     
    input  wire        avs_s0_read,        
    output reg  [31:0] avs_s0_readdata,

    // 3. Conduit Interface (The physical pins on the DE10-Lite)
    input  wire [9:0]  SW
);

    // Internal registers for synchronization
    // This protects the Nios II from asynchronous signal timing issues
    reg [9:0] sw_sync_reg1;
    reg [9:0] sw_sync_reg2;

    // ==========================================
    // Synchronizer Logic
    // ==========================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sw_sync_reg1 <= 10'b0;
            sw_sync_reg2 <= 10'b0;
        end 
        else begin
            // Double-flop synchronizer
            sw_sync_reg1 <= SW;
            sw_sync_reg2 <= sw_sync_reg1;
        end
    end

    // ==========================================
    // Avalon Read Logic
    // ==========================================
    always @(*) begin
        if (avs_s0_read) begin
            // Return the 10-bit switch value padded with 22 zeros
            avs_s0_readdata = {22'b0, sw_sync_reg2};
        end
        else begin
            // Standard practice: output 0 when not being read
            avs_s0_readdata = 32'b0;
        end
    end

endmodule