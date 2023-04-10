module FR (
    input clk,
    input rst_n,
    input [3:0] flag,
);
    
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            FR <= 4'b0000;
        end else begin
            FR <= flag;
        end
    end

endmodule