`timescale 1ns / 1ps
`include"./ALU/LED.v"
`include"RAM.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:07 04/20/2023 
// Design Name: 
// Module Name:    RAMTop 
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
module RAMTop(
   input clk,                 // 时钟信号
    input Mem_Write,           // 写使能信号
    input[7:2] DM_Addr,        // 读写地址
    input[1:0] MW_Data_s,      // 写入的数据选择信号
    input clk_dm,              // 存储器时钟信号
    output[3:0] AN,            // 数码管位选信号
    output[7:0] seg            // 数码管数值输出信号
    );
     wire [31:0] M_R_Data;       // 存储器读出数据
     reg[31:0] M_W_Data;         // 存储器写入数据
     reg[31:0] A = 32'b00000000_00000000_00000000_00000010; // 待写入的数据A
     reg[31:0] B = 32'b00000000_00000000_00000000_00000011; // 待写入的数据B
     reg[31:0] C = 32'b00000000_00000000_00000000_00000110; // 待写入的数据C
     reg[31:0] D = 32'b00000000_00000000_00000000_00000111; // 待写入的数据D
     
     initial begin 
         A = 32'b00000000_00000000_00000000_00000010; // 初始化待写入的数据A
         B = 32'b00000000_00000000_00000000_00000011; // 初始化待写入的数据B
         C = 32'b00000000_00000000_00000000_00000110; // 初始化待写入的数据C
         D = 32'b00000000_00000000_00000000_00000111; // 初始化待写入的数据D
     end
     
     always@(*)begin
     case(MW_Data_s)  // 根据MW_Data_s的值选择要写入的数据
		2'b00:begin M_W_Data <= A; end
		2'b01:begin M_W_Data <=B; end
		2'b10:begin M_W_Data <=C; end
		2'b11:begin M_W_Data <=D; end
     endcase
     end
     
     RAM RAM(                   // 实例化RAM模块
     .Mem_Write(Mem_Write),
     .DM_Addr(DM_Addr),
     .M_W_Data(M_W_Data),
     .clk_dm(clk_dm),
     .M_R_Data(M_R_Data)
     );
     
     LED led(                    // 实例化LED模块
     .clk(clk),
     .Data(M_R_Data),
     .AN(AN),
     .seg(seg)
     );
     
endmodule

