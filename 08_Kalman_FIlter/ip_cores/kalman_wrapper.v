module kalman_wrapper #(
    parameter N = 32,
    parameter Q = 18
) (
    // 1. Clock and Reset
    input  wire        clk,
    input  wire        reset,        // Avalon reset is usually active high

    // 2. Avalon Memory Mapped Slave Interface
    input  wire [4:0]  avs_s0_address,     
    input  wire        avs_s0_write,       
    input  wire [31:0] avs_s0_writedata,   
    input  wire        avs_s0_read,        
    output reg  [31:0] avs_s0_readdata
);

    // Internal registers to hold inputs sent from Nios II
    reg signed [N-1:0] reg_valpha;
    reg signed [N-1:0] reg_vbeta;
    reg signed [N-1:0] reg_ialpham;
    reg signed [N-1:0] reg_ibetam;
    reg signed [N-1:0] reg_ctheta_t;
    reg signed [N-1:0] reg_stheta_t;
    reg signed [N-1:0] reg_nbSamples;

    // Wires to capture outputs from Kalman Filter
    wire signed [N-1:0] w_omega, w_theta;
    wire signed [N-1:0] w_ialphak, w_ibetak;
    wire signed [N-1:0] w_k00, w_k01, w_k10, w_k11, w_k20, w_k21, w_k30, w_k31;

    // ==========================================
    // Avalon Write Logic (Nios -> FPGA)
    // ==========================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_valpha   <= 0;
            reg_vbeta    <= 0;
            reg_ialpham  <= 0;
            reg_ibetam   <= 0;
            reg_ctheta_t <= 0;
            reg_stheta_t <= 0;
            reg_nbSamples <= 32'd100; // Default sample count
        end 
        else if (avs_s0_write) begin
            case (avs_s0_address)
                5'd0: reg_valpha    <= avs_s0_writedata;
                5'd1: reg_vbeta     <= avs_s0_writedata;
                5'd2: reg_ialpham   <= avs_s0_writedata;
                5'd3: reg_ibetam    <= avs_s0_writedata;
                5'd4: reg_ctheta_t  <= avs_s0_writedata;
                5'd5: reg_stheta_t  <= avs_s0_writedata;
                5'd6: reg_nbSamples <= avs_s0_writedata;
                default: ; // Do nothing
            endcase
        end
    end

    // ==========================================
    // Avalon Read Logic (FPGA -> Nios)
    // ==========================================
    always @(*) begin
        case (avs_s0_address)
            // Can read back inputs
            5'd0:  avs_s0_readdata = reg_valpha;
            5'd1:  avs_s0_readdata = reg_vbeta;
            
            // Read Kalman Outputs
            5'd7:  avs_s0_readdata = w_omega;
            5'd8:  avs_s0_readdata = w_theta;
            5'd9:  avs_s0_readdata = w_ialphak;
            5'd10: avs_s0_readdata = w_ibetak;
            5'd11: avs_s0_readdata = w_k00;
            5'd12: avs_s0_readdata = w_k01;
            5'd13: avs_s0_readdata = w_k10;
            5'd14: avs_s0_readdata = w_k11;
            5'd15: avs_s0_readdata = w_k20;
            5'd16: avs_s0_readdata = w_k21;
            5'd17: avs_s0_readdata = w_k30;
            5'd18: avs_s0_readdata = w_k31;
            default: avs_s0_readdata = 32'hDEADBEEF; // Error/Unknown address
        endcase
    end

    // ==========================================
    // Instantiate the Kalman Filter
    // ==========================================
    kalman #(
        .N(N),
        .Q(Q)
    ) kalman_inst (
        .clk(clk),
        .reset(!reset), // Inverting reset because kalman.txt uses negedge reset
        .valpha(reg_valpha),
        .vbeta(reg_vbeta),
        .ialpham(reg_ialpham),
        .ibetam(reg_ibetam),
        .ctheta_t(reg_ctheta_t),
        .stheta_t(reg_stheta_t),
        .nbSamples(reg_nbSamples),
        .omega(w_omega),
        .theta(w_theta),
        .ialphak(w_ialphak),
        .ibetak(w_ibetak),
        .kmatrix00(w_k00),
        .kmatrix01(w_k01),
        .kmatrix10(w_k10),
        .kmatrix11(w_k11),
        .kmatrix20(w_k20),
        .kmatrix21(w_k21),
        .kmatrix30(w_k30),
        .kmatrix31(w_k31)
    );

endmodule