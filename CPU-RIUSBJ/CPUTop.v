`timescale 1ns / 1ps
`include "ALU/ALU.v" 
`include "ALU/LED.v" 
`include "ALU/Reg.v" 

`include"IFID1/ID1.v"
`include"IFID1/ADD.v"
`include"IFID1/PC.v"
`include"IFID1/IR.v"
`include"IFID1/IM.v"


`include"RegArray/RegArray.v"

`include"CU.v"
`include"DM.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:46:33 06/08/2023 
// Design Name: 
// Module Name:    CPUtop 
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
module CPUtop(

	 input rst_n,
	 input clk,
	 input clk_LED,
	 input [2:0]SW,
	 output reg [3:0]FR,
	 output [3:0]AN,
	 output [7:0]seg
	 );


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


	wire [31:0]MDR;
	wire [31:0]Reg_MDR;
	reg [31:0]DATA_OUTPUT;
	reg [31:0]F;

	/*
	IF if0(
	.IR_Write(IR_Write),
	.PC_Write(PC_Write),
	.clk_im(clk),/////////////////////////////////
	.inst(inst32),
	.rst_n(rst_n),
	.pc_out(pc32)
	);*/

	wire [31:0] _pc_out;
	reg [31:0] add_out;
	wire [31:0] add_out_0;
	wire [31:0] im_out;
	wire [31:0] add_out_1;
	reg [31:0] PC0;
	wire PC0_Write;
	wire PC_s;
	
	always@(posedge clk or posedge PC0_Write ) begin
	if (PC0_Write == 1)begin PC0 <= pc32; end
	end

	always@(*)begin
	if(PC_s == 0)begin add_out<=add_out_0; end
	else if(PC_s == 1)begin add_out<=add_out_1; end
	else if(PC_s == 2)begin add_out<=F; end
	end



	ADD add_0(
	.a(_pc_out),
	.b(4),
	.out(add_out_0)
	);
	
	PC pc_0(
	.PC_In(add_out),
	.PC_Write(PC_Write),
	.clk(~clk),
	.rst_n(rst_n),
	.PC_Out(_pc_out)
	);
	
	/*
	IM im_0(
	.IM_Addr(_pc_out[7:2]),
	.clk_im(clk),
	.Inst_Code(im_out)
	);
	*/
	/*
	ROM rom(
	clk,
	_pc_out[7:2],
	im_out
	);*/
	
	ROM your_instance_name (
  .clka(clk), // input clka
  .addra(_pc_out[7:2]), // input [5 : 0] addra
  .douta(im_out) // output [31 : 0] douta
	);

	IR ir_0(
	.IR_In(im_out),
	.IR_Write(IR_Write),
	.clk(~clk_im),
	.IR_Out(inst32)
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

	wire Mem_Write;
	wire Reg_Write;
	wire [3:0]ALU_OP;
	wire rs2_imm_s;
	wire [1:0]w_data_s;

	CU cu(
	.opcode(opcode),
	.funct3(funct3),
	.funct7(funct7),
	.rst_n(rst_n),
	.clk(clk),
	.ZF(FR[3]),
	.ALU_OP(ALU_OP),
	.rs2_imm_s(rs2_imm_s),
	.w_data_s(w_data_s),
	.Reg_Write(Reg_Write),
	.IR_Write(IR_Write),
	.PC_Write(PC_Write),
	.PC0_Write(PC0_Write),
	.PC_s(PC_s),
	.Mem_Write(Mem_Write)
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
	
	ADD add_1(
	.a(PC0),
	.b(imm32),
	.out(add_out_1)
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



	DM dm(
	.Mem_Write(Mem_Write),
	.DM_Addr(F),
	.M_W_Data(B),
	.clk_dm(clk),
	.M_R_Data(Reg_MDR)
	);

	D_register u_D_registerMDR (
	  .clk(~clk),
	  .in(Reg_MDR[31:0]),
	  .out(MDR)
	);


	always @(*) begin
	if (rs2_imm_s==0)begin ALU_B<=B;end
	else begin ALU_B<=imm32; end

	if (w_data_s==0)begin W_Data<=F; end
	else if(w_data_s==1) begin W_Data<=imm32; end
	else if(w_data_s==2) begin W_Data<=MDR; end
	else if(w_data_s==3) begin W_Data<=pc32; end///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////mark

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
	3'b110:begin DATA_OUTPUT<=MDR; end
	endcase

	end

	LED u_LED(
	  .clk(clk_LED),
	  .Data(DATA_OUTPUT),
	  .AN(AN),
	  .seg(seg)
	);
endmodule

