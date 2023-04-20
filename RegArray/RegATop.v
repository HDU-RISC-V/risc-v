include "./ALU/ALU.v" include "./ALU/LED.v"
include "./ALU/Reg.v" include "RegArray.v"

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 15:03:52 04/13/2023
// Design Name:
// Module Name: RegATop
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
	input clk, // 时钟信号输入
	input[4:0] R_Addr_A, // 读寄存器地址A输入
	input[4:0] R_Addr_B, // 读寄存器地址B输入
	input[4:0] W_Addr, // 写寄存器地址输入
	input[3:0] ALU_OP, // ALU操作信号输入
	input Reg_Write, // 寄存器写使能信号输入
	input clk_RR, // 寄存器读时钟信号输入
	input clk_F, // ALU操作时钟信号输入
	input clk_WB, // 寄存器写时钟信号输入
	output [3:0] AN, // 数码管段选信号输出
	output [7:0] seg, // 数码管段信号输出
	output reg [3:0] FR // 标志寄存器输出
);
	reg [31:0] F;          // 输出数据寄存器
	wire[31:0] R_Data_A;   // 读取数据A
	wire[31:0] R_Data_B;   // 读取数据B
	wire [31:0] Data_reg;  // ALU输出数据
	wire [3:0] Fr;         // ALU标志寄存器

	wire [31:0] R_Data_A_;
	wire [31:0] R_Data_B_;

	// 寄存器阵列实例化
	RegArray RegArr(
		.clk_Regs(clk_WB),
		.Reg_Write(Reg_Write),
		.R_Addr_A(R_Addr_A),
		.R_Addr_B(R_Addr_B),
		.W_Addr(W_Addr),
		.W_Data(F),
		.R_Data_A(R_Data_A),
		.R_Data_B(R_Data_B)
	);
	// 寄存器A实例化
	D_register u_D_registerA (
		.clk(clk_RR),
		.in(R_Data_A[31:0]),
		.out(R_Data_A_)
	);
	// 寄存器B实例化
	D_register u_D_registerB (
		.clk(clk_RR),
		.in(R_Data_B[31:0]),
		.out(R_Data_B_)
	);

	// ALU实例化
	ALU u_ALU (
		.a(R_Data_A_),
		.b(R_Data_B_),
		.op(ALU_OP),
		.out(Data_reg),
		.ZF(Fr[3]),
		.CF(Fr[2]),
		.OF(Fr[1]),
		.SF(Fr[0])
	);

	// LED实例化
	LED u_LED(
		.clk(clk),
	.Data(F),
	.AN(AN),
	.seg(seg)
	);
	// 时钟上升沿触发ALU输出数据和标志寄存器更新
	always @(posedge clk_F) begin
		F <= Data_reg;
		FR <= Fr;
	end

endmodule
