module avalon_gpio_logic (
    // 1. Clock and Reset
    input  wire        clk,
    input  wire        reset,

    // 2. Avalon Memory Mapped Slave Interface
    input  wire [1:0]  avs_s0_address,     // 2 bits for 4 registers
    input  wire        avs_s0_write,       
    input  wire [31:0] avs_s0_writedata,   
    input  wire        avs_s0_read,        
    output reg  [31:0] avs_s0_readdata,

    // 3. Conduit Interface (Physical GPIO pins)
    inout  wire [35:0] GPIO
);

    // Registers to hold state
    reg [35:0] gpio_out_reg; // Data to drive out
    reg [35:0] gpio_dir_reg; // 1 = Output, 0 = Input
    reg [35:0] gpio_in_sync;  // Synchronized input from pins
    reg [35:0] gpio_in_tmp;   // Intermediate sync stage

    // ==========================================
    // Avalon Write Logic
    // ==========================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            gpio_out_reg <= 36'h0;
            gpio_dir_reg <= 36'h0; // Default all to Input for safety
        end 
        else if (avs_s0_write) begin
            case (avs_s0_address)
                2'h0: gpio_out_reg[31:0]  <= avs_s0_writedata;
                2'h1: gpio_out_reg[35:32] <= avs_s0_writedata[3:0];
                2'h2: gpio_dir_reg[31:0]  <= avs_s0_writedata;
                2'h3: gpio_dir_reg[35:32] <= avs_s0_writedata[3:0];
            endcase
        end
    end

    // ==========================================
    // Avalon Read Logic
    // ==========================================
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
    
    // 1. Bidirectional Buffer logic
    // If dir is 1, drive the pin. If dir is 0, set to High-Impedance (Z)
    genvar i;
    generate
        for (i = 0; i < 36; i = i + 1) begin : gpio_gen
            assign GPIO[i] = gpio_dir_reg[i] ? gpio_out_reg[i] : 1'bz;
        end
    endgenerate

    // 2. Synchronize inputs to avoid metastability
    always @(posedge clk) begin
        gpio_in_tmp  <= GPIO;        // Sample the pins
        gpio_in_sync <= gpio_in_tmp;  // Double-flop
    end

endmodule