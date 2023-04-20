module D_register (
    input clk,           // 输入时钟信号
    input [31:0] in,     // 32位输入数据
    output reg [31:0] out // 32位输出数据
);

    // 在时钟信号上升沿，将输入数据存储到寄存器，并将其输出
    always @(posedge clk) begin
        out <= in;
    end

endmodule
