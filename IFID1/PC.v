module PC(
    input [31:0] PC_In,        // 输入 PC_In，32 位宽
    input PC_Write,            // 输入 PC 写使能信号 PC_Write
    input clk,                 // 输入时钟信号 clk
    input rst_n,               // 输入复位信号 rst_n
    output reg [31:0] PC_Out   // 输出 PC_Out，32 位宽
);
initial begin
    PC_Out = 0;               // 初始化 PC_Out 为 0
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin         // 如果复位信号 rst_n 为低电平
        PC_Out <= 0;          // 将 PC_Out 置为 0
    end
    else if (PC_Write) begin  // 如果 PC_Write 为有效写使能信号
        PC_Out <= PC_In;      // 将输入 PC_In 写入 PC_Out
    end
end

endmodule