module FR (
    input clk,
    input rst_n,
    input [3:0] in,
    output [3:0] out
);
    
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= 4'b0000;
        end else begin
            out <= in;
        end
    end

endmodule