`timescale 1ns / 1ps
`include"./IFID1/ID1.v"
`include"./IFID1/IF.v"
`include"./ALU/LED.v"
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
	input clk,
	input PC_Write,
	input IR_Write,
	input rst_n,
	input clk_im,
	input [2:0]SW,
	output [3:0]AN,
	output [7:0]seg,
	output reg [16:0]led
    );
	 
	 wire [31:0]imm32;
	 wire [31:0]inst32;
	 wire [31:0]pc32;
	 reg [31:0]data;
	 wire [4:0]rs1;
	 wire [4:0]rs2;
	 wire [4:0]rd;
	 wire [6:0]opcode;
	 wire [2:0]funct3;
	 wire [6:0]funct7;
	 
	 IF if0(
	 .IR_Write(IR_Write),
	 .PC_Write(PC_Write),
	 .clk_im(clk_im),
	 .inst(inst32),
	 .rst_n(rst_n),
	 .pc_out(pc32)
	 );
	 
	 ID1 id1(
    .inst(inst32),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .imm32(imm32)
	 );
	 
	 always@(*)begin
		if(SW[2]==0)begin led <= {rs1,rs2,rd}; end
		else begin led <= {opcode,funct3,funct7}; end
		case({SW[1],SW[0]})
		2'b00: begin data <= imm32; end
		2'b01: begin data <= inst32; end
		2'b10: begin data <= pc32; end
		endcase
	 end
	 
	 LED led3(
	 .clk(clk),
	 .Data(data),
	 .AN(AN),
	 .seg(seg)
	 );
	 
endmodule
