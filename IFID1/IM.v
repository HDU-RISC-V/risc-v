module IM(
    input [5:0] IM_Addr,          // 输入指令地址 IM_Addr，6 位宽
    input clk_im,                // 输入时钟信号 clk_im
    output reg [31:0] Inst_Code   // 输出指令码 Inst_Code，32 位宽
);

reg [31:0] Inst_Mem [63:0];      // 内部寄存器数组 Inst_Mem，用于存储指令内存

integer i;
initial begin
    for (i = 0; i < 64; i = i + 1) begin
        Inst_Mem[i] = 0;         // 初始化指令内存，将所有元素置为 0
    end
end

always @(posedge clk_im) begin
    Inst_Code <= Inst_Mem[IM_Addr];  // 指令内存读取，根据 IM_Addr 地址输出相应的指令码到 Inst_Code
end

endmodule