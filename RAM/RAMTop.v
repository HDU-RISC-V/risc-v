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
   input clk,
	input Mem_Write,
	input[7:2] DM_Addr,
	input[1:0] MW_Data_s,
	input clk_dm,
	output[3:0] AN,
	output[7:0] seg
    );
	 wire [31:0] M_R_Data;
	 reg[31:0] M_W_Data;
	 reg[31:0] A = 32'b00000000_00000000_00000000_00000010;
	 reg[31:0] B = 32'b00000000_00000000_00000000_00000011;
	 reg[31:0] C = 32'b00000000_00000000_00000000_00000110;
	 reg[31:0] D = 32'b00000000_00000000_00000000_00000111;
	 initial begin 
		 A = 32'b00000000_00000000_00000000_00000010;
		 B = 32'b00000000_00000000_00000000_00000011;
		 C = 32'b00000000_00000000_00000000_00000110;
		 D = 32'b00000000_00000000_00000000_00000111;
	 end
	 
	 always@(*)begin
	 //if(MW_Data_s[1:0] == 2'b00)begin
	 //M_W_Data <= A;
	 //end
	 //else if(MW_Data_s[1:0] == 2'b01)begin
	 //M_W_Data <= B;
	 //end
	 //else if(MW_Data_s[1:0] == 2'b10)begin
	 //M_W_Data <= C;
	 //end
	 //else if(MW_Data_s[1:0] == 2'b11)begin
	 //M_W_Data <= D;
	 //end
	 
	 case(MW_Data_s)
	 2'b00:begin M_W_Data <= A; end
	 2'b01:begin M_W_Data <=B; end
	 2'b10:begin M_W_Data <=C; end
	 2'b11:begin M_W_Data <=D; end
	 endcase
	 //M_W_Data <= MW_Data_s;
	 end
	 
	 RAM RAM(
	 .Mem_Write(Mem_Write),
	 .DM_Addr(DM_Addr),
	 .M_W_Data(M_W_Data),
	 .clk_dm(clk_dm),
	 .M_R_Data(M_R_Data)
	 );
	 
	 LED led(
	 .clk(clk),
	 .Data(M_R_Data),
	 .AN(AN),
	 .seg(seg)
	 );
	 
	 
endmodule
