module avalon_pushbuttons_logic #(
    // 50 MHz clock: 1,000,000 ticks = 20 milliseconds (standard debounce time)
    parameter DEBOUNCE_LIMIT = 20'd1_000_000
)(
    // 1. Clock and Reset
    input  wire        clk,
    input  wire        reset,

    // 2. Avalon Memory Mapped Slave Interface (Read Only)
    // 1-bit address allows 2 separate registers (0x0 for KEY[0], 0x4 for KEY[1])
    input  wire [0:0]  avs_s0_address,     
    input  wire        avs_s0_read,        
    output reg  [31:0] avs_s0_readdata,

    // 3. Conduit Interface (Physical Keys on DE10-Lite)
    input  wire [1:0]  KEY
);

    // --- Synchronization Registers ---
    reg [1:0] key_sync_0;
    reg [1:0] key_sync_1;
    
    // --- Debounce Registers ---
    reg [19:0] debounce_cnt_0;
    reg [19:0] debounce_cnt_1;
    
    reg key_state_0, key_state_1;
    reg key_debounced_0, key_debounced_1;

    // ==========================================
    // 1. Synchronize and Invert Inputs
    // ==========================================
    // DE10-Lite keys are active-low (0 = pressed). 
    // We invert them (~KEY) so software sees 1 = pressed.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            key_sync_0 <= 2'b00;
            key_sync_1 <= 2'b00;
        end else begin
            key_sync_0 <= ~KEY; 
            key_sync_1 <= key_sync_0;
        end
    end

    // ==========================================
    // 2. Independent Debounce Logic
    // ==========================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            debounce_cnt_0  <= 20'd0;
            debounce_cnt_1  <= 20'd0;
            key_state_0     <= 1'b0;
            key_state_1     <= 1'b0;
            key_debounced_0 <= 1'b0;
            key_debounced_1 <= 1'b0;
        end else begin
            // --- Debounce KEY[0] ---
            if (key_sync_1[0] == key_state_0) begin
                if (debounce_cnt_0 < DEBOUNCE_LIMIT)
                    debounce_cnt_0 <= debounce_cnt_0 + 1'b1;
                else
                    key_debounced_0 <= key_state_0; // State is stable
            end else begin
                debounce_cnt_0 <= 20'd0;            // Reset timer on bounce
                key_state_0    <= key_sync_1[0];
            end

            // --- Debounce KEY[1] ---
            if (key_sync_1[1] == key_state_1) begin
                if (debounce_cnt_1 < DEBOUNCE_LIMIT)
                    debounce_cnt_1 <= debounce_cnt_1 + 1'b1;
                else
                    key_debounced_1 <= key_state_1; // State is stable
            end else begin
                debounce_cnt_1 <= 20'd0;            // Reset timer on bounce
                key_state_1    <= key_sync_1[1];
            end
        end
    end

    // ==========================================
    // 3. Avalon Read Logic (Combinational)
    // ==========================================
    // Reads them separately based on the address line
    always @(*) begin
        if (avs_s0_read) begin
            case (avs_s0_address)
                1'b0: avs_s0_readdata = {31'b0, key_debounced_0}; // Read KEY[0]
                1'b1: avs_s0_readdata = {31'b0, key_debounced_1}; // Read KEY[1]
            endcase
        end else begin
            avs_s0_readdata = 32'b0; // Default when not being read
        end
    end

endmodule