module D_register (
    input clk,
    input n_rst,
    input [31:0] in,
    output reg [31:0] out
);

    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            out <= 32'h00000000;
        end
        else begin
            out <= in;
        end
    end

endmodule
