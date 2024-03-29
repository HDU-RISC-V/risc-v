`timescale 1ns / 1ps
`include "ALU/ALU.v" 
`include "ALU/LED.v" 
`include "ALU/Reg.v" 

`include"IFID1/ID1.v"
`include"IFID1/IF.v"

`include"RegArray/RegArray.v"

`include"CU.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:41 05/25/2023 
// Design Name: 
// Module Name:    CPUTop 
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
module CPUTop(
    input rst_n,
	 input clk,
	 input clk_LED,
	 input [2:0]SW,
	 output reg [3:0]FR,
	 output [3:0]AN,
	 output [7:0]seg,
	 output t1,
	 output t2,
	 output rs2imms,
	 output wdatas
	 );
	 assign t1 = clk;
	 assign t2 = rst_n;
	 assign rs2imms = rs2_imm_s;
	 assign wdatas = w_data_s;
	 
	//reg _clk;
	//always begin _clk=~clk;end
	
	wire PC_Write;
	wire IR_Write;
	// wire clk_im=clk;
	
	wire [4:0]rs1;
	wire [4:0]rs2;
	wire [4:0]rd;
	wire [6:0]opcode;
	wire [2:0]funct3;
	wire [6:0]funct7;
	wire [31:0]imm32;
	wire [31:0]inst32;
	wire [31:0]pc32;
	 
	 
	 IF if0(
	 .IR_Write(IR_Write),
	 .PC_Write(PC_Write),
	 .clk_im(clk),/////////////////////////////////
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
	 
	 
	 wire Reg_Write;
	 wire [3:0]ALU_OP;
	 wire rs2_imm_s;
	 wire w_data_s;
	 CU cu(
	.opcode(opcode),
	.funct3(funct3),
	.funct7(funct7),
	.rst_n(rst_n),
	.clk(clk),
	.PC_Write(PC_Write),
	.IR_Write(IR_Write),
	.Reg_Write(Reg_Write),
	.ALU_OP(ALU_OP),
	.rs2_imm_s(rs2_imm_s),
	.w_data_s(w_data_s)
	);
	
	
	wire [31:0] A;
	wire [31:0] B;
	wire [31:0] R_Data_A;
	wire [31:0] R_Data_B;
	reg [31:0] W_Data;
	 // RegArray
	 RegArray RegArr(
			.clk_Regs(~clk),
			.Reg_Write(Reg_Write),
			.R_Addr_A(rs1),
			.R_Addr_B(rs2),
			.W_Addr(rd),
			.W_Data(W_Data),
			.R_Data_A(R_Data_A),
			.R_Data_B(R_Data_B)
	 );
	 // RegA
	 D_register u_D_registerA (
        .clk(~clk),
        .in(R_Data_A[31:0]),
        .out(A)
    );
	 // RegB
	 D_register u_D_registerB (
        .clk(~clk),
        .in(R_Data_B[31:0]),
        .out(B)
    );
	 
	 wire [31:0] Data_reg;
	 reg [31:0]ALU_B;
	 wire [3:0]Fr;
	 	// ALU
    ALU u_ALU (
        .a(A),
        .b(ALU_B),
        .op(ALU_OP),
        .out(Data_reg),
		  .ZF(Fr[3]),
		  .CF(Fr[2]),
		  .OF(Fr[1]),
		  .SF(Fr[0])
    );
	 
	 reg [31:0]DATA_OUTPUT;
	 reg [31:0]F;
	 
	  always @(*) begin
	  if (rs2_imm_s==0)begin ALU_B<=B;end
		else begin ALU_B<=imm32; end
	  if (w_data_s==0)begin W_Data<=F; end
		else begin W_Data<=imm32; end
     if (clk==0)begin 
		  F <= Data_reg;
		  FR <= Fr; end
	  case({SW[2],SW[1],SW[0]})
	  3'b000:begin DATA_OUTPUT<=pc32; end
	  3'b001:begin DATA_OUTPUT<=inst32; end
	  3'b010:begin DATA_OUTPUT<=W_Data; end
	  3'b011:begin DATA_OUTPUT<=A; end
	  3'b100:begin DATA_OUTPUT<=B; end
	  3'b101:begin DATA_OUTPUT<=F; end
	  endcase
     
	  end
	 
	 LED u_LED(
        .clk(clk_LED),
        .Data(DATA_OUTPUT),
        .AN(AN),
        .seg(seg)
    );
endmodule
