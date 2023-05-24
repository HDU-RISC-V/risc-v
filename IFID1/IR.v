module IR(
    input [31:0] IR_In,         // 输入指令 IR_In，32 位宽
    input IR_Write,             // 输入写使能信号 IR_Write
    input clk,                  // 输入时钟信号 clk
    output reg [31:0] IR_Out    // 输出指令 IR_Out，32 位宽
);

initial
begin
    IR_Out = 0;                // 初始化 IR_Out 为 0
end

always @(posedge clk) begin
    if (IR_Write) begin        // 如果 IR_Write 为有效写使能信号
        IR_Out <= IR_In;       // 将输入指令 IR_In 写入 IR_Out
    end
end

endmodule