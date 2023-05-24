`timescale 1ns / 1ps
`include "./IFID1/ID1.v"  // 包含 ID1 模块的代码文件
`include "./IFID1/IF.v"   // 包含 IF 模块的代码文件
`include "./ALU/LED.v"    // 包含 LED 模块的代码文件

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:12 05/11/2023 
// Design Name: 
// Module Name:    IFIDETop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IFIDETop(
    input clk,              // 输入时钟信号 clk
    input PC_Write,         // 输入信号 PC_Write
    input IR_Write,         // 输入信号 IR_Write
    input rst_n,            // 输入复位信号 rst_n
    input clk_im,           // 输入时钟信号 clk_im
    input [2:0] SW,         // 输入开关信号 SW，3位宽
    output [3:0] AN,        // 输出数码管控制信号 AN，4位宽
    output [7:0] seg,       // 输出数码管段选信号 seg，8位宽
    output reg [16:0] led   // 输出 LED 信号 led，17位宽
);
     
    wire [31:0] imm32;       // 内部信号 imm32，为 32 位宽
    wire [31:0] inst32;      // 内部信号 inst32，为 32 位宽
    wire [31:0] pc32;        // 内部信号 pc32，为 32 位宽
    reg [31:0] data;         // 内部寄存器 data，为 32 位宽
    wire [4:0] rs1;          // 内部信号 rs1，为 5 位宽
    wire [4:0] rs2;          // 内部信号 rs2，为 5 位宽
    wire [4:0] rd;           // 内部信号 rd，为 5 位宽
    wire [6:0] opcode;       // 内部信号 opcode，为 7 位宽
    wire [2:0] funct3;       // 内部信号 funct3，为 3 位宽
    wire [6:0] funct7;       // 内部信号 funct7，为 7 位宽
     
    IF if0 (
        .IR_Write(IR_Write),        // 输入端口 IR_Write
        .PC_Write(PC_Write),        // 输入端口 PC_Write
        .clk_im(clk_im),            // 输入端口 clk_im
        .inst(inst32),              // 输出端口 inst 连接 inst32
        .rst_n(rst_n),              // 输入端口 rst_n
        .pc_out(pc32)               // 输出端口 pc_out 连接 pc32
    );
     
    ID1 id1 (
        .inst(inst32),              // 输入端口 inst 连接 inst32
        .rs1(rs1),                  // 输出端口 rs1 连接 rs1
        .rs2(rs2),                  // 输出端口 rs2 连接 rs2
        .rd(rd),                    // 输出端口 rd 连接 rd
        .opcode(opcode),            // 输出端口 opcode 连接 opcode
        .funct3(funct3),            // 输出端口 funct3 连接 funct3
        .funct7(funct7),            // 输出端口 funct7 连接 funct7
        .imm32(imm32)               // 输出端口 imm32 连接 imm32
    );
     
    always @(*) begin
        if (SW[2] == 0) begin
            led <= {rs1, rs2, rd};   // 如果开关 SW[2] 等于 0，led 的值为 {rs1, rs2, rd}
        end
        else begin
            led <= {opcode, funct3, funct7};  // 否则，led 的值为 {opcode, funct3, funct7}
        end
        
        case ({SW[1], SW[0]})  // 根据开关 SW[1] 和 SW[0] 进行选择
            2'b00: begin  // 如果 SW[1:0] 等于 2'b00
                data <= imm32;  // data 的值为 imm32
            end
            2'b01: begin  // 如果 SW[1:0] 等于 2'b01
                data <= inst32;  // data 的值为 inst32
            end
            2'b10: begin  // 如果 SW[1:0] 等于 2'b10
                data <= pc32;  // data 的值为 pc32
            end
        endcase
    end
     
    LED led3 (
        .clk(clk),          // 输入端口 clk
        .Data(data),        // 输入端口 Data 连接 data
        .AN(AN),            // 输出端口 AN 连接 AN
        .seg(seg)           // 输出端口 seg 连接 seg
    );
     
endmodule
