`timescale 1ns / 1ps
`include "..\ALU\ALU.v" 
`include "..\ALU\LED.v" 
`include "..\ALU\Reg.v" 
`include "RegArray.v" 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:52 04/13/2023 
// Design Name: 
// Module Name:    RegATop 
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
module RegATop(
	 input clk,
	 input[4:0] R_Addr_A,
	 input[4:0] R_Addr_B,
	 input[4:0] W_Addr,
	 input[3:0] ALU_OP,
	 input Reg_Write,
	 input rst_n,
	 input clk_RR,
	 input clk_F,
	 input clk_WB,
	 output [3:0] AN,
    output [7:0] seg,
	 output [3:0] FR
    );
	 reg [31:0] F;
	 wire[31:0] R_Data_A;
	 wire[31:0] R_Data_B;
	 reg [31:0] Data;
    wire [31:0] Data_reg;
    wire [3:0] Fr;
	 // RegArray
	 RegArray RegArr(
			.clk_Regs(clk_WB),
			.Reg_Write(Reg_Write),
			.R_Addr_A(R_Addr_A),
			.R_Addr_B(R_Addr_B),
			.W_Addr(W_Addr),
			.W_Data(W_Data),
			.R_Data_A(R_Data_A),
			.R_Data_B(R_Data_B)
	 );
	 // RegA
	 D_register u_D_registerA (
        .clk(clk_RR),
        .in(R_Data_A[31:0]),
        .out(R_Data_A[31:0])
    );
	 // RegB
	 D_register u_D_registerB (
        .clk(clk_RR),
        .in(R_Data_B[31:0]),
        .out(R_Data_B)
    );
	 
	 
	 	// ALU
    ALU u_ALU (
        .a(A),
        .b(B),
        .op(ALU_OP),
        .out(Data_reg),
		  .ZF(Fr[3]),
		  .CF(Fr[2]),
		  .OF(Fr[1]),
		  .SF(Fr[0])
    );

    // LED
    LED u_LED(
		  .clk(clk),
		  .Data(Data),
		  .AN(AN),
		  .seg(seg)
	 );

     always @(posedge clk_F) begin
        Data <= Data_reg;
     end

     always @(posedge clk_F) begin
            F <= Fr;
     end
	 
	 
endmodule
