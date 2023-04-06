module Top(
	input clk,
	input clk_F,
	input clk_A,
	input clk_B,
	input rst_n,
	input [31:0] SW,
   output [3:0] FR,
   output [3:0] AN,
   output [7:0] seg
);
	// D_register
	reg [31:0] A;
	reg [31:0] B;
	reg [31:0] Data;
	
	// D_register
    D_register u_D_registerA (
        .clk(clk_A),
        .n_rst(n_rst),
        .in(SW[31:0]),
        .out(A)
    );

    D_register u_D_registerB (
        .clk(clk_B),
        .n_rst(n_rst),
        .in(SW[31:0]),
        .out(B)
    );
	
	// ALU
    ALU u_ALU (
        .clk(clk),
        .n_rst(rst_n),
        .a(A),
        .b(B),
        .op(SW[3:0]),
        .out(Data),
		  .ZF(FR[3]),
		  .CF(FR[2]),
		  .OF(FR[1]),
		  .SF(FR[0])
    );
    
    LED u_LED(
		  .clk(clk),
		  .Data(Data),
		  .AN(AN),
		  .seg(seg)
	 );
    
	 
endmodule