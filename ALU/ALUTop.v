`include "Reg.v"
`include "ALU.v"
`include "LED.v"

module ALUTop(
    input clk,
	input clk_F,
	input clk_A,
	input clk_B,
	input [31:0] SW,
   output reg [3:0] F,
   output [3:0] AN,
   output [7:0] seg
);
	// D_register
	wire [31:0] A;
	wire [31:0] B;
	reg [31:0] Data;
    wire [31:0] Data_reg;
    wire [3:0] Fr;
	
	// D_register
    D_register u_D_registerA (
        .clk(clk_A),
        .in(SW[31:0]),
        .out(A)
    );

    D_register u_D_registerB (
        .clk(clk_B),
        .in(SW[31:0]),
        .out(B)
    );
	
	// ALU
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