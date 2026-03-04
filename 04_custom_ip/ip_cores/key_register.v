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