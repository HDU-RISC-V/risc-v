module ADD (
    input [31:0] a,      // 输入端口 a，为 32 位宽
    input [31:0] b,      // 输入端口 b，为 32 位宽
    output [31:0] out    // 输出端口 out，为 32 位宽
);
    assign out = a + b;   // 将输入 a 和 b 相加，结果赋值给输出 out
endmodule
