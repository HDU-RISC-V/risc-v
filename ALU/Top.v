`include "Reg.v"
`include "ALU.v"
`include "LED.v"
`include "FR.v"

module Top(
    input clk,
	input clk_F,
	input clk_A,
	input clk_B,
	input rst_n,
	input [31:0] SW,
   output [3:0] F,
   output [3:0] AN,
   output [7:0] seg
);
	// D_register
	wire [31:0] A;
	wire [31:0] B;
	wire [31:0] Data;
    wire [3:0] Fs;
	
	// D_register
    D_register u_D_registerA (
        .clk(clk_A),
        .rst_n(rst_n),
        .in(SW[31:0]),
        .out(A)
    );

    D_register u_D_registerB (
        .clk(clk_B),
        .rst_n(rst_n),
        .in(SW[31:0]),
        .out(B)
    );
	
	// ALU
    ALU u_ALU (
        .rst_n(rst_n),
        .a(A),
        .b(B),
        .op(SW[3:0]),
        .out(Data),
		  .ZF(Fs[3]),
		  .CF(Fs[2]),
		  .OF(Fs[1]),
		  .SF(Fs[0])
    );

    // FR
    FR u_FR (
        .clk(clk_F),
        .rst_n(rst_n),
        .in(Fs),
        .out(F)
    );
    
    LED u_LED(
		  .clk(clk),
		  .Data(Data),
		  .AN(AN),
		  .seg(seg)
	 );

	 
endmodule