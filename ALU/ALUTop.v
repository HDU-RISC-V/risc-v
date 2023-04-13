`include "Reg.v"
`include "ALU.v"
`include "LED.v"

// ALUTop模块，连接D_register、ALU和LED模块，实现多功能ALU的顶层模块
module ALUTop(
    input clk,        // 通用时钟信号
    input clk_F,      // 用于控制数据寄存器和标志位寄存器的时钟信号
    input clk_A,      // 控制寄存器A的时钟信号
    input clk_B,      // 控制寄存器B的时钟信号
    input [31:0] SW,  // 32位开关信号，用于提供操作数和操作码
    output reg [3:0] F,   // 输出标志位，包括ZF、CF、OF和SF
    output [3:0] AN,      // 输出信号，用于控制LED的阵列
    output [7:0] seg      // 输出信号，用于控制LED的段选
);
    // D_register
    wire [31:0] A;     // 寄存器A的输出
    wire [31:0] B;     // 寄存器B的输出
    reg [31:0] Data;   // 数据寄存器，用于存储ALU的计算结果
    wire [31:0] Data_reg;  // ALU计算结果的临时存储
    wire [3:0] Fr;     // ALU输出的标志位

    // 实例化D_register模块，用于存储操作数A
    D_register u_D_registerA (
        .clk(clk_A),
        .in(SW[31:0]),
        .out(A)
    );

    // 实例化D_register模块，用于存储操作数B
    D_register u_D_registerB (
        .clk(clk_B),
        .in(SW[31:0]),
        .out(B)
    );
    
    // 实例化ALU模块，根据操作码执行相应的操作
    ALU u_ALU (
        .a(A),
        .b(B),
        .op(SW[3:0]),
        .out(Data_reg),
        .ZF(Fr[3]),
        .CF(Fr[2]),
        .OF(Fr[1]),
        .SF(Fr[0])
    );

    // 实例化LED模块，用于显示ALU的计算结果和标志位
    LED u_LED(
        .clk(clk),
        .Data(Data),
        .AN(AN),
        .seg(seg)
    );

    // 在clk_F上升沿时，将ALU的计算结果存储到数据寄存器中
    always @(posedge clk_F) begin
        Data <= Data_reg;
    end

    // 在clk_F上升沿时，将ALU输出的标志位存储到标志位寄存器中
    always @(posedge clk_F) begin
        F <= Fr;
    end

endmodule
