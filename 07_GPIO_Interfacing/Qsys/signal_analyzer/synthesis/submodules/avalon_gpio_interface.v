module avalon_gpio_interface (
    // 1. Clock and Reset
    input  wire        clk,
    input  wire        reset,

    // 2. Avalon Memory Mapped Slave Interface (For Nios II Control)
    input  wire [1:0]  avs_s0_address,     
    input  wire        avs_s0_write,       
    input  wire [31:0] avs_s0_writedata,   
    input  wire        avs_s0_read,        
    output reg  [31:0] avs_s0_readdata,

    // 3. Avalon Streaming Source (For the DMA Logic Analyzer)
    output reg  [63:0] aso_data,
    output reg         aso_valid,
    input  wire        aso_ready,

    // 4. Conduit Interface (Physical GPIO pins)
    inout  wire [35:0] GPIO
);

    // Registers to hold state
    reg [35:0] gpio_out_reg; 
    reg [35:0] gpio_dir_reg; 
    reg [35:0] gpio_in_sync; 
    reg [35:0] gpio_in_tmp;  

    // ==========================================
    // Avalon Write & Read Logic (Memory Mapped)
    // ==========================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            gpio_out_reg <= 36'h0;
            gpio_dir_reg <= 36'h0; // Default all to Input for safety
        end else if (avs_s0_write) begin
            case (avs_s0_address)
                2'h0: gpio_out_reg[31:0]  <= avs_s0_writedata;
                2'h1: gpio_out_reg[35:32] <= avs_s0_writedata[3:0];
                2'h2: gpio_dir_reg[31:0]  <= avs_s0_writedata;
                2'h3: gpio_dir_reg[35:32] <= avs_s0_writedata[3:0];
            endcase
        end
    end

    always @(*) begin
        case (avs_s0_address)
            2'h0: avs_s0_readdata = gpio_in_sync[31:0];
            2'h1: avs_s0_readdata = {28'h0, gpio_in_sync[35:32]};
            2'h2: avs_s0_readdata = gpio_dir_reg[31:0];
            2'h3: avs_s0_readdata = {28'h0, gpio_dir_reg[35:32]};
            default: avs_s0_readdata = 32'h0;
        endcase
    end

    // ==========================================
    // Tri-state Buffer and Input Synchronization
    // ==========================================
    genvar i;
    generate
        for (i = 0; i < 36; i = i + 1) begin : gpio_gen
            assign GPIO[i] = gpio_dir_reg[i] ? gpio_out_reg[i] : 1'bz;
        end
    endgenerate

    always @(posedge clk) begin
        gpio_in_tmp  <= GPIO;        
        gpio_in_sync <= gpio_in_tmp; // Clean, synchronized data
    end

    // ==========================================
    // NEW & CORRECTED: Streaming Logic
    // ==========================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            aso_data  <= 64'd0;
            aso_valid <= 1'b0;
        end else begin
            // We DO NOT wait for aso_ready.
            // A hardware sampler is an "always-on" continuous data source.
            // We constantly output the latest pin state and hold valid high.
            aso_data  <= {28'd0, gpio_in_sync};
            aso_valid <= 1'b1; 
        end
    end

endmodule