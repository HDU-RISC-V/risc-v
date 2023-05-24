module IM(
    input [5:0] IM_Addr,
    input clk_im,
    output reg [31:0] Inst_Code
);

reg [31:0] Inst_Mem [63:0];

integer i;
initial begin
    for (i = 0; i < 64; i = i + 1) begin
        Inst_Mem[i] = 0;
    end
end

always @(posedge clk_im) begin
    Inst_Code <= Inst_Mem[IM_Addr];
end

endmodule