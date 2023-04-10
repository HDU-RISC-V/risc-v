module D_register (
    input clk,
    input rst_n,
    input [31:0] in,
    output reg [31:0] out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= 32'h00000000;
        end
        else begin
            out <= in;
        end
    end

endmodule
