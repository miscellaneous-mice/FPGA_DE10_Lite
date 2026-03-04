module avalon_counter_logic #(
    parameter INITIAL_MAX_COUNT = 32'd100,
    parameter INITIAL_SPEED     = 32'd5000000
)(
    input  wire        clk,
    input  wire        reset,

    // Avalon Memory Mapped Slave
    input  wire [1:0]  avs_s0_address,     
    input  wire        avs_s0_write,       
    input  wire [31:0] avs_s0_writedata,   
    input  wire        avs_s0_read,        
    output reg  [31:0] avs_s0_readdata    
);

    reg [31:0] counter_val; 
    reg        running;
    reg [31:0] speed_limit;
    reg [31:0] max_count;
    reg [31:0] timer;

    // --- Counter and Write Logic ---
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            running     <= 1'b0;
            counter_val <= 32'd0;
            timer       <= 32'd0;
            max_count   <= INITIAL_MAX_COUNT; 
            speed_limit <= INITIAL_SPEED;
        end 
        else begin
            if (avs_s0_write) begin
                case (avs_s0_address)
                    2'b00: begin // 0x0: Control
                        running <= avs_s0_writedata[0];
                        if (avs_s0_writedata[1]) counter_val <= 32'd0; // Soft Reset
                    end
                    2'b01: begin // 0x4: Manual Count Set (Optional)
                        counter_val <= avs_s0_writedata;
                    end
                    2'b10: begin // 0x8: Speed
                        speed_limit <= avs_s0_writedata;
                    end
                    2'b11: begin // 0xC: Max
                        max_count <= avs_s0_writedata;
                    end
                endcase
            end

            if (running) begin
                if (timer < speed_limit) begin
                    timer <= timer + 1'b1;
                end 
                else begin
                    timer <= 32'd0;
                    if (counter_val >= max_count) counter_val <= 32'd0;
                    else counter_val <= counter_val + 1'b1;
                end
            end
        end
    end

    // --- Clocked Read Logic (Latency = 1) ---
    always @(posedge clk) begin
        if (avs_s0_read) begin
            case (avs_s0_address)
                2'b00: avs_s0_readdata <= {31'b0, running};
                2'b01: avs_s0_readdata <= counter_val;
                2'b10: avs_s0_readdata <= speed_limit;
                2'b11: avs_s0_readdata <= max_count;
                default: avs_s0_readdata <= 32'hDEADBEEF;
            endcase
        end
    end
endmodule